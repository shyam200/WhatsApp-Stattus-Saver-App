import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_status_saver/business_layer/image_bloc/main_page_bloc.dart';
import 'package:whats_app_status_saver/injection/injection_container.dart';

import '../image_page/image_page.dart';
import '../video_page/video_page.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  late MainPageBloc _mainPageBloc;
  @override
  void initState() {
    super.initState();
    _mainPageBloc = di<MainPageBloc>();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _mainPageBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: _getNavigationBaritemBody()[_currentIndex],
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
      ),
      Videopage(bloc: _mainPageBloc)
    ];
  }

  _onNavigationBarTapped(index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
