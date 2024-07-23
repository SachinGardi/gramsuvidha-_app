import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/utilityColor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Future<bool> getRegisteredValue() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool('Register') ?? false;
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      Get.offAllNamed('/registrationOtp');
      /*   SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getBool('isShown') == true) {
        Get.offAllNamed('/registrationOtp');
      } else {
        Get.offAllNamed('/chooseLanguage');
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: splashBackgroundColor,
        body: Center(
          child: SvgPicture.asset('assets/images/splash_screen/Gram Logo.svg'),
        ));
  }
}
