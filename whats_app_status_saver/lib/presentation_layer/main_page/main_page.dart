import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_layer/main_page_bloc/main_page_bloc.dart';
import '../../business_layer/main_page_bloc/main_page_event.dart';
import '../../business_layer/main_page_bloc/main_page_state.dart';
import '../../core/widgets/ws_common_dialog.dart';
import '../../core/widgets/ws_loader.dart';
import '../../injection/injection_container.dart';
import '../../resources/dimension_keys.dart';
import '../../resources/images.dart';
import '../../resources/string_keys.dart';
import '../../resources/text_styles.dart';
import '../image_page/image_page.dart';
import '../video_page/video_page.dart';
import 'widgets/ws_drawer.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> with WidgetsBindingObserver {
  late MainPageBloc _mainPageBloc;
  List? imagesList;
  List<File>? videosList;
  bool isPermissionGranted = false;
  int _currentIndex = 0;
  bool isAndroidBelow10 = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _mainPageBloc = di<MainPageBloc>();
    //Fire initial event on start up to check if permission is given or not if not then ask permission
    // _mainPageBloc.add(GetGalleryPermissionEvent());

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _mainPageBloc.add(const CheckGalleryPermissionStatusEvent());
    });
  }

  //ApplifeCylcle state to syn directories each time when user comes forground
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (AppLifecycleState.resumed == state) {
      _mainPageBloc
          .add(const CheckGalleryPermissionStatusEvent(isResumeState: true));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _mainPageBloc,
      listener: (context, state) {
        if (state is GalleryFilesLoadedState) {
          imagesList = state.imageFilesList;
          videosList = state.videoFilesList;
        } else if (state is GalleryPermissionAllowedState) {
          isPermissionGranted = true;
          _mainPageBloc.add(GetWsFilesEvent());
        } else if (state is GalleryPermissionNotAllowedState) {
          isPermissionGranted = false;
          isAndroidBelow10 = state.isAndroidBelow10;
          if (!state.isResumeState) {
            _showSeekPermissionDialog();
          }
        } else if (state is TechnicalErrorState) {
          //Permission not granted, reason could be:-
          // status directory not found since whatsApp not installed
          // whatsApp installed but not setUp yet
          _showErrorDialog();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              StringKeys.wsAppTitle,
              style: appTextTheme(context)
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          drawer: WSDrawer(
            bloc: _mainPageBloc,
          ),
          body: Stack(
            children: [
              !isPermissionGranted
                  ? _buildNoPermissionBody()
                  : state is MainPageLoadingState
                      ? const WsLoader()
                      : _getNavigationBarItemBody()[_currentIndex],
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _getNavigationBarItems(),
            currentIndex: _currentIndex,
            onTap: _onNavigationBarTapped,
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _getNavigationBarItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.image),
        label: StringKeys.imageLabel,
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.video_file), label: StringKeys.videoLabel)
    ];
  }

  List<Widget> _getNavigationBarItemBody() {
    return [
      ImagePage(
        imagesList: imagesList ?? [],
      ),
      Videopage(
        filesList: videosList ?? [],
      )
    ];
  }

  _buildNoPermissionBody() {
    return Center(
      child: TextButton(
          style: Theme.of(context).textButtonTheme.style?.copyWith(
              fixedSize: const MaterialStatePropertyAll(Size(200, 60)),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))))),
          onPressed: () {
            _showSeekPermissionDialog();
          },
          child: Text(
            StringKeys.getPermissionTxt,
            style: appTextTheme(context).labelLarge,
          )),
    );
  }

  _showSeekPermissionDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return WSCommonDialog(
              headingText: isAndroidBelow10
                  ? StringKeys.getPermissionTxt
                  : StringKeys.getPermissionHeading,
              subHeadingText:
                  isAndroidBelow10 ? null : StringKeys.getPermissionSubHeading,
              body: isAndroidBelow10
                  ? Text(
                      StringKeys.getPermissionSubHeadingOlderAndroid,
                      style: appTextTheme(context)
                          .bodyMedium
                          ?.copyWith(color: Colors.blueGrey[800]),
                    )
                  : SizedBox(
                      height: DimensionKeys.permissionDialogHeight,
                      width: MediaQuery.of(context).size.width - 40,
                      child: Image.asset(
                        Images.wsPermissionImg,
                        fit: BoxFit.fill,
                      ),
                    ),
              showPositiveBtn: true,
              showNegativeBtn: true,
              positiveBtnText: StringKeys.allow,
              positiveBtnCallback: () {
                _mainPageBloc.add(GetGalleryPermissionEvent());
                Navigator.of(context).pop();
              });
        });
  }

  _onNavigationBarTapped(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return WSCommonDialog(
            headingText: StringKeys.errorTitle,
            body: Text(StringKeys.whatsAppNotSetUpText,
                style: appTextTheme(context)
                    .bodyMedium
                    ?.copyWith(color: Colors.blueGrey[900])),
            showPositiveBtn: true,
          );
        });
  }
}
