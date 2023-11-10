import 'package:flutter/material.dart';
import 'shared/app/app.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'configs/locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await di.init();


  runApp(App());
}
