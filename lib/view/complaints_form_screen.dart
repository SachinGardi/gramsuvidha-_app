import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import '../utility/utilityColor.dart';

class ComplaintsFormScreen extends StatefulWidget {
  const ComplaintsFormScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintsFormScreen> createState() => _ComplaintsFormScreenState();
}

class _ComplaintsFormScreenState extends State<ComplaintsFormScreen> {
  List<String> complainTypeList = [
    'normal',
    'Hard',
    'Neutral',
  ];
  String? selectedComplain = 'Select Complain';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashBackgroundColor,
        centerTitle: true,
        title: Text(
          'complaintForm'.tr,
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
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: context.mediaQueryWidth / 7,
                    right: context.mediaQueryWidth / 7,
                    top: context.mediaQueryHeight / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'typeOfComplain'.tr,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    DropdownButtonFormField<String>(
                      style: const TextStyle(
                          fontFamily: 'Monteserrat',
                          color: Colors.black54,
                          fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'typeOfComplain'.tr,
                      ),
                      // value: selectedComplain,
                      items: complainTypeList
                          .map((complain) => DropdownMenuItem<String>(
                                value: complain,
                                child: Text(complain,
                                    style: const TextStyle(fontSize: 15)),
                              ))
                          .toList(),
                      onChanged: (complain) =>
                          setState(() => selectedComplain = complain),
                      menuMaxHeight: 300,
                    ),
                    SizedBox(
                      height: context.mediaQueryWidth / 60,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text('complainText'.tr),
                          hintStyle: const TextStyle(fontSize: 15),
                          labelStyle: const TextStyle(fontSize: 15)),
                    ),
                    SizedBox(
                      height: context.mediaQueryWidth / 60,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text('location'.tr),
                          hintStyle: const TextStyle(fontSize: 15),
                          labelStyle: const TextStyle(fontSize: 15)),
                    ),
                    SizedBox(
                      height: context.mediaQueryHeight / 20,
                    ),
                    Text(
                      'listofAttachment'.tr,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: context.mediaQueryHeight / 30,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.mediaQueryWidth / 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 2),
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: context.mediaQueryWidth / 30,
                        mainAxisSpacing: context.mediaQueryWidth / 30),
                    itemBuilder: (context, index) => DottedBorder(
                      borderType: BorderType.RRect,
                      color: Colors.grey,
                      radius: const Radius.circular(5),
                      dashPattern: const [5, 5],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: context.mediaQueryWidth / 25,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: context.mediaQueryWidth / 25.5,
                                child: const Icon(
                                  Icons.cloud_upload,
                                  size: 15,
                                  color: Color(0XFF4F44FF),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.mediaQueryWidth / 30,
                          ),
                          Text(
                            'choosePhoto'.tr,
                            style: const TextStyle(
                                fontSize: 8, color: Color(0XFF4F44FF)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (context.mediaQueryHeight > 700) {
                    return SizedBox(
                      height: context.mediaQueryHeight / 15,
                    );
                  }
                  return SizedBox(
                    height: context.mediaQueryHeight / 80,
                  );
                },
              ),
              SizedBox(
                height: context.mediaQueryWidth / 10,
                width: context.mediaQueryWidth / 2.5,
                child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: buttonColor,
                    onPressed: () {},
                    child: Text(
                      'submit'.tr,
                      style: const TextStyle(
                          fontFamily: 'Montserrat-Regular', fontSize: 13),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
