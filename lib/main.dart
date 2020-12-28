import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              centerTitle: true,
              // textTheme: TextTheme(headline3: TextStyle(color: Colors.black)),
              actionsIconTheme: IconThemeData(
                color: Colors.black,
              ),
              color: Colors.blue[200],
              shadowColor: Colors.tealAccent[700]),
          fontFamily: "ProductSans"),
      home: Splash(),
    );
  }
}
