import 'package:flutter/material.dart';
// import 'screens/ride_pref/ride_pref_screen.dart';
import 'theme/theme.dart';
import 'ui/screens/bla_button_test_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: BlaButtonTestScreen()),
      // home: Scaffold(body: RidePrefScreen()),
    );
  }
}
