import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import '../utility/utilityColor.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashBackgroundColor,
        centerTitle: true,
        title: Text(
          'complaints'.tr,
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
        child: Stack(
          children: [
            Container(
              height: context.mediaQueryHeight,
            ),
            SizedBox(
              height: context.mediaQueryHeight,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                      padding:
                          const EdgeInsets.only(left: 25, right: 10, top: 10),
                      height: context.mediaQueryWidth / 2.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 4,
                                spreadRadius: 2)
                          ],
                          color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Text(
                                  'typeOfComplain'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                              const Expanded(
                                  flex: 8,
                                  child: Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(fontSize: 11),
                                  )),
                              Container(
                                height: 25,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: index.isEven
                                        ? const Color(0XFFFF879F)
                                        : const Color(0XFF4DF084),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child: Text(
                                    '392',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            endIndent: 15,
                          ),
                          SizedBox(
                            height: context.mediaQueryWidth / 40,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Text(
                                  'enquiryText'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                              const Expanded(
                                flex: 11,
                                child: Text(
                                  'Lorem Ipsum is simply dummy\n'
                                  'text of the printing and typesetting\n'
                                  'industry.Lorem Ipsum has been the\n'
                                  'industry\'s standard dummy text',
                                  style: TextStyle(fontSize: 11),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: context.mediaQueryWidth / 40,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Text(
                                  'status'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                              const Expanded(
                                  flex: 11,
                                  child: Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(fontSize: 11),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: context.mediaQueryWidth / 40,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '${"date".tr} -14-06-2022',
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: context.mediaQueryHeight / 1.4,
              ),
              child: Center(
                child: SizedBox(
                  height: context.mediaQueryWidth / 10,
                  width: context.mediaQueryWidth / 2.3,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: buttonColor,
                    onPressed: () {
                      Get.toNamed('/complaintsFormScreen');
                    },
                    child: Text(
                      'addComplain'.tr,
                      style: const TextStyle(
                          fontFamily: 'Montserrat-Regular', fontSize: 13),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
