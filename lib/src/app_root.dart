
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location_tracker/ui/splash_screen.dart';

class AppRoot extends StatelessWidget{
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(useMaterial3: false),

    );
  }

}