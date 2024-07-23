import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/blocs/application_bloc.dart';
import 'package:gramsuvidha/common_widgets/progress_indicator.dart';
import 'package:gramsuvidha/utility/localization_file.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';
import 'package:gramsuvidha/utility/utilityMethods.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import '../modal/commentPostModal.dart';
import '../modal/deleteCommentModal.dart';
import '../modal/getCommentModal.dart';
import '../modal/getDashboardActivityModal.dart';
import '../modal/updateCommentModal.dart';
import '../view/gramsuvidha_dashboard_screen.dart';
import '../view/registration_otp_screen.dart';
import '../view_modal/comment_post_vm.dart';
import '../view_modal/deleteActivity_modal.dart';
import '../view_modal/deleteCommentVm.dart';
import '../view_modal/getCommentVm.dart';
import '../view_modal/getDashboardActivityVm.dart';
import '../view_modal/updateCommentVm.dart';
import '../view_modal/userProfileVm.dart';
import 'choose_language.dart';

/*class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  bool fill=false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextField(
        style: const TextStyle(
            color: Color(0xFFb83058),
            fontWeight: FontWeight.bold,
            fontSize: 22),
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: const Color(0xFFb83058),
        decoration: InputDecoration(
          filled: true,
          focusColor: const Color(0xFFb83058),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFb83058), width: 2)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          counterText: '',
          hintStyle: const TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
            fill=true;
          }
        },
      ),
    );
  }
}*/

/// Dashboard DrawerSection
Widget drawerBox(BuildContext context, {String section = 'Home'}) => ListTile(
      title: Text(
        section.tr,
        style: TextStyle(
            fontSize: context.mediaQueryWidth / 30,
            color: Colors.black45,
            fontFamily: 'Montserrat-Medium',
            fontWeight: FontWeight.w400),
      ),
    );

///Dashboard Maindrawer

bool showCloseIcon = false;
final postOtpVm = Get.put(PostOtpViewModal());

Widget drawerTiles(BuildContext context,
        {IconData icon = Icons.home,
        String sectionName = '',
        String routeName = ''}) =>
    ListTile(
        onTap: () {
          if (routeName.isNotEmpty) {
            Get.toNamed(routeName);
          }
        },
        enableFeedback: true,
        leading: Icon(
          icon,
          color: splashBackgroundColor,
        ),
        titleAlignment: ListTileTitleAlignment.center,
        minLeadingWidth: 0,
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.only(left: context.mediaQueryWidth / 40),
        title: drawerBox(context, section: sectionName));

Widget mainDrawer(BuildContext context, ApplicationBloc applicationBloc) =>
    Drawer(
      width: context.mediaQueryWidth * 0.85,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(80))),
      child: Padding(
        padding: EdgeInsets.only(
            left: context.mediaQueryWidth / 40,
            top: context.mediaQueryWidth / 20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: SvgPicture.asset(
                      'assets/images/registrationOtp_screen/Gram Login Logo.svg',
                      height: context.mediaQueryWidth / 5,
                      alignment: Alignment.centerLeft,
                    )),
                    Padding(
                      padding: EdgeInsets.only(
                          right: context.mediaQueryWidth * 0.03),
                      child: IconButton(
                        enableFeedback: true,
                        splashRadius: context.mediaQueryWidth/20,
                        onPressed: () {
                          Get.back();
                        },
                        icon: SvgPicture.asset(
                          'assets/images/dashboard_screen/close.svg',
                          width: context.mediaQueryWidth/22,
                        ),
                      ),
                    )
                  ],
                ),

                ///Cross icon

                const SizedBox(
                  height: 5,
                ),

                ///home
                drawerTiles(context, icon: Icons.home, sectionName: 'home'.tr),

                ///kyc
                drawerTiles(context,
                    icon: Icons.person_pin_outlined, sectionName: 'kyc'.tr),

                ///essential services
                drawerTiles(context,
                    icon: Icons.phone,
                    sectionName: 'essentialSevicess'.tr,
                    routeName: '/essentialServicesScreen'),

                ///grampanchayat info
                drawerTiles(context,
                    icon: Icons.perm_device_info_outlined,
                    sectionName: 'gramPanchayatBodyInfo'.tr,
                    routeName: '/grampanchayatBodyInfoScreen'),

                ///share link
                drawerTiles(context,
                    icon: Icons.screen_share_rounded,
                    sectionName: 'shareLink'.tr,
                    routeName: '/shareAppScreen'),

                ///Activity Screen
                userType.read('userTypeId') == 2
                    ? ListTile(
                        enableFeedback: true,
                        onTap: () {
                          applicationBloc.showUpdateButton(false, 0);
                          Get.toNamed('/activityScreen');
                        },
                        leading: Icon(
                          Icons.local_activity,
                          color: splashBackgroundColor,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        minLeadingWidth: 0,
                        horizontalTitleGap: 0,
                        contentPadding:
                            EdgeInsets.only(left: context.mediaQueryWidth / 40),
                        title: drawerBox(context, section: 'activities'.tr))
                    : Container(),

                ///Change Language

                ListTile(
                    enableFeedback: true,
                    onTap: () async {
                      showCloseIcon = true;
                      showDialog(
                        context: context,
                        builder: (context) => const ChooseLangugeAlertDialog(),
                      );
                    },
                    leading: Icon(
                      Icons.language,
                      color: splashBackgroundColor,
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                    minLeadingWidth: 0,
                    horizontalTitleGap: 0,
                    contentPadding:
                        EdgeInsets.only(left: context.mediaQueryWidth / 40),
                    title: drawerBox(context, section: 'changeLanguage'.tr)),

                ///Logout
                ListTile(
                    enableFeedback: true,
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: context.mediaQueryHeight * 0.015,
                                  horizontal: context.mediaQueryWidth * 0.02
                                    ),
                                titlePadding: EdgeInsets.zero,
                                actionsPadding: EdgeInsets.only(
                                    bottom: context.mediaQueryHeight * 0.02),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                title: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        splashRadius: context.mediaQueryWidth/22,
                                        icon: SvgPicture.asset(
                                            'assets/images/dashboard_screen/close.svg',width: context.mediaQueryWidth/25),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                    ),
                                    SvgPicture.asset(
                                        'assets/images/dashboard_screen/Notification Alert.svg',)
                                  ],
                                ),
                                content: SizedBox(
                                  width: context.mediaQueryHeight * 0.35,
                                  child: Text(
                                    'logoutConfirmMessage'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: context.mediaQueryWidth * 0.04
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: TextButton.styleFrom(
                                        minimumSize: const Size(80, 10),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.redAccent),
                                    child: Text('no'.tr),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.remove('login');
                                      await selectLanguage.remove('language');
                                      userIdValue.remove('userId');
                                      userType.remove('userTypeId');
                                      gramPanchayatIdValue.remove("gramPanId");
                                      selectedLanguage = english;
                                      showCloseIcon = false;
                                      chooseLanguage.write(
                                          'langSelected', null);
                                      Get.offAll(const RegistrationOtpScreen());
                                      UtilityMethods.snackBarMethod(
                                          context, 'logoutSnackBarMsg'.tr);
                                      // selectLanguage.remove('language');
                                      mobileController.clear();
                                      otpController2.clear();
                                    },
                                    style: TextButton.styleFrom(
                                        minimumSize: const Size(80, 10),
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            const Color(0xFF2980B9)),
                                    child: Text('yes'.tr),
                                  )
                                ],
                              ));
                    },
                    leading: Icon(
                      Icons.logout,
                      color: splashBackgroundColor,
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                    minLeadingWidth: 0,
                    horizontalTitleGap: 0,
                    contentPadding:
                        EdgeInsets.only(left: context.mediaQueryWidth / 40),
                    title: drawerBox(context, section: 'logout'.tr)),
              ],
            ),
          ],
        ),
      ),
    );

final getCommentData = Get.put(GetCommentVm());
final updateCommentVm = Get.put(UpdateCommentVm());
final dashboardActivity = Get.put(GetDashboardActivityVm());
final deleteActivityVm = Get.put(DeleteActivityVm());
final deleteCommentVm = Get.put(DeleteCommentVm());
final userProfileModal = Get.put(UserProfileVm());
final commentPostVm = Get.put(CommentPostVm());

///Common Bottomsheet Widget
Widget commonBottomsheet(
  BuildContext context, {
  int likeCount = 0,
  String userName = '',
  String locationName = '',
  String createdDate = '',
  String createdTime = '',
  String description = '',
  int shareCount = 0,
  List<dynamic>? imageList,
  required ApplicationBloc applicationBloc,
  int commentCount = 0,
  int activityId = 0,
  Iterable<GetDashboardActivity>? data,
}) =>
    SizedBox(
      height: context.mediaQueryHeight / 1.05,
      child: Padding(
        padding: EdgeInsets.only(
            left: context.mediaQueryWidth / 30,
            bottom: context.mediaQueryWidth / 25,
            right: context.mediaQueryWidth / 30),
        child: Obx(
          () => ModalProgressHUD(
            color: Colors.transparent,
            inAsyncCall: getCommentData.isLoading.value == true,
            progressIndicator: progressIndicator(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          enableFeedback: true,
                          splashRadius: context.mediaQueryWidth/22,
                          color: Colors.black,
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text(
                          '$likeCount ${'commentLikeText'.tr}',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      height: 0,
                      color: Colors.black26,
                      thickness: 0.5,
                    ),
                  ],
                ),
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.only(top: context.mediaQueryHeight * 0.008),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: const NetworkImage(
                                    'https://picsum.photos/200'),
                                radius: context.mediaQueryWidth / 18,
                              ),
                              SizedBox(
                                width: context.mediaQueryWidth / 40,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userName,
                                      style: TextStyle(
                                          fontSize: context.mediaQueryWidth / 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87.withOpacity(0.8)),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      locationName,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: context.mediaQueryWidth / 40,
                                        color: Colors.black87.withOpacity(0.6),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          createdDate,
                                          style: TextStyle(
                                            fontSize:
                                                context.mediaQueryWidth / 40,
                                            color:
                                                Colors.black87.withOpacity(0.6),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          createdTime,
                                          style: TextStyle(
                                            fontSize:
                                                context.mediaQueryWidth / 40,
                                            color:
                                                Colors.black87.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: context.mediaQueryHeight / 50,
                          ),
                          Text(
                            description,
                            style:
                                TextStyle(fontSize: context.mediaQueryWidth / 30),
                          ),
                          applicationBloc.getCommentCount(commentCount) > 0
                              ? ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  // padding: EdgeInsets.only(bottom: context.mediaQueryWidth/20),
                                  itemCount: getCommentData.getCommentInfo.length,
                                  itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.only(
                                          bottom: context.mediaQueryHeight / 150),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: CircleAvatar(
                                                radius:
                                                    context.mediaQueryWidth / 23,
                                                backgroundColor:
                                                    Colors.grey.withOpacity(.6),
                                                child: CircleAvatar(
                                                  radius:
                                                      context.mediaQueryWidth /
                                                          24,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: const NetworkImage(
                                                      'https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8?format=png&name=large'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: context.mediaQueryWidth / 70,
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onLongPress: () {
                                                Vibration.vibrate(duration: 100);
                                                var loginUser =
                                                    userIdValue.read('userId');
                                                var commentUser = getCommentData
                                                    .getCommentInfo[index]
                                                    .createdBy;

                                                loginUser == commentUser
                                                    ? showModalBottomSheet(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            20),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20))),
                                                        context: context,
                                                        builder: (context) =>
                                                            SizedBox(
                                                          height: context
                                                                  .mediaQueryHeight /
                                                              5,
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                top: context
                                                                        .mediaQueryWidth /
                                                                    10,
                                                                left: context
                                                                        .mediaQueryWidth /
                                                                    30),
                                                            child: Column(
                                                              children: [
                                                                GestureDetector(
                                                                  behavior:
                                                                      HitTestBehavior
                                                                          .translucent,
                                                                  onTap: () {
                                                                    applicationBloc.updateCommentControllerFun(getCommentData
                                                                        .getCommentInfo[
                                                                            index]
                                                                        .comments!);
                                                                    showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft:
                                                                                  Radius.circular(20),
                                                                              topRight: Radius.circular(20))),
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              Padding(
                                                                        padding: MediaQuery.of(
                                                                                context)
                                                                            .viewInsets,
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: context.mediaQueryWidth / 15),
                                                                          height: context.mediaQueryHeight /
                                                                              3.5,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              ///Navigation
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    flex: 0,
                                                                                    child: GestureDetector(
                                                                                      onTap: () {
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.arrow_back_ios,
                                                                                        size: context.mediaQueryWidth / 14,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: context.mediaQueryWidth / 20,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'ediComment'.tr,
                                                                                      style: TextStyle(fontSize: context.mediaQueryWidth / 18),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),

                                                                              ///comment updater name
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    flex: 0,
                                                                                    child: CircleAvatar(
                                                                                      radius: context.mediaQueryWidth / 21,
                                                                                      backgroundColor: Colors.grey.withOpacity(.6),
                                                                                      child: CircleAvatar(
                                                                                        radius: context.mediaQueryWidth / 22,
                                                                                        backgroundColor: Colors.teal,
                                                                                        backgroundImage: const NetworkImage('https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8?format=png&name=large'),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: context.mediaQueryWidth / 25,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      userName,
                                                                                      style: TextStyle(fontSize: context.mediaQueryWidth / 25, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),

                                                                              ///update comment text field
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: TextFormField(
                                                                                      controller: updateCommentController,
                                                                                      decoration: InputDecoration(
                                                                                        isDense: true,
                                                                                        isCollapsed: true,
                                                                                        hintText: 'enterCommentHint'.tr,
                                                                                        border: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                          borderSide: const BorderSide(
                                                                                            width: 0,
                                                                                            style: BorderStyle.none,
                                                                                          ),
                                                                                        ),
                                                                                        contentPadding: EdgeInsets.only(
                                                                                          left: context.mediaQueryWidth / 30,
                                                                                          top: context.mediaQueryHeight / 80,
                                                                                          bottom: context.mediaQueryHeight / 80,
                                                                                        ),
                                                                                        hintStyle: TextStyle(
                                                                                          fontSize: context.mediaQueryHeight / 50,
                                                                                        ),
                                                                                        filled: true,
                                                                                        fillColor: Colors.grey.shade300,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: context.mediaQueryWidth / 30,
                                                                                  ),
                                                                                  Expanded(
                                                                                      flex: 0,
                                                                                      child: GestureDetector(
                                                                                        onTap: () async {
                                                                                          if (updateCommentController.text.isNotEmpty) {
                                                                                            ///Update Comment Api Call Here
                                                                                            await updateCommentVm.updateComment(UpdateCommentModal(), getCommentData.getCommentInfo[index].id!, getCommentData.getCommentInfo[index].activityId!, updateCommentController.text);
                                                                                            Get.back();
                                                                                            Get.back();
                                                                                            Get.snackbar('cmtStatus'.tr, 'commentUpdateMsg'.tr, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.black87, colorText: Colors.white, duration: const Duration(seconds: 1), margin: EdgeInsets.only(bottom: context.mediaQueryWidth / 10, left: context.mediaQueryWidth / 20, right: context.mediaQueryWidth / 20));

                                                                                            getCommentData.isLoading.value = true;

                                                                                            ///Get comment by Activity Id
                                                                                            Timer(const Duration(seconds: 2), () {
                                                                                              getCommentData.getComment(GetCommentModal(), getCommentData.getCommentInfo[index].activityId!);
                                                                                              // dashboardActivity.isLoading.value = true;
                                                                                            });

                                                                                          /*  Timer(const Duration(seconds: 2), () {
                                                                                              dashboardActivity.getDashboardActivity(page);
                                                                                            });*/
                                                                                          } else if (updateCommentController.text.isEmpty) {
                                                                                            Get.snackbar('emptyCommentTitle'.tr, 'emptyCommentMsg'.tr, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.black87, colorText: Colors.white, duration: const Duration(seconds: 1), margin: EdgeInsets.only(bottom: context.mediaQueryWidth / 10, left: context.mediaQueryWidth / 20, right: context.mediaQueryWidth / 20));
                                                                                          }
                                                                                        },
                                                                                        child: CircleAvatar(
                                                                                          radius: context.mediaQueryWidth / 22,
                                                                                          child: const Icon(
                                                                                            Icons.send,
                                                                                            size: 15,
                                                                                          ),
                                                                                        ),
                                                                                      ))
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .note_alt_outlined,
                                                                          size: context.mediaQueryWidth /
                                                                              17),
                                                                      SizedBox(
                                                                        width:
                                                                            context.mediaQueryWidth /
                                                                                50,
                                                                      ),
                                                                      Text(
                                                                        'editBtn'
                                                                            .tr,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                context.mediaQueryWidth / 23),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: context
                                                                          .mediaQueryHeight /
                                                                      30,
                                                                ),
                                                                GestureDetector(
                                                                  behavior:
                                                                      HitTestBehavior
                                                                          .translucent,
                                                                  onTap: () {
                                                                    showDialog(
                                                                      barrierDismissible:
                                                                          false,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10)),
                                                                        actionsAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceEvenly,
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        actionsPadding:
                                                                            EdgeInsets.only(
                                                                                bottom: context.mediaQueryHeight / 50),
                                                                        contentPadding: EdgeInsets.only(
                                                                            left: context.mediaQueryWidth /
                                                                                10,
                                                                            right: context.mediaQueryWidth /
                                                                                10,
                                                                            top: context.mediaQueryHeight /
                                                                                60,
                                                                            bottom:
                                                                                context.mediaQueryHeight / 80),
                                                                        title:
                                                                            Column(
                                                                          children: [
                                                                            ClipRRect(
                                                                                child: Icon(
                                                                              Icons.warning_amber,
                                                                              color:
                                                                                  Colors.amber,
                                                                              size:
                                                                                  context.mediaQueryHeight / 15,
                                                                            )),
                                                                            Text(
                                                                              'alert'.tr,
                                                                              textAlign:
                                                                                  TextAlign.center,
                                                                              style: TextStyle(
                                                                                  // fontFamily: 'Montserrat-Medium',
                                                                                  fontSize: context.mediaQueryHeight / 50,
                                                                                  fontWeight: FontWeight.w400),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        content:
                                                                            Text(
                                                                          'deleteCommentTitle'
                                                                              .tr,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              // fontFamily: 'Montserrat-Medium',
                                                                              fontSize: context.mediaQueryWidth / 25),
                                                                        ),
                                                                        actions: [
                                                                          MaterialButton(
                                                                            onPressed:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                            color:
                                                                                Colors.redAccent,
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                            height:
                                                                                context.mediaQueryHeight / 23,
                                                                            child: Text(
                                                                                'no'.tr,
                                                                                style: TextStyle(fontSize: context.mediaQueryWidth / 30, fontWeight: FontWeight.w400, color: Colors.white)),
                                                                          ),
                                                                          MaterialButton(
                                                                            color:
                                                                                Colors.green,
                                                                            height:
                                                                                context.mediaQueryHeight / 23,
                                                                            onPressed:
                                                                                () async {
                                                                              await deleteCommentVm.deleteComment(
                                                                                  context,
                                                                                  DeleteCommentModal(),
                                                                                  getCommentData.getCommentInfo[index].id!);

                                                                              getCommentData.isLoading.value =
                                                                                  true;

                                                                              ///Get comment by Activity Id
                                                                              Timer(const Duration(seconds: 2),
                                                                                  () async {
                                                                                print('*****$activityId####');
                                                                                await getCommentData.getComment(GetCommentModal(), activityId);
                                                                                print('#######${getCommentData.getCommentInfo.length}#######');
                                                                                await applicationBloc.onPresses(
                                                                                  data!,
                                                                                  userName,
                                                                                  locationName,
                                                                                  createdDate,
                                                                                  createdTime,
                                                                                  description,
                                                                                  likeCount,
                                                                                  getCommentData.getCommentInfo.length,
                                                                                  shareCount,
                                                                                  imageList ?? [],
                                                                                );
                                                                              });

                                                                              Timer(const Duration(seconds: 2),
                                                                                  () async {
                                                                                /*        dashboardActivity
                                                                                      .getDashboardActivityData
                                                                                      .clear();
                                                                                  dashboardActivity
                                                                                      .isLoading
                                                                                      .value = true;
                                                                                  await dashboardActivity
                                                                                      .getDashboardActivity(page);
                                                                                  dashboardActivity
                                                                                      .isLoading
                                                                                      .value = false;*/
                                                                              });
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                            child:
                                                                                Text(
                                                                              'yes'.tr,
                                                                              style: TextStyle(
                                                                                  fontSize: context.mediaQueryWidth / 30,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .delete_forever,
                                                                          size: context.mediaQueryWidth /
                                                                              17),
                                                                      SizedBox(
                                                                        width:
                                                                            context.mediaQueryWidth /
                                                                                50,
                                                                      ),
                                                                      Text(
                                                                        'deleteBtn'
                                                                            .tr,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                context.mediaQueryWidth / 23),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : null;
                                              },
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: Container(
                                                  width: context.mediaQueryWidth,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: context
                                                              .mediaQueryWidth /
                                                          35,
                                                      vertical: context
                                                              .mediaQueryWidth /
                                                          30),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        getCommentData
                                                            .getCommentInfo[index]
                                                            .fullName!,
                                                        style: TextStyle(
                                                            fontSize: context
                                                                    .mediaQueryWidth /
                                                                28,
                                                            color: Colors.black87
                                                                .withOpacity(0.8),
                                                            fontWeight:
                                                                FontWeight.w600),
                                                      ),
                                                      SizedBox(
                                                        height: context
                                                                .mediaQueryWidth /
                                                            40,
                                                      ),
                                                      Text(
                                                        getCommentData
                                                            .getCommentInfo[index]
                                                            .comments!,
                                                        style: TextStyle(
                                                            fontSize: context
                                                                    .mediaQueryWidth /
                                                                28,
                                                            color: Colors.black87
                                                                .withOpacity(
                                                                    0.6)),
                                                      ),
                                                      SizedBox(
                                                        height: context
                                                                .mediaQueryWidth /
                                                            40,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              applicationBloc.commentTime(DateTime
                                                                      .now()
                                                                  .difference(getCommentData
                                                                      .getCommentInfo[
                                                                          index]
                                                                      .timestamp!)),
                                                              style: TextStyle(
                                                                  fontSize: context
                                                                          .mediaQueryWidth /
                                                                      35,
                                                                  color: Colors
                                                                      .black87
                                                                      .withOpacity(
                                                                          0.6)),
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(getCommentData
                                                                    .getCommentInfo[
                                                                        index]
                                                                    .createdDate!),
                                                            style: TextStyle(
                                                                fontSize: context
                                                                        .mediaQueryWidth /
                                                                    35,
                                                                color: Colors
                                                                    .black87
                                                                    .withOpacity(
                                                                        0.6)),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),
                ),
                commentCount == 0 || getCommentData.getCommentInfo.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'noCommentMsg'.tr,
                            style: TextStyle(
                                fontSize: context.mediaQueryWidth / 21),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Column(
                  children: [
                    const Divider(
                      color: Colors.black26,
                      thickness: 0.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: context.mediaQueryWidth / 40),
                              child: TextFormField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'enterCommentHint'.tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: context.mediaQueryWidth / 30,
                                    top: context.mediaQueryHeight / 70,
                                    bottom: context.mediaQueryHeight / 70,
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: context.mediaQueryHeight / 50),
                                  filled: true,
                                  isCollapsed: true,
                                  fillColor: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: context.mediaQueryWidth / 30,
                          ),
                          Expanded(
                              flex: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  if (commentController.text.isNotEmpty) {
                                    await commentPostVm.addPost(
                                        CommentPostModal(), context);

                                    ///Get comment by Activity Id
                                    Timer(const Duration(seconds: 2), () async {
                                      getCommentData.isLoading.value = true;
                                      await getCommentData.getComment(
                                          GetCommentModal(), activityId);
                                      print(
                                          '#######${getCommentData.getCommentInfo.length}#######');
                                      commentCount =
                                          getCommentData.getCommentInfo.length;
                                      await applicationBloc.onPresses(
                                          data!,
                                          userName,
                                          locationName,
                                          createdDate,
                                          createdTime,
                                          description,
                                          likeCount,
                                          getCommentData.getCommentInfo.length,
                                          shareCount,
                                          imageList ?? []);
                                    });

                                    print(
                                        '*******${getCommentData.getCommentInfo.length}*******');
                                  } else if (commentController.text.isEmpty) {
                                    Get.snackbar('emptyCommentTitle:'.tr,
                                        'emptyCommentMsg'.tr,
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.black87,
                                        colorText: Colors.white,
                                        duration: const Duration(seconds: 1),
                                        margin: EdgeInsets.only(
                                            bottom:
                                                context.mediaQueryWidth / 10,
                                            left: context.mediaQueryWidth / 20,
                                            right:
                                                context.mediaQueryWidth / 20));
                                  }
                                },
                                child: CircleAvatar(
                                  radius: context.mediaQueryWidth / 22,
                                  child: const Icon(
                                    Icons.send,
                                    size: 15,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
