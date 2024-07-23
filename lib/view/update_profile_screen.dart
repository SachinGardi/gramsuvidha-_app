import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/blocs/application_bloc.dart';
import 'package:gramsuvidha/common_widgets/progress_indicator.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';
import 'package:gramsuvidha/utility/utilityMethods.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../view_modal/getDashboardActivityVm.dart';
import '../view_modal/updateProfileVm.dart';
import '../view_modal/userProfileVm.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final getProfileInfo = Get.put(UserProfileVm());
  final updateProfile = Get.put(UpdateProfileVm());
  final dashboardActivity = Get.put(GetDashboardActivityVm());
  late BuildContext bottomSheetContext;

  @override
  void initState() {
    super.initState();

    fullNameController.text = getProfileInfo.fullName;
    mobileNoController.text = getProfileInfo.mobileNumber;
    emailIdController.text = getProfileInfo.email;
    updateAddressController.text = getProfileInfo.address;
    profileImage = getProfileInfo.profilePic;
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        await getProfileInfo.getUserProfileInfo();
        applicationBloc.pickedImage.clear();
        Get.back();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: splashBackgroundColor,
            leading: IconButton(
                enableFeedback: true,
                splashRadius: context.mediaQueryWidth/22,
                onPressed: () {
                  setState(() {
                    getProfileInfo.isLoading.value = true;
                    Timer(const Duration(seconds: 2), () {
                      getProfileInfo.getUserProfileInfo();
                    });
                  });
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 22,
                )),
            centerTitle: true,
            title: Text(
              'updateProfileAppBarTitle'.tr,
              style: TextStyle(fontSize: context.mediaQueryWidth / 21),
            ),
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: Center(
              child: ProgressHUD(
                  padding: EdgeInsets.zero,
                  indicatorWidget: progressIndicator(),
                  child: SingleChildScrollView(
                    child: Consumer<ApplicationBloc>(
                      builder: (context, appBlock, child) => Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: context.mediaQueryWidth / 20,
                            vertical: context.mediaQueryHeight / 8),
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: context.mediaQueryWidth / 14,
                            right: context.mediaQueryWidth / 14,
                            top: context.mediaQueryHeight / 30,
                            bottom: context.mediaQueryHeight / 30,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ///Circle Avatar
                                  Consumer<ApplicationBloc>(
                                    builder: (context, appBlock, child) =>
                                        GestureDetector(
                                      onTap: () async {
                                        bottomSheetContext = context;
                                        final deviceInfo =
                                            await DeviceInfoPlugin().androidInfo;
                                        if (deviceInfo.version.sdkInt >= 33) {
                                          PermissionStatus status =
                                              await Permission.photos.request();
                                          // PermissionStatus storageStatus = await Permission.photos .request();
                                          // print("Permission granted$storageStatus");
                                          print("Permission granted$status");
                                          if (status ==
                                                  PermissionStatus
                                                      .permanentlyDenied ||
                                              status == PermissionStatus.denied) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(bottomSheetContext);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              duration:
                                                  const Duration(seconds: 3),
                                              content: Row(
                                                children: [
                                                  const Text(
                                                      "App permissions denied"),
                                                  const Spacer(),
                                                  TextButton(
                                                      onPressed: () {
                                                        openAppSettings();
                                                      },
                                                      child:
                                                          const Text("Setttings"))
                                                ],
                                              ),
                                            ));
                                          } else {
                                            //await Permission.camera.request().isGranted;
                                            // pickFileFromCamera();
                                            applicationBloc.openGallery();
                                          }
                                        } else {
                                          PermissionStatus status =
                                              await Permission.storage.request();
                                          // PermissionStatus storageStatus = await Permission.storage .request();
                                          if (status ==
                                              PermissionStatus
                                                  .permanentlyDenied) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(bottomSheetContext);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              duration:
                                                  const Duration(seconds: 3),
                                              content: Row(
                                                children: [
                                                  const Text(
                                                      "App permissions denied"),
                                                  const Spacer(),
                                                  TextButton(
                                                      onPressed: () {
                                                        openAppSettings();
                                                      },
                                                      child:
                                                          const Text("Setttings"))
                                                ],
                                              ),
                                            ));
                                          } else {
                                            // pickFileFromCamera();
                                            applicationBloc.openGallery();
                                          }
                                        }
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black54,
                                                  spreadRadius: 2,
                                                  blurRadius: 2)
                                            ]),
                                        child: CircleAvatar(
                                          radius: context.mediaQueryWidth / 7,
                                          backgroundColor: Colors.teal,
                                          backgroundImage: (appBlock
                                                  .pickedImage.isEmpty)
                                              ? NetworkImage(profileImage.isEmpty
                                                  ? 'https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8?format=png&name=large'
                                                  : profileImage)
                                              : FileImage(
                                                      File(appBlock.imagePath!))
                                                  as ImageProvider,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: fullNameController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(RegExp(
                                          '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                                    ],
                                    style: const TextStyle(fontSize: 13),
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        hintText: 'fullNameHint'.tr,
                                        hintStyle: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        isDense: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  ),
                                  SizedBox(
                                    height: context.mediaQueryWidth / 20,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    maxLength: 10,
                                    controller: mobileNoController,
                                    style: const TextStyle(fontSize: 13),
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        counterText: '',
                                        hintText: 'mobileText'.tr,
                                        hintStyle: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        isDense: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  ),
                                  SizedBox(
                                    height: context.mediaQueryWidth / 20,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailIdController,
                                    style: const TextStyle(fontSize: 13),
                                    textAlignVertical: TextAlignVertical.center,
                                    textCapitalization: TextCapitalization.none,
                                    decoration: InputDecoration(
                                        hintText: 'emailHintText'.tr,
                                        hintStyle: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        isDense: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  ),
                                  SizedBox(
                                    height: context.mediaQueryWidth / 20,
                                  ),
                                  TextFormField(
                                    controller: updateAddressController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(RegExp(
                                          '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                                    ],
                                    style: const TextStyle(fontSize: 13),
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                        hintText: 'addressHintText'.tr,
                                        hintStyle: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        isDense: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  ),
                                ],
                              ),
                              SizedBox(height: context.mediaQueryHeight / 35),
                              Builder(
                                builder: (context) => MaterialButton(
                                  height: context.mediaQueryWidth / 10,
                                  minWidth: context.mediaQueryWidth / 2.5,
                                  color: splashBackgroundColor,
                                  onPressed: () async {
                                    if (fullNameController.text.isEmpty) {
                                      UtilityMethods.snackBarMethod(
                                          context, 'emptyName'.tr);
                                    } else if (mobileNoController.text.length <
                                            10 ||
                                        mobileNoController.text.isEmpty) {
                                      UtilityMethods.snackBarMethod(
                                          context, 'emptyMobile'.tr);
                                    } else if (!EmailValidator.validate(
                                        emailIdController.text)) {
                                      UtilityMethods.snackBarMethod(
                                          context, 'emptyEmail'.tr);
                                    } else if (profileImage.isEmpty &&
                                        appBlock.imagePath!.isEmpty) {
                                      UtilityMethods.snackBarMethod(
                                          context, 'emptyImage'.tr);
                                    } else {
                                      final progress = ProgressHUD.of(context);
                                      progress?.show();
                                      if (appBlock.imagePath != null) {
                                        await appBlock.uploadProfileImage(
                                            appBlock.imagePath!);
                                      }
                                      if (!mounted) return;
                                      await updateProfile.updateUserProfile(
                                          UpdateProfileVm(), context);

                                      progress!.dismiss();
                                      // getProfileInfo.getUserProfileInfoList.clear();
                                      getProfileInfo.isLoading.value = true;
                                      await getProfileInfo.getUserProfileInfo();
                                      /*   dashboardActivity.getDashboardActivityData = [];
                                            dashboardActivity.isLoading.value = true;
                                            dashboardActivity.getDashboardActivity(1);*/
                                      // nameStorage.write('userName', getProfileInfo.fullName);
                                      Get.back();
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'updateBtn'.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          )),
    );
  }
}
