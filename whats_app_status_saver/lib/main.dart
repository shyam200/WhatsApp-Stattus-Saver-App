import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'injection/injection_container.dart' as di;
import 'presentation_layer/main_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  //keep splash screen untill initializtion has complete
  FlutterNativeSplash.remove();
  runApp(const HomePage());
}
