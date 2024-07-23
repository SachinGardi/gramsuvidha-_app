import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import '../utility/utilityColor.dart';

class EssentialServicesScreen extends StatelessWidget {
  const EssentialServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashBackgroundColor,
        centerTitle: true,
        title: Text(
          'essentialServiceTitle'.tr,
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
            Get.back();
          },
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: ListView.builder(
          padding: EdgeInsets.only(
            top: context.mediaQueryWidth / 40,
          ),
          itemCount: 8,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
                bottom: context.mediaQueryWidth / 40,
                left: context.mediaQueryWidth / 20,
                right: context.mediaQueryWidth / 20),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: context.mediaQueryWidth / 20),
              height: context.mediaQueryWidth / 5,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 2)
              ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const Expanded(
                    flex: 9,
                    child: Text(
                      'Medical Store',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Expanded(flex: 12, child: Text('9876543210')),
                  SizedBox(
                    height: context.mediaQueryWidth / 16.5,
                    width: context.mediaQueryWidth / 7,
                    child: FloatingActionButton.extended(
                      heroTag: index,
                      extendedIconLabelSpacing: 2,
                      onPressed: () {},
                      label: const Text(
                        'Call',
                        style: TextStyle(fontSize: 12),
                      ),
                      icon: const Icon(
                        Icons.phone_in_talk,
                        size: 15,
                      ),
                      backgroundColor: const Color(0XFF2FAD14),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
