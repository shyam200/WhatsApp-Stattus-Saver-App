import 'package:flutter/material.dart';

import 'main_page/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000)).then((value) =>
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const Mainpage())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(child: Icon(Icons.sports_volleyball_sharp)));
  }
}
