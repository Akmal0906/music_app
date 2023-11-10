import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:music_app/presentation/view/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    waitFunc(context);
  }

  waitFunc(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      //  context.go("main");
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context)=>const MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.yellow.shade200,
              Colors.yellow.shade200,
              Colors.yellow.shade400,
              Colors.yellow.shade400,
              Colors.yellow.shade600,
              Colors.yellow.shade800,
              Colors.yellow.shade800,
              Colors.yellow.shade900,
              Colors.yellow.shade900,
            ])),
        child: SvgPicture.asset(
          'assets/images/splash_music.svg',
          fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
