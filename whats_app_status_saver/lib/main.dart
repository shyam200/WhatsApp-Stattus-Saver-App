import 'package:flutter/material.dart';

import 'injection/injection_container.dart' as di;
import 'presentation_layer/main_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const HomePage());
}
