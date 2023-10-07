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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _mainPageBloc = di<MainPageBloc>();
    //Fire initial event on start up to check if permission is given or not if not then ask permission
    // _mainPageBloc.add(GetGalleryPermissionEvent());
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _mainPageBloc.add(CheckGalleryPermissionStatusEvent());
    });
  }

  //ApplifeCylcle state to syn directories each time when user comes forground
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (AppLifecycleState.resumed == state) {
      _mainPageBloc.add(CheckGalleryPermissionStatusEvent());
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
          _showSeekPermissionDialog();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          drawer: WSDrawer(
            bloc: _mainPageBloc,
          ),
          body: Stack(
            children: [
              !isPermissionGranted
                  ? _buildNoPermissionBody()
                  : _getNavigationBarItemBody()[_currentIndex],
              state is MainPageLoadingState
                  ? const WsLoader()
                  : const SizedBox(),
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
        label: 'Image',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.video_file), label: 'Video')
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
          onPressed: () {
            _showSeekPermissionDialog();
          },
          child: const Text(
            StringKeys.getPermissionTxt,
            style: TextStyle(fontSize: 18),
          )),
    );
  }

  _showSeekPermissionDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return WSCommonDialog(
              headingText: 'Allow Permission',
              body: const Text(
                'Dear user you need to allow media permission to access and download status.',
                style: TextStyles.bodyText,
              ),
              positiveBtnText: 'Allow',
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
}
