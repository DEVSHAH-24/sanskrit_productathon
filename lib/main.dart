import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanskrit_project/pages/login.dart';

import './pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sanskritive',
      theme: ThemeData(fontFamily: "ProductSans"),
      home: Splash(),
    );
  }
}
