import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';

import '../utility/utilityColor.dart';

class ShareAppScreen extends StatefulWidget {
  const ShareAppScreen({Key? key}) : super(key: key);

  @override
  State<ShareAppScreen> createState() => _ShareAppScreenState();
}

class _ShareAppScreenState extends State<ShareAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashBackgroundColor,
        centerTitle: true,
        title: Text(
          'shareAppTitle'.tr,
          style: TextStyle(fontSize: context.mediaQueryWidth / 21),
        ),
        leading: IconButton(
          enableFeedback: true,
          splashRadius: context.mediaQueryWidth/22,
          icon: const Icon(
            Icons.arrow_back,
            size: 22,
          ),
          onPressed: () {
            setState(() {
              Get.back();
            });
          },
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: Stack(
          children: [
            ///link box and circle avatar
            Container(
              margin: EdgeInsets.only(top: context.mediaQueryHeight * 0.25),
              height: double.infinity,
              child: ListView.custom(
                  childrenDelegate: SliverChildListDelegate([
                ///Facebook
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.mediaQueryWidth / 100,
                          left: context.mediaQueryWidth / 9,
                          right: context.mediaQueryWidth / 15),
                      child: Container(
                        height: context.mediaQueryWidth / 6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 5)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: context.mediaQueryWidth / 8),
                                  child: Text(
                                    'faceBook'.tr,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                )),
                            const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 10,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                      ),
                    ),

                    ///circle avatar
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.mediaQueryWidth / 30,
                          left: context.mediaQueryWidth / 20),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ]),
                        child: CircleAvatar(
                          radius: context.mediaQueryWidth / 16,
                          backgroundColor: Colors.white,
                          child: Image(
                              image: const AssetImage(
                                  'assets/images/share_app_screen/facebook.png'),
                              height: context.mediaQueryWidth / 10),
                        ),
                      ),
                    ),
                  ],
                ),

                ///Gmail
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.mediaQueryWidth / 30,
                          left: context.mediaQueryWidth / 9,
                          right: context.mediaQueryWidth / 15),
                      child: Container(
                        height: context.mediaQueryWidth / 6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 5)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: context.mediaQueryWidth / 8),
                                  child: Text(
                                    'email'.tr,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                )),
                            const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 10,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                      ),
                    ),

                    ///circle avatar
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.mediaQueryWidth / 18,
                          left: context.mediaQueryWidth / 20),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ]),
                        child: CircleAvatar(
                          radius: context.mediaQueryWidth / 16,
                          backgroundColor: Colors.white,
                          child: Image(
                              image: const AssetImage(
                                  'assets/images/share_app_screen/gmail.png'),
                              height: context.mediaQueryWidth / 8),
                        ),
                      ),
                    ),
                  ],
                ),

                ///Whatsapp
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.mediaQueryWidth / 30,
                          left: context.mediaQueryWidth / 9,
                          right: context.mediaQueryWidth / 15),
                      child: Container(
                        height: context.mediaQueryWidth / 6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 5)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: context.mediaQueryWidth / 8),
                                  child: Text(
                                    'whatsapp'.tr,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                )),
                            const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 10,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                      ),
                    ),

                    ///circle avatar
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.mediaQueryWidth / 18,
                          left: context.mediaQueryWidth / 20),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ]),
                        child: CircleAvatar(
                          radius: context.mediaQueryWidth / 16,
                          backgroundColor: Colors.white,
                          child: Image(
                              image: const AssetImage(
                                  'assets/images/share_app_screen/whatsapp.png'),
                              height: context.mediaQueryWidth / 9.5),
                        ),
                      ),
                    ),
                  ],
                ),

                ///SMS
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.mediaQueryWidth / 30,
                          left: context.mediaQueryWidth / 9,
                          right: context.mediaQueryWidth / 15),
                      child: Container(
                        height: context.mediaQueryWidth / 6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 2,
                                  blurRadius: 5)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: context.mediaQueryWidth / 8),
                                  child: Text(
                                    'sms'.tr,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                )),
                            const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 10,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                      ),
                    ),

                    ///circle avatar
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.mediaQueryWidth / 18,
                          left: context.mediaQueryWidth / 20),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ]),
                        child: CircleAvatar(
                          radius: context.mediaQueryWidth / 16,
                          backgroundColor: Colors.white,
                          child: Image(
                              image: const AssetImage(
                                  'assets/images/share_app_screen/sms.png'),
                              height: context.mediaQueryWidth / 9.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ])),
            )
          ],
        ),
      ),
    );
  }
}
