import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class DecisionsProceedingsScreen extends StatelessWidget {
  const DecisionsProceedingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashBackgroundColor,
        centerTitle: true,
        title: Text(
          'decision_proceedings_title'.tr,
          style: TextStyle(fontSize: context.mediaQueryHeight / 40),
        ),
        leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 22,
            )),
      ),
      backgroundColor: const Color(0XFFF4F3F9),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: 4,
          itemBuilder: (context, index) => Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: context.mediaQueryWidth / 25,
                  left: context.mediaQueryWidth / 13,
                  right: context.mediaQueryWidth / 13,
                ),
                padding: EdgeInsets.only(
                  left: context.mediaQueryWidth / 20,
                  right: context.mediaQueryWidth / 20,
                  top: context.mediaQueryWidth / 20,
                ),
                height: context.mediaQueryWidth / 1.2,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          spreadRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lorem Ipsum is simply dummy',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0XFF284ED6),
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: context.mediaQueryWidth / 25,
                    ),
                    const Text(
                      'Lorem Ipsum is simply dummy text of the painting and\n '
                      'typesetting industry.Lorem Ipsum has been the\n '
                      'industry\'s standard dummy text ever since the 1500s',
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                    SizedBox(
                      height: context.mediaQueryWidth / 30,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: const NetworkImage(
                          'https://picsum.photos/200/300',
                        ),
                        height: context.mediaQueryWidth / 2.35,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: context.mediaQueryWidth / 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Linkify(
                            onOpen: (link) async {
                              if (await canLaunchUrl(Uri.parse(link.url))) {
                                await launchUrl(Uri.parse(link.url));
                              } else {
                                throw 'Could not launch $link';
                              }
                            },
                            options: const LinkifyOptions(humanize: false),
                            text: "https://picsum.photos/200/300",
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 10),
                          ),
                        ),
                        GestureDetector(
                            onTap: () async {
                              await Clipboard.setData(const ClipboardData(
                                      text: 'https://picsum.photos/200/300'))
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      margin: EdgeInsets.only(
                                          bottom: context.mediaQueryWidth / 10,
                                          left: context.mediaQueryWidth / 5,
                                          right: context.mediaQueryWidth / 5),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      content: Text(
                                        'copySnackBarMessage'.tr,
                                        textAlign: TextAlign.center,
                                      )),
                                );
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: context.mediaQueryWidth / 55),
                              child: Icon(
                                Icons.copy,
                                color: Colors.blue.shade200,
                                size: 12,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
