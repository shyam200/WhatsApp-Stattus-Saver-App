import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_layer/image_bloc/main_page_bloc.dart';
import '../../business_layer/image_bloc/main_page_event.dart';
import '../../business_layer/image_bloc/main_page_state.dart';
import '../../core/widgets/ws_common_dialog.dart';
import '../../injection/injection_container.dart';
import '../../resources/string_keys.dart';
import '../../resources/text_styles.dart';
import '../image_page/image_page.dart';
import '../video_page/video_page.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  late MainPageBloc _mainPageBloc;
  List<File>? filesList;
  bool isGranted = false;
  @override
  void initState() {
    super.initState();
    _mainPageBloc = di<MainPageBloc>();
    //Fire initial event on start up to check if permission is given or not if not then ask permission
    // _mainPageBloc.add(GetGalleryPermissionEvent());
    _mainPageBloc.add(GetGalleryPermissionStatusEvent());
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _mainPageBloc,
      listener: (context, state) {
        if (state is GalleryFilesLoadedState) {
          filesList = state.filesList;
        } else if (state is GalleryPermissionDialogState) {
          _showSeekPermissionDialog();
        } else if (state is GalleryPermissionAllowedState) {
          _mainPageBloc.add(GetGalleryPermissionEvent());
        } else if (state is GalleryPermissionTemporarilyDeniedState) {
          isGranted = false;
          // _showSeekPermissionDialog();
        } else if (state is GalleryPermissionGrantedState) {
          isGranted = true;
          _mainPageBloc.add(GetWhatsAppStatusesEvent(state.dirPath));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: !isGranted
              ? _buildNoPermissionBody()
              : _getNavigationBaritemBody()[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white70,
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
      BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Image'),
      BottomNavigationBarItem(icon: Icon(Icons.video_file), label: 'Video')
    ];
  }

  List<Widget> _getNavigationBaritemBody() {
    return [
      ImagePage(
        bloc: _mainPageBloc,
        filesList: filesList ?? [],
      ),
      Videopage(
        bloc: _mainPageBloc,
        filesList: filesList ?? [],
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
