import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/common_widgets/progress_indicator.dart';
import 'package:gramsuvidha/modal/getDashboardActivityModal.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:gramsuvidha/view/postDetailImageZoom.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../blocs/application_bloc.dart';
import '../modal/deleteCommentModal.dart';
import '../modal/getCommentModal.dart';
import '../modal/updateCommentModal.dart';
import '../utility/common_widgets.dart';
import '../utility/textcontroller.dart';
import '../utility/utilityColor.dart';
import '../view_modal/activity_like_vm.dart';
import '../view_modal/getCommentVm.dart';
import '../view_modal/getDashboardActivityVm.dart';
import 'package:vibration/vibration.dart';

class ActivityPostDetailScreen extends StatefulWidget {
  const ActivityPostDetailScreen({Key? key}) : super(key: key);

  @override
  State<ActivityPostDetailScreen> createState() =>
      ActivityPostDetailScreenState();
}

class ActivityPostDetailScreenState extends State<ActivityPostDetailScreen> {
  dynamic activityId;
  String? fullName;
  String? location;
  String? createdDate;
  String? createdTime;
  String? description;
  int? likeCount;
  bool? likeDislike;
  static int? commentCount;
  int? shareCount;
  var likeId = 0;
  List<dynamic> imageList = [];

  final dashboardActivityVm = Get.put(GetDashboardActivityVm());
  final activityLikeVm = Get.put(ActivityLikeVm());
  final getCommentData = Get.put(GetCommentVm());

  @override
  void initState() {
    // dashboardActivity.getDashboardActivity(page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    activityId = ModalRoute.of(context)!.settings.arguments;
    Iterable<GetDashboardActivity> data = dashboardActivity
        .getDashboardActivityData
        .where((element) => element.id == activityId);
    for (var value in data) {
      if (value.id == activityId) {
        fullName = value.adminName;
        location = value.locationName;
        createdDate = value.createdDate;
        createdTime = value.createdTime;
        description = value.description;
        likeCount = value.likeConut;
        likeDislike = value.likeDislike;
        commentCount = value.commentCount;
        shareCount = value.shareCount;
        imageList = value.dashboardActivityImages;
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashBackgroundColor,
        centerTitle: true,
        title: Text(
          'postDetailAppBarTitle'.tr,
          style: TextStyle(fontSize: context.mediaQueryWidth / 21),
        ),
        leading: IconButton(
            enableFeedback: true,
            splashRadius: context.mediaQueryWidth / 22,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded, size: 22)),
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: getCommentData.isLoading.value == true,
          progressIndicator: progressIndicator(),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: Padding(
                padding: EdgeInsets.only(
                    left: context.mediaQueryWidth / 45,
                    right: context.mediaQueryWidth / 45,
                    top: context.mediaQueryHeight / 40),
                child: Column(
                  children: [
                    Column(
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
                                    fullName ?? '',
                                    style: TextStyle(
                                        fontSize: context.mediaQueryWidth / 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87.withOpacity(0.8)),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    location ?? '',
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
                                        createdDate ?? '',
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
                                        createdTime ?? '',
                                        style: TextStyle(
                                          fontSize:
                                              context.mediaQueryWidth / 40,
                                          color:
                                              Colors.black87.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                          height: 0,
                        ),
                      ],
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            description ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: context.mediaQueryWidth / 30,
                                color: Colors.black87),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: imageList.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageZoomPage(
                                          imageUrl: imageList[index]
                                              ['imagePath'],
                                        ),
                                      ));
                                },
                                child: Container(
                                  height: context.mediaQueryHeight / 2.8,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(3),
                                      image: DecorationImage(
                                          filterQuality: FilterQuality.low,
                                          image: NetworkImage(
                                              imageList[index]['imagePath']))),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.mediaQueryWidth / 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$likeCount ${'like'.tr}',
                                style: TextStyle(
                                    fontSize: context.mediaQueryHeight / 65,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '$commentCount ${'comment'.tr}',
                                style: TextStyle(
                                    fontSize: context.mediaQueryHeight / 65,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '$shareCount ${'share'.tr}',
                                style: TextStyle(
                                    fontSize: context.mediaQueryHeight / 65,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),

                          ///Divider
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    /*    setState(() {
                                          likeId = likeCount! > 0?0:1;
                                        });
                                        GramsuvidhaDashboardScreenState.hasNextPage = true;
                                        page = 1;
                                        dashboardActivity.getDashboardActivityData.clear();
                                        await activityLikeVm.getActivityLikeCount(LikeActivityModal(), activityId, likeId);
                                        dashboardActivity.isLoading.value = true;
                                        await dashboardActivity.getDashboardActivity(page);*/
                                    await applicationBloc.chekLikeValue(
                                        activityId, likeDislike!);
                                    applicationBloc.onPresses(
                                        data,
                                        fullName!,
                                        location!,
                                        createdDate!,
                                        createdTime!,
                                        description!,
                                        likeCount!,
                                        commentCount!,
                                        shareCount!,
                                        imageList);

                                    // dashboardActivity.isLoading.value = true;
                                    // dashboardActivity.getDashboardActivity(pageCount);
                                    // await dashboardActivity.getDashboardActivity(pageCount);
                                  },
                                  child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.only(
                                        bottom: context.mediaQueryHeight / 150,
                                      ),
                                      child: Row(
                                        children: [
                                          likeDislike == true
                                              ? Icon(
                                                  Icons.thumb_up,
                                                  size:
                                                      context.mediaQueryHeight /
                                                          32,
                                                  color: splashBackgroundColor,
                                                )
                                              : Icon(
                                                  Icons.thumb_up_outlined,
                                                  size:
                                                      context.mediaQueryHeight /
                                                          32,
                                                  color: Colors.black87
                                                      .withOpacity(0.7),
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
                                                color: Colors.black87
                                                    .withOpacity(0.7)),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    commentController.clear();
                                    applicationBloc.getActivityId(activityId);
                                    // dashboardActivity.getDashboardActivity(page);
                                    ///get comment by activityId
                                    if (commentCount! > 0) {
                                      setState(() {
                                        getCommentData.getComment(
                                            GetCommentModal(), activityId);
                                        getCommentData.isLoading.value = true;
                                      });
                                    }
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      context: context,
                                      builder: (context) {
                                        return commonBottomsheet(context,
                                            applicationBloc: applicationBloc,
                                            createdDate: createdDate!,
                                            locationName: location!,
                                            description: description!,
                                            commentCount: commentCount!,
                                            createdTime: createdTime!,
                                            likeCount: likeCount!,
                                            userName: fullName!,
                                            activityId: activityId,
                                            data: data,
                                            shareCount: shareCount!);
                                      },
                                    );
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.only(
                                      bottom: context.mediaQueryHeight / 150,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mode_comment_outlined,
                                          size: context.mediaQueryHeight / 32,
                                          color:
                                              Colors.black87.withOpacity(0.7),
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          'comment'.tr,
                                          style: TextStyle(
                                              fontSize:
                                                  context.mediaQueryHeight / 60,
                                              color: Colors.black87
                                                  .withOpacity(0.7)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    final result = await Share.shareWithResult(
                                      "https://i.diawi.com/tvsEXB",
                                    );
                                    print('#########${result.status}*******');
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.only(
                                      bottom: context.mediaQueryHeight / 150,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.share,
                                          size: context.mediaQueryHeight / 32,
                                          color:
                                              Colors.black87.withOpacity(0.7),
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          'share'.tr,
                                          style: TextStyle(
                                              fontSize:
                                                  context.mediaQueryHeight / 60,
                                              color: Colors.black87
                                                  .withOpacity(0.7)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///Listview builder
                          ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                                top: context.mediaQueryHeight / 40,
                                bottom: context.mediaQueryHeight / 150),
                            itemCount: getCommentData.getCommentInfo.length,
                            itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: context.mediaQueryHeight / 150),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 4,
                                      ),
                                      child: CircleAvatar(
                                        radius: context.mediaQueryWidth / 23,
                                        backgroundColor:
                                            Colors.grey.withOpacity(.6),
                                        child: CircleAvatar(
                                          radius: context.mediaQueryWidth / 24,
                                          backgroundColor: Colors.white,
                                          backgroundImage: const NetworkImage(
                                              'https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8?format=png&name=large'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.mediaQueryWidth / 70,
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: GestureDetector(
                                        onLongPress: () {
// (updateCommentVm.isComment == true)?Get.back():
                                          Vibration.vibrate(duration: 100);
                                          var loginUser =
                                              userIdValue.read('userId');
                                          var commentUser = getCommentData
                                              .getCommentInfo[index].createdBy;

                                          loginUser == commentUser
                                              ? showModalBottomSheet(
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20))),
                                                  context: context,
                                                  builder: (context) =>
                                                      Container(
                                                    height: context
                                                            .mediaQueryHeight /
                                                        5,
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
                                                            applicationBloc.updateCommentControllerFun(
                                                                getCommentData
                                                                    .getCommentInfo[
                                                                        index]
                                                                    .comments!);
                                                            showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20))),
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      Padding(
                                                                padding: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets,
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          context.mediaQueryWidth /
                                                                              15),
                                                                  height: context
                                                                          .mediaQueryHeight /
                                                                      3.5,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      ///Navigation
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                0,
                                                                            child:
                                                                                GestureDetector(
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
                                                                            width:
                                                                                context.mediaQueryWidth / 20,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
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
                                                                            flex:
                                                                                0,
                                                                            child:
                                                                                CircleAvatar(
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
                                                                            width:
                                                                                context.mediaQueryWidth / 25,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              fullName!,
                                                                              style: TextStyle(fontSize: context.mediaQueryWidth / 25, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),

                                                                      ///update comment text field
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                TextFormField(
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
                                                                                hintStyle: TextStyle(
                                                                                  fontSize: context.mediaQueryHeight / 50,
                                                                                ),
                                                                                filled: true,
                                                                                contentPadding: EdgeInsets.only(
                                                                                  left: context.mediaQueryWidth / 30,
                                                                                  top: context.mediaQueryHeight / 70,
                                                                                  bottom: context.mediaQueryHeight / 70,
                                                                                ),
                                                                                fillColor: Colors.grey.shade300,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                context.mediaQueryWidth / 30,
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

                                                                                    /*   Timer(const Duration(seconds: 2), () {
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
                                                                  size: context
                                                                          .mediaQueryWidth /
                                                                      17),
                                                              SizedBox(
                                                                width: context
                                                                        .mediaQueryWidth /
                                                                    50,
                                                              ),
                                                              Text(
                                                                'editBtn'.tr,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        context.mediaQueryWidth /
                                                                            23),
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
                                                                contentPadding: EdgeInsets.only(
                                                                    left: context
                                                                            .mediaQueryWidth /
                                                                        10,
                                                                    right: context
                                                                            .mediaQueryWidth /
                                                                        10,
                                                                    top: context
                                                                            .mediaQueryHeight /
                                                                        60,
                                                                    bottom:
                                                                        context.mediaQueryHeight /
                                                                            80),
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
                                                                          15,
                                                                    )),
                                                                    Text(
                                                                      'alert'
                                                                          .tr,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          // fontFamily: 'Montserrat-Medium',
                                                                          fontSize: context.mediaQueryHeight / 50,
                                                                          fontWeight: FontWeight.w400),
                                                                    )
                                                                  ],
                                                                ),
                                                                content: Text(
                                                                  'deleteCommentTitle'
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
                                                                            23,
                                                                    child: Text(
                                                                        'no'.tr,
                                                                        style: TextStyle(
                                                                            fontSize: context.mediaQueryWidth /
                                                                                30,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Colors.white)),
                                                                  ),
                                                                  MaterialButton(
                                                                    color: Colors
                                                                        .green,
                                                                    height:
                                                                        context.mediaQueryHeight /
                                                                            23,
                                                                    onPressed:
                                                                        () async {
                                                                      await deleteCommentVm.deleteComment(
                                                                          context,
                                                                          DeleteCommentModal(),
                                                                          getCommentData
                                                                              .getCommentInfo[index]
                                                                              .id!);

                                                                      /* dashboardActivity.getDashboardActivityData.clear();
                                                                  dashboardActivity
                                                                      .isLoading
                                                                      .value = true;
                                                                  await dashboardActivity.getDashboardActivity(page);
                                                                  dashboardActivity
                                                                      .isLoading
                                                                      .value = false;*/

                                                                      getCommentData
                                                                          .isLoading
                                                                          .value = true;

                                                                      ///Get comment by Activity Id
                                                                      Timer(
                                                                          const Duration(
                                                                              seconds: 2),
                                                                          () async {
                                                                        await getCommentData.getComment(
                                                                            GetCommentModal(),
                                                                            getCommentData.getCommentInfo[index].activityId!);
                                                                        print(
                                                                            '#######${getCommentData.getCommentInfo.length}#######');
                                                                        await applicationBloc.onPresses(
                                                                            data,
                                                                            fullName!,
                                                                            location!,
                                                                            createdDate!,
                                                                            createdTime!,
                                                                            description!,
                                                                            likeCount!,
                                                                            getCommentData.getCommentInfo.length,
                                                                            shareCount!,
                                                                            imageList);
                                                                        data.first.commentCount = getCommentData
                                                                            .getCommentInfo
                                                                            .length;

                                                                        /*  dashboardActivity
                                                                            .isLoading
                                                                            .value = true;*/
                                                                      });

                                                                      Timer(
                                                                          const Duration(
                                                                              seconds: 2),
                                                                          () async {
                                                                        /*await dashboardActivity
                                                                            .getDashboardActivity(page);*/
                                                                      });
                                                                    },
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child: Text(
                                                                      'yes'.tr,
                                                                      style: TextStyle(
                                                                          fontSize: context.mediaQueryWidth /
                                                                              30,
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
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .delete_forever,
                                                                  size: context
                                                                          .mediaQueryWidth /
                                                                      17),
                                                              SizedBox(
                                                                width: context
                                                                        .mediaQueryWidth /
                                                                    50,
                                                              ),
                                                              Text(
                                                                'deleteBtn'.tr,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        context.mediaQueryWidth /
                                                                            23),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    context.mediaQueryWidth /
                                                        25,
                                                vertical:
                                                    context.mediaQueryWidth /
                                                        30),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
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
                                                  height:
                                                      context.mediaQueryWidth /
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
                                                          .withOpacity(0.6)),
                                                ),
                                                SizedBox(
                                                  height:
                                                      context.mediaQueryWidth /
                                                          40,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        applicationBloc.commentTime(
                                                            DateTime.now().difference(
                                                                getCommentData
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
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(getCommentData
                                                              .getCommentInfo[
                                                                  index]
                                                              .createdDate!),
                                                      style: TextStyle(
                                                          fontSize: context
                                                                  .mediaQueryWidth /
                                                              35,
                                                          color: Colors.black87
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
                          ),

                          commentCount == 0 ||
                                  getCommentData.getCommentInfo.isEmpty
                              ? SizedBox(
                                  height: context.mediaQueryHeight / 5,
                                  child: Center(
                                    child: Text(
                                      'noCommentMsg'.tr,
                                      style: TextStyle(
                                          fontSize:
                                              context.mediaQueryWidth / 21),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ))

                    /* Padding(
                  padding:  EdgeInsets.only(bottom: context.mediaQueryWidth/20),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: getCommentData.getCommentInfo.length,
                      itemBuilder: (context, index) =>Padding(
                          padding: EdgeInsets.only(
                              right: context.mediaQueryWidth / 4,
                              top: context.mediaQueryWidth / 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: context.mediaQueryWidth / 30),
                                  child: CircleAvatar(
                                    radius: context.mediaQueryWidth / 20,
                                    backgroundColor:
                                    Colors.grey.withOpacity(.6),
                                    child: CircleAvatar(
                                      radius:
                                      context.mediaQueryWidth / 21,
                                      backgroundColor: Colors.white,
                                      backgroundImage: const NetworkImage(
                                          'https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8?format=png&name=large'),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onLongPress: () {
// (updateCommentVm.isComment == true)?Get.back():

                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                              Radius.circular(20),
                                              topRight:
                                              Radius.circular(20))),
                                      context: context,
                                      builder: (context) => SizedBox(
                                        height:
                                        context.mediaQueryWidth / 2,
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
                                                onTap: () {
                                                  applicationBloc
                                                      .updateCommentControllerFun(
                                                      getCommentData
                                                          .getCommentInfo[
                                                      index]
                                                          .comments!);

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
                                                    builder: (context) =>
                                                        Padding(
                                                          padding:
                                                          MediaQuery.of(
                                                              context)
                                                              .viewInsets,
                                                          child: SizedBox(
                                                            height: context
                                                                .mediaQueryWidth /
                                                                1.5,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: context
                                                                      .mediaQueryWidth /
                                                                      15),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                                children: [
                                                                  ///Navigation
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex:
                                                                        1,
                                                                        child:
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                          Icon(
                                                                            Icons.arrow_back_ios,
                                                                            size: context.mediaQueryWidth / 12,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex:
                                                                        5,
                                                                        child:
                                                                        Text(
                                                                          'Edit Comment',
                                                                          style:
                                                                          TextStyle(fontSize: context.mediaQueryWidth / 20),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),

                                                                  ///comment updater name
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex:
                                                                        1,
                                                                        child:
                                                                        CircleAvatar(
                                                                          radius:
                                                                          context.mediaQueryWidth / 21,
                                                                          backgroundColor:
                                                                          Colors.grey.withOpacity(.6),
                                                                          child:
                                                                          CircleAvatar(
                                                                            radius: context.mediaQueryWidth / 22,
                                                                            backgroundColor: Colors.teal,
                                                                            backgroundImage: const NetworkImage('https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8?format=png&name=large'),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex:
                                                                        5,
                                                                        child:
                                                                        Text(
                                                                          userName!,
                                                                          style:
                                                                          TextStyle(fontSize: context.mediaQueryWidth / 25, fontWeight: FontWeight.w500),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),

                                                                  ///update comment text field
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex:
                                                                        4,
                                                                        child:
                                                                        SizedBox(
                                                                          height:
                                                                          context.mediaQueryWidth / 8,
                                                                          child:
                                                                          TextFormField(
                                                                            controller: updateCommentController,
                                                                            decoration: InputDecoration(
                                                                              isDense: true,
                                                                              hintText: 'Enter comment',
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(25),
                                                                                borderSide: const BorderSide(
                                                                                  width: 0,
                                                                                  style: BorderStyle.none,
                                                                                ),
                                                                              ),
                                                                              hintStyle: const TextStyle(fontSize: 15, height: 2.7),
                                                                              filled: true,
                                                                              fillColor: Colors.grey.shade300,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                          child:
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              if (updateCommentController.text.isNotEmpty) {
                                                                                ///Update Comment Api Call Here
                                                                                await updateCommentVm.updateComment(UpdateCommentModal(), getCommentData.getCommentInfo[index].id!, getCommentData.getCommentInfo[index].activityId!, updateCommentController.text);
                                                                                Get.back();
                                                                                Get.back();
                                                                                Get.snackbar('Hey', 'Comment updated successfully', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.black87, colorText: Colors.white, duration: const Duration(seconds: 1), margin: EdgeInsets.only(bottom: context.mediaQueryWidth / 10, left: context.mediaQueryWidth / 20, right: context.mediaQueryWidth / 20));

                                                                                getCommentData.isLoading.value = true;

                                                                                ///Get comment by Activity Id
                                                                                Timer(const Duration(seconds: 2), () {
                                                                                  getCommentData.getComment(GetCommentModal(), getCommentData.getCommentInfo[index].activityId!);
                                                                                  dashboardActivity.isLoading.value = true;
                                                                                });

                                                                                Timer(const Duration(seconds: 2), () {
                                                                                  dashboardActivity.getDashboardActivity();
                                                                                });
                                                                              } else if (updateCommentController.text.isEmpty) {
                                                                                Get.snackbar('Hey', 'Please enter the comment', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.black87, colorText: Colors.white, duration: const Duration(seconds: 1), margin: EdgeInsets.only(bottom: context.mediaQueryWidth / 10, left: context.mediaQueryWidth / 20, right: context.mediaQueryWidth / 20));
                                                                              }
                                                                            },
                                                                            child:
                                                                            CircleAvatar(
                                                                              radius:
                                                                              context.mediaQueryWidth / 22,
                                                                              child:
                                                                              const Icon(
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
                                                        ),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .note_alt_outlined,
                                                        size: context
                                                            .mediaQueryWidth /
                                                            8),
                                                    SizedBox(
                                                      width: context
                                                          .mediaQueryWidth /
                                                          50,
                                                    ),
                                                    Text(
                                                      'Edit',
                                                      style: TextStyle(
                                                          fontSize: context
                                                              .mediaQueryWidth /
                                                              20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: context
                                                    .mediaQueryWidth /
                                                    30,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          actionsPadding:
                                                          const EdgeInsets
                                                              .only(
                                                              bottom: 10,
                                                              right: 20),
                                                          title: Row(
                                                            children: [
                                                              ClipRRect(
                                                                child: SvgPicture.asset(
                                                                    'assets/images/registrationOtp_screen/Gram Login Logo.svg',
                                                                    height:
                                                                    30),
                                                              ),
                                                              SizedBox(
                                                                width: context
                                                                    .mediaQueryWidth /
                                                                    50,
                                                              ),
                                                              Text(
                                                                'Delete'
                                                                    .padRight(
                                                                    30,
                                                                    ' '),
                                                                style:
                                                                const TextStyle(
// fontFamily: 'Montserrat-Medium',
                                                                    fontSize:
                                                                    17,
                                                                    fontWeight:
                                                                    FontWeight.w400),
                                                              )
                                                            ],
                                                          ),
                                                          content: const Text(
                                                            'Do you want to delete comment?',
                                                            style: TextStyle(
// fontFamily: 'Montserrat-Medium',
                                                                fontSize: 14),
                                                          ),
                                                          actions: [
// GestureDetector(
//   onTap: () {
//     Get.back();
//   },
//   child: Text(
//     'CANCEL',
//     style: TextStyle(
//         fontWeight:
//         FontWeight.w400,
//         color:
//         splashBackgroundColor),
//   ),
//
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            GestureDetector(
                                                              onTap:
                                                                  () async {
                                                                await deleteCommentVm.deleteComment(
                                                                    DeleteCommentModal(),
                                                                    getCommentData
                                                                        .getCommentInfo[
                                                                    index]
                                                                        .id!);
                                                                Get.back();
                                                                Get.back();
                                                                Get.snackbar(
                                                                    'Hey',
                                                                    'Comment deleted successfully',
                                                                    snackPosition:
                                                                    SnackPosition
                                                                        .BOTTOM,
                                                                    backgroundColor:
                                                                    Colors
                                                                        .black87,
                                                                    colorText:
                                                                    Colors
                                                                        .white,
                                                                    duration: const Duration(
                                                                        seconds:
                                                                        1),
                                                                    margin: EdgeInsets.only(
                                                                        bottom: context.mediaQueryWidth /
                                                                            10,
                                                                        left: context.mediaQueryWidth /
                                                                            20,
                                                                        right:
                                                                        context.mediaQueryWidth / 20));

                                                                getCommentData
                                                                    .isLoading
                                                                    .value = true;

                                                                ///Get comment by Activity Id
                                                                Timer(
                                                                    const Duration(
                                                                        seconds:
                                                                        2),
                                                                        () async {
                                                                      await getCommentData.getComment(
                                                                          GetCommentModal(),
                                                                          getCommentData
                                                                              .getCommentInfo[index]
                                                                              .activityId!);
                                                                      dashboardActivity
                                                                          .isLoading
                                                                          .value = true;
                                                                    });

                                                                Timer(
                                                                    const Duration(
                                                                        seconds:
                                                                        2),
                                                                        ()  {
                                                                      dashboardActivity
                                                                          .getDashboardActivity();
                                                                      applicationBloc.onPresses(
                                                                          data!,
                                                                          userName!,
                                                                          location!,
                                                                          createdDate!,
                                                                          createdTime!,
                                                                          description!,
                                                                          likeCount!,
                                                                          commentCount!,
                                                                          shareCount!);
                                                                    });
                                                              },
                                                              child: Text(
                                                                'OK',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    color:
                                                                    splashBackgroundColor),
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
                                                        size: context
                                                            .mediaQueryWidth /
                                                            8),
                                                    SizedBox(
                                                      width: context
                                                          .mediaQueryWidth /
                                                          50,
                                                    ),
                                                    Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          fontSize: context
                                                              .mediaQueryWidth /
                                                              20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left:
                                        context.mediaQueryWidth / 25,
                                        top:
                                        context.mediaQueryWidth / 20),
                                    height: context.mediaQueryWidth / 3.8,
                                    decoration: BoxDecoration(
                                        color:
                                        Colors.grey.withOpacity(.2),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userProfileModal
                                              .fullName.isEmpty
                                              ? '${nameStorage.read('userName')}'
                                              : userProfileModal.fullName,
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height:
                                          context.mediaQueryWidth /
                                              40,
                                        ),
                                        Text(
                                          getCommentData
                                              .getCommentInfo[index]
                                              .comments!,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height:
                                          context.mediaQueryWidth /
                                              40,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                applicationBloc.commentTime(
                                                    DateTime.now().difference(
                                                        getCommentData
                                                            .getCommentInfo[
                                                        index]
                                                            .timestamp!)),
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                DateFormat('dd/MM/yyyy')
                                                    .format(getCommentData
                                                    .getCommentInfo[
                                                index]
                                                    .createdDate!),
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))


                  ),
                )*/
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
