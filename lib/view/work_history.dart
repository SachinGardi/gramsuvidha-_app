import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/modal/getActivityByIdModal.dart';
import 'package:gramsuvidha/utility/utilityMethods.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:gramsuvidha/view/activityform.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../blocs/application_bloc.dart';
import '../common_widgets/progress_indicator.dart';
import '../repository/getallactivity_repo.dart';
import '../utility/utilityColor.dart';
import '../view_modal/deleteActivity_modal.dart';
import '../view_modal/getActivityByIdVm.dart';
import '../view_modal/getactivity_vm.dart';

class WorkHistory extends StatefulWidget {
  const WorkHistory({Key? key}) : super(key: key);

  @override
  State<WorkHistory> createState() => WorkHistoryState();
}

int pageNo = 1;
final getActivityModal = Get.put(GetActivityVm());
final getActivityByIdVm = Get.put(GetActivityByIdVm());
final deleteActivityVm = Get.put(DeleteActivityVm());

class WorkHistoryState extends State<WorkHistory> {
  String? dropdownOldValue;
  ScrollController scrollController1 = ScrollController();

  static String? getCategoryById(int id) {
    String? categories;
    for (int i = 0; i < ActivityFormsState.categories.length; i++) {
      if (id == ActivityFormsState.categories[i].id) {
        categories = ActivityFormsState.categories[i].category;
      }
    }
    return categories;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      deleteActivityVm.isLoading.value = false;
      GetAllActivityRepo.hasMoreData = true;
      pageNo = 1;
      getActivityModal.getActivityList.clear();
      GetAllActivityRepo.getAllActivity.clear();
      getActivityModal.isLoading.value = true;
      getActivityModal.getActivityData(pageNo);
      getActivityByIdVm.updatedActivityImageLinks.clear();
    });

    scrollController1.addListener(() async {
      if (scrollController1.position.maxScrollExtent ==
          scrollController1.offset) {
        setState(() {
          ++pageNo;
          print('Hello');
        });
        if (pageNo <= GetAllActivityRepo.pageCountInfo.totalPages!) {
          await getActivityModal.getActivityData(pageNo);
          setState(() {
            GetAllActivityRepo.hasMoreData = false;
          });
        }
      }
    });
    // getActivityModal.getActivityData(pageNo,context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return WillPopScope(
      onWillPop: () async {
        applicationBloc.isUpdate = false;
        Get.offNamed('/activityScreen');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: splashBackgroundColor,
          leading: IconButton(
              enableFeedback: true,
              splashRadius: context.mediaQueryWidth/22,
              onPressed: () {
                getActivityModal.getActivityList.clear();
                setState(() {
                  applicationBloc.isUpdate = false;
                });
                Get.offNamed('/activityScreen');
              },
              icon: const Icon(Icons.arrow_back_rounded, size: 22)),
          centerTitle: true,
          title: Text(
            'appBarTitle'.tr,
            style: TextStyle(fontSize: context.mediaQueryWidth / 21),
          ),
        ),
        body: Obx(
          () => ModalProgressHUD(
              inAsyncCall: getActivityModal.isLoading.value == true,
              progressIndicator: progressIndicator(),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return true;
                },
                child: RefreshIndicator(
                  color: splashBackgroundColor,
                  onRefresh: () {
                    return Future.delayed(const Duration(milliseconds: 500),
                        () {
                      setState(() {
                        GetAllActivityRepo.hasMoreData = true;
                        pageNo = 1;
                        getActivityModal.getActivityList.clear();
                        getActivityModal.isLoading.value = true;
                        getActivityModal.getActivityData(pageNo);
                      });
                    });
                  },
                  child: ListView.builder(
                    padding:
                        EdgeInsets.only(top: context.mediaQueryHeight / 60),
                    controller: scrollController1,
                    itemCount: getActivityModal.getActivityList.length + 1,
                    itemBuilder: (context, index) => (index <
                            getActivityModal.getActivityList.length)
                        ? Card(
                            elevation: 2,
                            shadowColor: Colors.black87,
                            margin: EdgeInsets.only(
                              bottom: context.mediaQueryHeight / 60,
                              left: context.mediaQueryWidth / 30,
                              right: context.mediaQueryWidth / 30,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.mediaQueryHeight / 80,
                                  horizontal: context.mediaQueryWidth / 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        getActivityModal
                                            .getActivityList[index].title,
                                        style: TextStyle(
                                            fontSize:
                                                context.mediaQueryHeight / 50),
                                      )),
                                      InkWell(
                                        enableFeedback: true,
                                        onTap: () async {
                                          print('Hello');
                                          print(getActivityModal
                                              .getActivityList[index]
                                              .createdDate);
                                          await getActivityByIdVm
                                              .getActivityInfoByActivityId(
                                                  GetActivityByIdModal(),
                                                  getActivityModal
                                                      .getActivityList[index]
                                                      .id,
                                                  context);
                                          applicationBloc.showUpdateButton(
                                              true,
                                              getActivityModal
                                                  .getActivityList[index].id);
                                          ActivityFormsState.imageSelected!
                                              .clear();
                                          print(
                                              '**********${getActivityByIdVm.updatedActivityImageLinks}');
                                          Get.toNamed('/activityScreen');
                                        },
                                        child: Text(
                                          'editBtn'.tr,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize:
                                                context.mediaQueryHeight / 55,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 7,
                                          child: Text(
                                            DateFormat('dd-MM-yyyy h:mm a')
                                                .format(DateTime.parse(
                                                    getActivityModal
                                                        .getActivityList[index]
                                                        .createdDate)),
                                            style: TextStyle(
                                                fontSize:
                                                    context.mediaQueryHeight /
                                                        60,
                                                color: Colors.grey),
                                          )),
                                      InkWell(
                                        enableFeedback: true,
                                        onTap: () {
                                          setState(() {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                actionsAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                alignment: Alignment.center,
                                                actionsPadding: EdgeInsets.only(
                                                    bottom: context
                                                            .mediaQueryHeight /
                                                        50),
                                                contentPadding: EdgeInsets.only(
                                                  top:
                                                      context.mediaQueryHeight /
                                                          60,
                                                  bottom:
                                                      context.mediaQueryHeight /
                                                          80,
                                                  left:
                                                      context.mediaQueryWidth /
                                                          8,
                                                  right:
                                                      context.mediaQueryWidth /
                                                          8,
                                                ),
                                                title: Column(
                                                  children: [
                                                    ClipRRect(
                                                        child: Icon(
                                                      Icons.warning_amber,
                                                      color: Colors.amber,
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
                                                          .padRight(30, ' '),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          // fontFamily: 'Montserrat-Medium',
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                ),
                                                content: Text(
                                                  'popupContentTitle'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      // fontFamily: 'Montserrat-Medium',
                                                      fontSize: context
                                                              .mediaQueryWidth /
                                                          25),
                                                ),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    color: Colors.redAccent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    height: context
                                                            .mediaQueryHeight /
                                                        25,
                                                    child: Text('cancelBtn'.tr,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                  MaterialButton(
                                                    color: Colors.green,
                                                    height: context
                                                            .mediaQueryHeight /
                                                        25,
                                                    onPressed: () async {
                                                      await applicationBloc
                                                          .deletePost(
                                                              deleteActivityVm,
                                                              getActivityModal,
                                                              getActivityModal
                                                                  .getActivityList[
                                                                      index]
                                                                  .id,
                                                              index);
                                                      if (deleteActivityVm
                                                              .statusCode ==
                                                          200) {
                                                        UtilityMethods
                                                            .snackBarMethod(
                                                                context,
                                                                'postDeleteMsg'
                                                                    .tr);
                                                      } else if (deleteActivityVm
                                                              .statusCode ==
                                                          409) {
                                                        UtilityMethods
                                                            .snackBarMethod(
                                                                context,
                                                                'postDeleteErrorMsg'
                                                                    .tr);
                                                      }
                                                      Get.back();
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    child: Text(
                                                      'okBtn'.tr,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                        },
                                        child: Text(
                                          'deleteBtn'.tr,
                                          style: TextStyle(
                                              fontSize:
                                                  context.mediaQueryHeight / 55,
                                              color:
                                                  Colors.red.withOpacity(0.8)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ))
                        : GetAllActivityRepo.hasMoreData && pageNo != 1
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: splashBackgroundColor,
                                  strokeWidth: 3,
                                ),
                              )
                            : Container(),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
