import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class NotificationManager {
  static init({required BuildContext context}) {}

  static handleNotificationMsg(RemoteMessage message, BuildContext context) {
    if (message.notification != null) {
      player.play(AssetSource('ringing.mp3'));
      player.setReleaseMode(ReleaseMode.loop);

      showDialog(
        barrierDismissible: false,
        barrierColor: const Color(0x00000000),
        context: context,
        builder: (context) => AlertDialog(
          titlePadding: EdgeInsets.only(
              left: context.mediaQueryWidth * 0.03,
              right: context.mediaQueryWidth * 0.03,
              top: context.mediaQueryWidth * 0.03
          ),
          actionsPadding: EdgeInsets.symmetric(
            horizontal: context.mediaQueryWidth * 0.03,
            vertical: context.mediaQueryWidth * 0.03
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Container(
            height: context.mediaQueryWidth / 1.2,
            width: context.mediaQueryWidth / 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    splashBackgroundColor,
                    Colors.white,
                    splashBackgroundColor
                  ],
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: context.mediaQueryWidth/11,
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.white],
                        ),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/dashboard_screen/tapImage.png'))),
                  ),
                ),
                Text(
                  'Valve is open',
                  style: TextStyle(
                    fontSize: context.mediaQueryWidth / 15,
                  ),
                ),
                Text(DateFormat('yyyy-MM-dd \nh:m:s a').format(DateTime.now()), style: TextStyle(
                  fontSize: context.mediaQueryWidth / 22,
                ),)
              ],
            ),
          ),
          actions: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: context.mediaQueryWidth / 10,
              minWidth: double.infinity,
              color: splashBackgroundColor,
              onPressed: () {
                player.stop();
                Get.back();
              },
              child:  Text(
                'OK',
                style: TextStyle(fontSize: context.mediaQueryWidth/25, color: Colors.white),
              ),
            )
          ],
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }
}
