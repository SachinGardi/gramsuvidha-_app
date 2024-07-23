import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utility/utilityColor.dart';

class SplashScreenStart extends StatefulWidget {
  const SplashScreenStart({Key? key}) : super(key: key);

  @override
  State<SplashScreenStart> createState() => _SplashScreenStartState();
}

class _SplashScreenStartState extends State<SplashScreenStart> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Get.offAndToNamed('/splashscreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashBackgroundColor,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GRAM',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                    // fontFamily: 'Montserrat-Light'
                  ),
                ),
                Text(
                  'SUVIDHA',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      decoration: TextDecoration.underline
                      // fontFamily: 'Montserrat-Light'
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
