/// Dialog in future to modify ui of dialog box
import 'package:flutter/material.dart';
import 'package:gramsuvidha/main.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:intl/intl.dart';
import '../utility/utilityColor.dart';

class NotificationDialog extends StatefulWidget {
  const NotificationDialog({Key? key}) : super(key: key);

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () {
            showDialog(
              barrierColor: const Color(0x00000000),
              context: context,
              builder: (context) => AlertDialog(
                titlePadding: EdgeInsets.only(
                  left: context.mediaQueryWidth * 0.02,
                  right: context.mediaQueryWidth * 0.02,
                    top: context.mediaQueryWidth * 0.02
                ),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                title: Container(
                  height: context.mediaQueryWidth / 1.2,
                  width: context.mediaQueryWidth / 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
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
                      Text(DateFormat('yyyy-MM-dd \nH:m:s a')
                          .format(currentDate),
                      style: TextStyle(
                        fontSize: context.mediaQueryWidth/22
                      ),
                      )
                    ],
                  ),
                ),
                actions: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    height: context.mediaQueryWidth / 10,
                    minWidth: double.infinity,
                    color: splashBackgroundColor,
                    onPressed: () {},
                    child:  Text(
                      'OK',
                      style: TextStyle(fontSize: context.mediaQueryWidth/25, color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          },
          child: const Text('ShowDialog'),
        ),
      ),
    );
  }
}
