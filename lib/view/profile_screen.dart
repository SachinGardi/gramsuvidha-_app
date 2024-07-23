import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/common_widgets/progress_indicator.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../utility/utilityColor.dart';
import '../view_modal/userProfileVm.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final getProfileInfo = Get.put(UserProfileVm());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashBackgroundColor,
        leading: IconButton(
            enableFeedback: true,
            splashRadius: context.mediaQueryWidth/22,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded, size: 22)),
        centerTitle: true,
        title: Text('profileAppBarTitle'.tr,
            style: TextStyle(fontSize: context.mediaQueryWidth / 21)),
      ),
      body: Obx(
        () => ModalProgressHUD(
          color: Colors.black38,
          inAsyncCall: getProfileInfo.isLoading.value == true,
          progressIndicator: progressIndicator(),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: context.mediaQueryWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 3,
                          )
                        ]),
                    child: Stack(

                      children: [
                        Container(
                          height: context.mediaQueryWidth / 3,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: Color(0XFF2980B9),
                          ),
                        ),

                        ///edit Circle Avatar
                        Padding(
                          padding: EdgeInsets.only(
                              left: context.mediaQueryWidth / 1.25,
                              top: context.mediaQueryHeight / 85),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed('/updateProfile');
                            },
                            child: CircleAvatar(
                              radius: context.mediaQueryWidth / 30,
                              backgroundColor: const Color(0XFFB2D1E6),
                              child:  Icon(
                                Icons.edit,
                                size: context.mediaQueryWidth/25,
                              ),
                            ),
                          ),
                        ),

                        ///big Circle Avatar
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.mediaQueryWidth / 7,
                              left: context.mediaQueryWidth / 3.5),
                          child: CircleAvatar(
                            radius: context.mediaQueryWidth / 6,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                radius: context.mediaQueryWidth / 6.5,
                                backgroundColor: Colors.teal,
                                backgroundImage: getProfileInfo
                                        .profilePic.isEmpty
                                    ? const NetworkImage(
                                        'https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8?format=png&name=large')
                                    : NetworkImage(getProfileInfo.profilePic)),
                          ),
                        ),

                        ///Name
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.mediaQueryWidth / 15),
                          child: Center(
                            child: Text(
                              getProfileInfo.fullName,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),

                        ///Mobile ane email
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.mediaQueryWidth / 1.6,
                              left: context.mediaQueryWidth / 25,
                              right: context.mediaQueryWidth / 25),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: context.mediaQueryWidth / 50,
                                      backgroundColor: const Color(0XFFB2D1E6),
                                      child: const Icon(
                                        Icons.phone_in_talk,
                                        size: 10,
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.mediaQueryWidth / 60,
                                    ),
                                    Text(
                                      '+91 ${getProfileInfo.mobileNumber}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: context.mediaQueryWidth / 50,
                                    backgroundColor: const Color(0XFFB2D1E6),
                                    child: const Icon(
                                      Icons.email,
                                      size: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    width: context.mediaQueryWidth / 60,
                                  ),
                                  Expanded(
                                    child: Text(
                                      getProfileInfo.email,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),

                        ///location Detail
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.mediaQueryWidth / 1.4,
                              left: context.mediaQueryWidth / 25,
                              right: context.mediaQueryWidth / 25),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: context.mediaQueryWidth / 50,
                                backgroundColor: const Color(0XFFB2D1E6),
                                child: const Icon(
                                  Icons.location_pin,
                                  size: 10,
                                ),
                              ),
                              SizedBox(
                                width: context.mediaQueryWidth / 50,
                              ),
                              Expanded(
                                child: Text(
                                  getProfileInfo.address,
                                  style: TextStyle(fontSize: 12),
                                  softWrap: true,
                                ),
                              )
                            ],
                          ),
                        ),

                        ///Divider
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.mediaQueryWidth / 1.2),
                          child: const Divider(
                            color: Color(0XFFb8d5e8),
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                          ),
                        ),

                        ///City and Village
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.mediaQueryWidth / 1.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'city'.tr,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: context.mediaQueryWidth / 60,
                                  ),
                                  const Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'village'.tr,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: context.mediaQueryWidth / 60,
                                  ),
                                  const Text(
                                    'Lorem Ipsum',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
