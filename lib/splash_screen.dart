import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/presentation/view/main_screen.dart';
import 'package:music_app/utlis/all_colors/all_color_screen.dart';

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
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()));
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
            color: AllColors.backColor,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AllColors.backColor,
                  AllColors.backColor.withOpacity(0.9),
                  AllColors.backColor.withOpacity(0.9),
                  AllColors.backColor,
                ])),
        child: SvgPicture.asset(
          'assets/images/splash_music.svg',
          fit: BoxFit.cover,
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
