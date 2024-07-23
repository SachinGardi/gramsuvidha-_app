import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/modal/getCommentModal.dart';
import 'package:gramsuvidha/utility/common_widgets.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:gramsuvidha/view/fcmpage.dart';
import 'package:gramsuvidha/view/verification_screen.dart';
import 'package:gramsuvidha/view_modal/comment_post_vm.dart';
import 'package:gramsuvidha/view_modal/deleteActivity_modal.dart';
import 'package:gramsuvidha/view_modal/getCommentVm.dart';
import 'package:gramsuvidha/view_modal/updateCommentVm.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/application_bloc.dart';
import '../common_widgets/animated_bottom_navigationbar.dart';
import '../common_widgets/progress_indicator.dart';
import '../main.dart';
import '../modal/appLoginModal.dart';
import '../modal/getDashboardActivityModal.dart';
import '../notificationservice/local_notification_service.dart';
import '../repository/get_dashboard_activity_repo.dart';
import '../utility/notification_manager.dart';
import '../utility/textcontroller.dart';
import '../utility/utilityColor.dart';
import '../utility/utilityMethods.dart';
import '../view_modal/activity_like_vm.dart';
import '../view_modal/deleteCommentVm.dart';
import '../view_modal/getDashboardActivityVm.dart';
import '../view_modal/getactivity_vm.dart';
import '../view_modal/post_otp_vm.dart';
import '../view_modal/userProfileVm.dart';
import '../view_modal/varify_number.dart';
import 'activityform.dart';

class GramsuvidhaDashboardScreen extends StatefulWidget {
  const GramsuvidhaDashboardScreen({Key? key}) : super(key: key);

  @override
  State<GramsuvidhaDashboardScreen> createState() =>
      GramsuvidhaDashboardScreenState();
}

///pagination
int page = 1;

class GramsuvidhaDashboardScreenState extends State<GramsuvidhaDashboardScreen>
    with WidgetsBindingObserver {
  final otpViewModal = Get.put(OTPViewModal());
  final appLoginModal = Get.put(AppLoginModal());
  final userProfileModal = Get.put(UserProfileVm());
  final dashboardActivityVm = Get.put(GetDashboardActivityVm());
  final commentPostVm = Get.put(CommentPostVm());
  final getCommentData = Get.put(GetCommentVm());
  final updateCommentVm = Get.put(UpdateCommentVm());
  final deleteCommentVm = Get.put(DeleteCommentVm());
  final activityLikeVm = Get.put(ActivityLikeVm());
  final deleteActivityVm = Get.put(DeleteActivityVm());
  final postOtpVm = Get.put(PostOtpViewModal());
  final GlobalKey<ScaffoldState> key = GlobalKey();
  var likeTypeId = 0;
  final getActivityVm = Get.put(GetActivityVm());

  /// There is next page or not
  static bool hasNextPage = true;

  /// Used to display loading indicators when _firstLoad function is running
  static bool isFirstLoadRunning = false;

  /// Used to display loading indicators when _loadMore function is running
  static bool isLoadMoreRunning = false;

  bool isLiked = false;

  late ScrollController controller;

  ///Load first method
  void firstLoad() async {
    setState(() {
      isFirstLoadRunning = true;
    });
    try {
      Timer(const Duration(milliseconds: 800), () {
        setState(() {
          hasNextPage = true;
          page = 1;
          GetDashBoardActivityRepo.getDashboardActivityList.clear();
          dashboardActivityVm.getDashboardActivityData.clear();
          dashboardActivityVm.isLoading.value = true;
          dashboardActivityVm.getDashboardActivity(page);
        });
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }
    setState(() {
      isFirstLoadRunning = false;
    });
  }

  ///load more data
  void loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        controller.position.extentAfter < 300) {
      setState(() {
        isLoadMoreRunning = true;
      });
      page += 1;

      try {
        // getOrderHistoryVm.isLoading.value = true;
        await dashboardActivityVm.getDashboardActivity(page);

        if (page == dashboardTotalPages!) {
          setState(() {
            hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }
      setState(() {
        isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    firstLoad();
    controller = ScrollController()..addListener(loadMore);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      deleteActivityVm.isLoading.value = false;

      titleController.clear();
      descriptionController.clear();
      ActivityFormsState.selectedImages!.clear();
      ActivityFormsState.imageSelected!.clear();
      final applicationBloc =
          Provider.of<ApplicationBloc>(context, listen: false);
      Future.delayed(Duration.zero, () {
        applicationBloc.showUpdateButton(false, 0);
      });
    });

    /// 1. This method call when app in terminated state and you get a notification
    /// when you click on notification app open from terminated state and you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print("New Notification");
          print('***************Hello*************');

          if (prefs.getBool('login') != null) {
            Get.to(() => FcmPage(
                  // id: message.data['_id'],
                  player: player,
                  title: prefs.getString('title'),
                  body: prefs.getString('body'),
                  date: currentDate,
                ));
            didChangeAppLifecycleState(AppLifecycleState.resumed);
          }
        }
      },
    );

    /// 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) async {
        // audioPlayerState == AudioPlayerState.PLAYING?pauseMusic():playMusic();
        // AndroidNotification? android = message.notification?.android;
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          NotificationManager.handleNotificationMsg(message, context);
          // player.play(AssetSource('ringing.mp3'));
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

          title = message.notification!.title!;
          body = message.notification!.body!;
        }
      },
    );

    /// 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);

          // print("message.data22 ${message.data['_id']}");
          // if (message.data['_id'] != null) {}
          Get.to(() => FcmPage(
                // id: message.data['_id'],
                player: player,
                title: message.notification!.title,
                body: message.notification!.body,
                date: currentDate,
              ));
        }
      },
    );

    // dashboardActivity.getDashboardActivity(pageCount);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final SendPort? send =
          IsolateNameServer.lookupPortByName('stop_beep_send_port');
      if (send != null) {
        send.send([
          'test',
          1
        ]); // You can send any object over, ['test', 1] is just an example
      }
    } else if (state == AppLifecycleState.paused) {
      final SendPort? send =
          IsolateNameServer.lookupPortByName('stop_beep_send_port');
      if (send != null) {
        send.send([
          'test',
          1
        ]); // You can send any object over, ['test', 1] is just an example
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: const BottomNavigationBarClass(),
        key: key,
        drawer: mainDrawer(context, applicationBloc),
        appBar: AppBar(
          backgroundColor: splashBackgroundColor,
          leading: IconButton(
            enableFeedback: true,
            splashRadius: context.mediaQueryWidth / 22,
            onPressed: () {
              key.currentState!.openDrawer();
            },
            icon: SvgPicture.asset(
                'assets/images/dashboard_screen/side menu.svg'),
          ),
          centerTitle: true,
          title: Text(
            'projectTitle'.tr,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 2,
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 10),
          //     child: GestureDetector(
          //       onTap: (){
          //        Get.toNamed('/fcmPage');
          //       },
          //         child: Icon(
          //       Icons.notifications,
          //     )),
          //   )
          // ],
        ),
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
              margin: EdgeInsets.only(
                  bottom: context.mediaQueryWidth / 10,
                  left: context.mediaQueryWidth / 5,
                  right: context.mediaQueryWidth / 5),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Text(
                'exitSnackBarMessage'.tr,
                textAlign: TextAlign.center,
              )),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: RefreshIndicator(
              color: splashBackgroundColor,
              onRefresh: () {
                return Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    hasNextPage = true;
                    page = 1;
                    dashboardActivityVm.getDashboardActivityData.clear();
                    dashboardActivityVm.isLoading.value = true;
                    dashboardActivityVm.getDashboardActivity(page);
                  });
                });
              },
              child: Stack(
                children: [
                  SizedBox(
                    height: context.mediaQueryHeight,
                    width: context.mediaQueryWidth,
                  ),
                  Obx(
                    () => ModalProgressHUD(
                      color: Colors.transparent,
                      inAsyncCall: dashboardActivityVm.isLoading.value == true,
                      progressIndicator: progressIndicator(),
                      child: ListView(
                        controller: controller,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: context.mediaQueryHeight / 4.5,
                                decoration: BoxDecoration(
                                  color: splashBackgroundColor,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                    context.mediaQueryHeight / 75),
                                margin: EdgeInsets.only(
                                  left: context.mediaQueryWidth / 30,
                                  right: context.mediaQueryWidth / 30,
                                  top: context.mediaQueryHeight / 40,
                                ),
                                decoration: BoxDecoration(
                                    color: const Color(0XFFD8E8F2),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SvgPicture.asset(
                                        'assets/images/dashboard_screen/user.svg',
                                        height: context.mediaQueryHeight / 45,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Text(
                                        userProfileModal.fullName.isEmpty
                                            ? '${'welcome'.tr} - ${nameStorage.read('userName')}'
                                            : '${'welcome'.tr} - ${userProfileModal.fullName}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: context.mediaQueryWidth / 30,
                                      right: context.mediaQueryWidth / 30,
                                      top: context.mediaQueryHeight / 10),
                                  height: context.mediaQueryHeight / 4.1,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 4,
                                          spreadRadius: 0.5,
                                          offset: const Offset(0, 2))
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // Get.toNamed('/enquiryScreen');
                                            },
                                            child: Container(
                                              height:
                                                  context.mediaQueryWidth / 4,
                                              width:
                                                  context.mediaQueryWidth / 3.8,
                                              padding: EdgeInsets.only(
                                                  top:
                                                      context.mediaQueryHeight /
                                                          50),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0XFFF5F7FF)),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/images/dashboard_screen/Enquiry - Service.svg'),
                                                  SizedBox(
                                                    height: context
                                                            .mediaQueryWidth /
                                                        40,
                                                  ),
                                                  Text(
                                                    'enquiry_service'.tr,
                                                    style: TextStyle(
                                                        fontSize: context
                                                                .mediaQueryWidth /
                                                            34),
                                                  ),
                                                  Text(
                                                    'request'.tr,
                                                    style: TextStyle(
                                                        fontSize: context
                                                                .mediaQueryWidth /
                                                            34),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                context.mediaQueryHeight / 60,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // Get.toNamed('/decisionsProceedingsScreen');
                                            },
                                            child: Container(
                                              height:
                                                  context.mediaQueryHeight / 16,
                                              width:
                                                  context.mediaQueryWidth / 3.8,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0XFF6A86EB)),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/images/dashboard_screen/Decisions & Proceed.svg',
                                                    height: 15,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: VerticalDivider(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    'decision_proceedings'.tr,
                                                    style: TextStyle(
                                                        fontSize: context
                                                                .mediaQueryWidth /
                                                            38,
                                                        color: const Color(
                                                            0XFF5D7AE0)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            // onTap: () => Get.toNamed('/complaintsScreen'),
                                            child: Container(
                                              height:
                                                  context.mediaQueryWidth / 4,
                                              width:
                                                  context.mediaQueryWidth / 3.8,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0XFFF5F7FF)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/images/dashboard_screen/Complaints.svg'),
                                                    SizedBox(
                                                      height: context
                                                              .mediaQueryWidth /
                                                          40,
                                                    ),
                                                    Text(
                                                      'complaints'.tr,
                                                      style: TextStyle(
                                                          fontSize: context
                                                                  .mediaQueryWidth /
                                                              34),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                context.mediaQueryHeight / 60,
                                          ),
                                          GestureDetector(
                                            // onTap: () => Get.toNamed('/addFamilyMemberScreen'),
                                            child: Container(
                                              height:
                                                  context.mediaQueryHeight / 16,
                                              width:
                                                  context.mediaQueryWidth / 3.8,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0XFF6A86EB)),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/images/dashboard_screen/Add family.svg',
                                                    height: 15,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: VerticalDivider(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    'addFamilyMember'.tr,
                                                    style: TextStyle(
                                                        fontSize: context
                                                                .mediaQueryWidth /
                                                            38,
                                                        color: const Color(
                                                            0XFF5D7AE0)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: context.mediaQueryWidth / 4,
                                            width:
                                                context.mediaQueryWidth / 3.8,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color(0XFFF5F7FF)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/images/dashboard_screen/Downloads.svg'),
                                                  SizedBox(
                                                    height: context
                                                            .mediaQueryWidth /
                                                        25,
                                                  ),
                                                  Text(
                                                    'downloads'.tr,
                                                    style: TextStyle(
                                                        fontSize: context
                                                                .mediaQueryWidth /
                                                            34),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                context.mediaQueryHeight / 60,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              userProfileModal
                                                  .getUserProfileInfo();
                                              Get.toNamed('/profileScreen');
                                            },
                                            child: Container(
                                              height:
                                                  context.mediaQueryHeight / 16,
                                              width:
                                                  context.mediaQueryWidth / 3.8,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0XFF6A86EB)),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  SvgPicture.asset(
                                                    'assets/images/dashboard_screen/my profile.svg',
                                                    height: 15,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: VerticalDivider(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    'myProfile'.tr,
                                                    style: TextStyle(
                                                        fontSize: context
                                                                .mediaQueryWidth /
                                                            38,
                                                        color: const Color(
                                                            0XFF5D7AE0)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: context.mediaQueryHeight / 60,
                                    left: context.mediaQueryWidth / 30),
                                child: Text(
                                  'grampachayatActivities'.tr,
                                  style: TextStyle(
                                      fontSize: context.mediaQueryHeight / 55,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: context.mediaQueryHeight / 100,
                                    bottom: context.mediaQueryWidth / 40),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: dashboardActivityVm
                                      .getDashboardActivityData.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () async {
                                      if (dashboardActivityVm
                                              .getDashboardActivityData[index]
                                              .commentCount >
                                          0) {
                                        await getCommentData.getComment(
                                            GetCommentModal(),
                                            dashboardActivityVm
                                                .getDashboardActivityData[index]
                                                .id);
                                        Get.toNamed('/activityPostDetailScreen',
                                            arguments: dashboardActivityVm
                                                .getDashboardActivityData[index]
                                                .id);
                                      } else {
                                        getCommentData.getCommentInfo.clear();
                                        getCommentData.isLoading.value = false;
                                        Get.toNamed('/activityPostDetailScreen',
                                            arguments: dashboardActivityVm
                                                .getDashboardActivityData[index]
                                                .id);
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                          left: context.mediaQueryWidth / 30,
                                          right: context.mediaQueryWidth / 30,
                                          bottom:
                                              context.mediaQueryHeight / 150,
                                        ),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade400,
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 1))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white),
                                        child: Card(
                                          elevation: 0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                  minVerticalPadding:
                                                      context.mediaQueryHeight /
                                                          50,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  visualDensity:
                                                      const VisualDensity(
                                                    horizontal: -4,
                                                  ),
                                                  leading: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: context
                                                              .mediaQueryWidth /
                                                          120,
                                                    ),
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          const NetworkImage(
                                                              'https://picsum.photos/200'),
                                                      radius: context
                                                              .mediaQueryWidth /
                                                          20,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    dashboardActivityVm
                                                        .getDashboardActivityData[
                                                            index]
                                                        .adminName,
                                                    style: TextStyle(
                                                        fontSize: context
                                                                .mediaQueryWidth /
                                                            28,
                                                        color: const Color(
                                                            0XFF284ED6)),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        dashboardActivityVm
                                                            .getDashboardActivityData[
                                                                index]
                                                            .locationName,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: context
                                                                  .mediaQueryWidth /
                                                              44,
                                                          color: Colors
                                                              .grey.shade600,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            dashboardActivityVm
                                                                .getDashboardActivityData[
                                                                    index]
                                                                .activityDate,
                                                            style: TextStyle(
                                                                fontSize: context
                                                                        .mediaQueryWidth /
                                                                    44,
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            dashboardActivityVm
                                                                .getDashboardActivityData[
                                                                    index]
                                                                .createdTime,
                                                            style: TextStyle(
                                                                fontSize: context
                                                                        .mediaQueryWidth /
                                                                    44,
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  trailing: Column(
                                                    children: [
                                                      /*SvgPicture.asset(
                                                        'assets/images/dashboard_screen/resize.svg'),*/
                                                      Theme(
                                                        data: Theme.of(context)
                                                            .copyWith(
                                                          highlightColor: Colors
                                                              .transparent,
                                                          // splashColor: Colors.transparent,
                                                        ),
                                                        child: PopupMenuButton(
                                                          iconSize: context
                                                                  .mediaQueryWidth /
                                                              18,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          offset: const Offset(
                                                              20, 40),
                                                          splashRadius: context
                                                                  .mediaQueryWidth /
                                                              25,
                                                          onSelected: (value) {
                                                            showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                actionsAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                actionsPadding:
                                                                    EdgeInsets.only(
                                                                        bottom: context.mediaQueryHeight /
                                                                            50),
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top: context
                                                                          .mediaQueryHeight /
                                                                      60,
                                                                  bottom: context
                                                                          .mediaQueryHeight /
                                                                      80,
                                                                  left: context
                                                                          .mediaQueryWidth /
                                                                      8,
                                                                  right: context
                                                                          .mediaQueryWidth /
                                                                      8,
                                                                ),
                                                                title: Column(
                                                                  children: [
                                                                    ClipRRect(
                                                                        child:
                                                                            Icon(
                                                                      Icons
                                                                          .warning_amber,
                                                                      color: Colors
                                                                          .amber,
                                                                      size: context
                                                                              .mediaQueryHeight /
                                                                          20,
                                                                    )),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      'alert'
                                                                          .tr
                                                                          .padRight(
                                                                              30,
                                                                              ' '),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          // fontFamily: 'Montserrat-Medium',
                                                                          fontSize: 17,
                                                                          fontWeight: FontWeight.w400),
                                                                    )
                                                                  ],
                                                                ),
                                                                content: Text(
                                                                  'popupContentTitle'
                                                                      .tr,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                                                    color: Colors
                                                                        .redAccent,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    height:
                                                                        context.mediaQueryHeight /
                                                                            25,
                                                                    child: Text(
                                                                        'cancelBtn'
                                                                            .tr,
                                                                        style: const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Colors.white)),
                                                                  ),
                                                                  MaterialButton(
                                                                    color: Colors
                                                                        .green,
                                                                    height:
                                                                        context.mediaQueryHeight /
                                                                            25,
                                                                    onPressed:
                                                                        () async {
                                                                      deleteActivityVm
                                                                          .isLoading
                                                                          .value = true;
                                                                      await applicationBloc.deleteDashboardPost(
                                                                          deleteActivityVm,
                                                                          dashboardActivityVm,
                                                                          dashboardActivityVm
                                                                              .getDashboardActivityData[index]
                                                                              .id,
                                                                          index);
                                                                      if (deleteActivityVm
                                                                              .isLoading
                                                                              .value ==
                                                                          false) {
                                                                        if (deleteActivityVm.statusCode ==
                                                                            200) {
                                                                          // dashboardActivityVm.getDashboardActivityData.removeAt(index);

                                                                          UtilityMethods.snackBarMethod(
                                                                              context,
                                                                              'postDeleteMsg'.tr);
                                                                        } else if (deleteActivityVm.statusCode ==
                                                                            409) {
                                                                          UtilityMethods.snackBarMethod(
                                                                              context,
                                                                              'postDeleteErrorMsg'.tr);
                                                                        }
                                                                      }
                                                                      Get.back();
                                                                    },
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child: Text(
                                                                      'okBtn'
                                                                          .tr,
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          itemBuilder:
                                                              (context) {
                                                            return [
                                                              PopupMenuItem(
                                                                value:
                                                                    '/delete',
                                                                height: 0.5,
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'deleteBtn'
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              context.mediaQueryWidth / 30),
                                                                    )),
                                                              )
                                                            ];
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                              dashboardActivityVm
                                                      .getDashboardActivityData[
                                                          index]
                                                      .description
                                                      .isNotEmpty
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          left: context
                                                                  .mediaQueryWidth /
                                                              80),
                                                      child: Text(
                                                        dashboardActivityVm
                                                            .getDashboardActivityData[
                                                                index]
                                                            .description,
                                                        style: TextStyle(
                                                          fontSize: context
                                                                  .mediaQueryWidth /
                                                              30,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              dashboardActivityVm
                                                      .getDashboardActivityData[
                                                          index]
                                                      .dashboardActivityImages
                                                      .isNotEmpty
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          left: context
                                                                  .mediaQueryWidth /
                                                              120,
                                                          top: context
                                                                  .mediaQueryHeight /
                                                              120,
                                                          right: context
                                                                  .mediaQueryWidth /
                                                              120),
                                                      child: dashboardActivityVm
                                                                  .getDashboardActivityData[
                                                                      index]
                                                                  .dashboardActivityImages
                                                                  .length >
                                                              2
                                                          ? Container(
                                                              clipBehavior:
                                                                  Clip.hardEdge,
                                                              height: context
                                                                      .mediaQueryHeight /
                                                                  3.9,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4)),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              2),
                                                                      child:
                                                                          Container(
                                                                        height: MediaQuery.of(context).size.height /
                                                                            3.9,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius: const BorderRadius.only(
                                                                              topLeft: Radius.circular(5),
                                                                              bottomLeft: Radius.circular(5)),
                                                                          gradient: LinearGradient(
                                                                              colors: [
                                                                                Colors.white,
                                                                                splashBackgroundColor
                                                                              ],
                                                                              begin: Alignment.topLeft,
                                                                              end: Alignment.bottomRight),
                                                                        ),
                                                                        child:
                                                                            Image(
                                                                            image: CachedNetworkImageProvider( dashboardActivityVm
                                                                                .getDashboardActivityData[index]
                                                                                .dashboardActivityImages[0]['imagePath']),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          filterQuality:
                                                                              FilterQuality.low,
                                                                         gaplessPlayback: true,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(bottom: 2),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                MediaQuery.of(context).size.height / 7.84,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                                                                              gradient: LinearGradient(colors: [
                                                                                Colors.white,
                                                                                splashBackgroundColor
                                                                              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                                                            ),
                                                                            child:
                                                                                Image(
                                                                                  image:CachedNetworkImageProvider(dashboardActivityVm.getDashboardActivityData[index].dashboardActivityImages[1]['imagePath']),
                                                                              fit: BoxFit.cover,
                                                                                  gaplessPlayback: true,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              MediaQuery.of(context).size.height / 8,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                                                                            gradient:
                                                                                LinearGradient(colors: [
                                                                              Colors.white,
                                                                              splashBackgroundColor
                                                                            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                                                          ),
                                                                          child:
                                                                              Image(
                                                                                image:CachedNetworkImageProvider(dashboardActivityVm.getDashboardActivityData[index].dashboardActivityImages[2]['imagePath']),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                                gaplessPlayback: true,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          : dashboardActivityVm
                                                                      .getDashboardActivityData[
                                                                          index]
                                                                      .dashboardActivityImages
                                                                      .length >
                                                                  1
                                                              ? Container(
                                                                  clipBehavior:
                                                                      Clip.hardEdge,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      1.9,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    gradient:
                                                                    LinearGradient(colors: [
                                                                      Colors.white,
                                                                      splashBackgroundColor
                                                                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: 2),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 1.9,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                                                                            ),
                                                                            child:
                                                                                Image(
                                                                                  image:CachedNetworkImageProvider(dashboardActivityVm.getDashboardActivityData[index].dashboardActivityImages[0]['imagePath']),
                                                                              fit: BoxFit.cover,
                                                                                  gaplessPlayback: true,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.of(context).size.width / 1.9,
                                                                          decoration:
                                                                               BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                                                                                gradient:
                                                                                LinearGradient(colors: [
                                                                                  Colors.white,
                                                                                  splashBackgroundColor
                                                                                ], begin: Alignment.topLeft, end: Alignment.bottomRight),

                                                                          ),
                                                                          child:
                                                                              Image(
                                                                                image:CachedNetworkImageProvider(dashboardActivityVm.getDashboardActivityData[index].dashboardActivityImages[1]['imagePath']),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                                gaplessPlayback: true,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : Container(
                                                                  clipBehavior:
                                                                      Clip.hardEdge,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      3.9,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      gradient: LinearGradient(
                                                                          colors: [
                                                                            Colors.white,
                                                                            splashBackgroundColor
                                                                          ],
                                                                          begin: Alignment
                                                                              .topLeft,
                                                                          end: Alignment
                                                                              .bottomRight),
                                                                    ),
                                                                    child:
                                                                        Image(
                                                                          image:CachedNetworkImageProvider( dashboardActivityVm
                                                                              .getDashboardActivityData[index]
                                                                              .dashboardActivityImages[0]['imagePath']),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                          gaplessPlayback: true,
                                                                    ),
                                                                  ),
                                                                ))
                                                  : Container(),
                                              SizedBox(
                                                height:
                                                    context.mediaQueryHeight /
                                                        120,
                                              ),
                                              SizedBox(
                                                  height:
                                                      context.mediaQueryWidth /
                                                          60),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    '${dashboardActivityVm.getDashboardActivityData[index].likeConut} ${'like'.tr}',
                                                    style: TextStyle(
                                                        fontSize: context
                                                                .mediaQueryHeight /
                                                            65,
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                      '${dashboardActivityVm.getDashboardActivityData[index].commentCount} ${'comment'.tr}',
                                                      style: TextStyle(
                                                          fontSize: context
                                                                  .mediaQueryHeight /
                                                              65,
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  Text(
                                                      '${dashboardActivityVm.getDashboardActivityData[index].shareCount} ${'share'.tr}',
                                                      style: TextStyle(
                                                          fontSize: context
                                                                  .mediaQueryHeight /
                                                              65,
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ],
                                              ),
                                              const Divider(
                                                thickness: 1,
                                                endIndent: 5,
                                                indent: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        /*  setState(() {
                                                        isLiked = !isLiked;
                                                    });*/
                                                        // dashboardActivity.isLoading.value = true;
                                                        await applicationBloc.chekLikeValue(
                                                            dashboardActivityVm
                                                                .getDashboardActivityData[
                                                                    index]
                                                                .id,
                                                            dashboardActivityVm
                                                                .getDashboardActivityData[
                                                                    index]
                                                                .likeDislike);

                                                        // await dashboardActivity.getDashboardActivity(pageCount);
                                                        // await  dashboardActivity.getDashboardActivity(pageCount);
                                                      },
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        padding:
                                                            EdgeInsets.only(
                                                          bottom: context
                                                                  .mediaQueryHeight /
                                                              150,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            !dashboardActivityVm
                                                                    .getDashboardActivityData[
                                                                        index]
                                                                    .likeDislike
                                                                ? Icon(
                                                                    Icons
                                                                        .thumb_up_outlined,
                                                                    size: context
                                                                            .mediaQueryHeight /
                                                                        32,
                                                                    color: Colors
                                                                        .black87
                                                                        .withOpacity(
                                                                            0.7),
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .thumb_up,
                                                                    size: context
                                                                            .mediaQueryHeight /
                                                                        35,
                                                                    color:
                                                                        splashBackgroundColor,
                                                                  ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              'like'.tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      context.mediaQueryHeight /
                                                                          60,
                                                                  color: Colors
                                                                      .black87
                                                                      .withOpacity(
                                                                          0.7)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        getCommentData.isLoading
                                                            .value = false;
                                                        commentController
                                                            .clear();
                                                        print(dashboardActivityVm
                                                            .getDashboardActivityData[
                                                                index]
                                                            .id);
                                                        applicationBloc.getActivityId(
                                                            dashboardActivityVm
                                                                .getDashboardActivityData[
                                                                    index]
                                                                .id);

                                                        ///get comment by activityId
                                                        if (dashboardActivityVm
                                                                .getDashboardActivityData[
                                                                    index]
                                                                .commentCount >
                                                            0) {
                                                          setState(() {
                                                            getCommentData.getComment(
                                                                GetCommentModal(),
                                                                dashboardActivityVm
                                                                    .getDashboardActivityData[
                                                                        index]
                                                                    .id);

                                                            getCommentData
                                                                .isLoading
                                                                .value = true;
                                                          });
                                                        }

                                                        ///parent modal bottom-sheet
                                                        showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            20),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20))),
                                                            context: context,
                                                            builder: (context) {
                                                              Iterable<GetDashboardActivity> data = dashboardActivityVm
                                                                  .getDashboardActivityData
                                                                  .where((element) =>
                                                                      element
                                                                          .id ==
                                                                      dashboardActivityVm
                                                                          .getDashboardActivityData[
                                                                              index]
                                                                          .id);

                                                              return commonBottomsheet(
                                                                  context,
                                                                  applicationBloc:
                                                                      applicationBloc,
                                                                  createdDate: dashboardActivityVm
                                                                      .getDashboardActivityData[
                                                                          index]
                                                                      .createdDate,
                                                                  locationName: dashboardActivityVm
                                                                      .getDashboardActivityData[
                                                                          index]
                                                                      .locationName,
                                                                  description: dashboardActivityVm
                                                                      .getDashboardActivityData[
                                                                          index]
                                                                      .description,
                                                                  commentCount: dashboardActivityVm
                                                                      .getDashboardActivityData[
                                                                          index]
                                                                      .commentCount,
                                                                  createdTime: dashboardActivityVm
                                                                      .getDashboardActivityData[
                                                                          index]
                                                                      .createdTime,
                                                                  likeCount: dashboardActivityVm
                                                                      .getDashboardActivityData[
                                                                          index]
                                                                      .likeConut,
                                                                  userName: dashboardActivityVm
                                                                      .getDashboardActivityData[
                                                                          index]
                                                                      .userName,
                                                                  activityId: dashboardActivityVm
                                                                      .getDashboardActivityData[
                                                                          index]
                                                                      .id,
                                                                  data: data,
                                                                  shareCount: dashboardActivity
                                                                      .getDashboardActivityData[
                                                                          index]
                                                                      .shareCount);
                                                            });
                                                      },
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        padding:
                                                            EdgeInsets.only(
                                                          bottom: context
                                                                  .mediaQueryHeight /
                                                              150,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .mode_comment_outlined,
                                                              size: context
                                                                      .mediaQueryHeight /
                                                                  32,
                                                              color: Colors
                                                                  .black87
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            const SizedBox(
                                                                width: 3),
                                                            Text(
                                                              'comment'.tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      context.mediaQueryHeight /
                                                                          60,
                                                                  color: Colors
                                                                      .black87
                                                                      .withOpacity(
                                                                          0.7)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        final result =
                                                            await Share
                                                                .shareWithResult(
                                                          "https://i.diawi.com/tvsEXB",
                                                        );
                                                        print(
                                                            '#######${result.status}********');
                                                      },
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        padding:
                                                            EdgeInsets.only(
                                                          bottom: context
                                                                  .mediaQueryHeight /
                                                              150,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.share,
                                                              size: context
                                                                      .mediaQueryHeight /
                                                                  32,
                                                              color: Colors
                                                                  .black87
                                                                  .withOpacity(
                                                                      0.7),
                                                            ),
                                                            const SizedBox(
                                                                width: 3),
                                                            Text(
                                                              'share'.tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      context.mediaQueryHeight /
                                                                          60,
                                                                  color: Colors
                                                                      .black87
                                                                      .withOpacity(
                                                                          0.7)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              if (isLoadMoreRunning == true)
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 40,
                                    width:
                                        MediaQuery.of(context).size.width / 20,
                                    child: CircularProgressIndicator(
                                      color: splashBackgroundColor,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ))
                            ],
                          ),
                        ],
                      ),
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
