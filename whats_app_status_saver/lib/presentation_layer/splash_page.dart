import 'package:flutter/material.dart';
import 'package:whats_app_status_saver/presentation_layer/main_page/main_page.dart';

import 'image_page/image_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 1000)).then((value) =>
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Mainpage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Icon(Icons.sports_volleyball_sharp)));
  }
}
