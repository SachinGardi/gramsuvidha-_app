import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/common_widgets/progress_indicator.dart';
import 'package:gramsuvidha/utility/constant.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';
import 'package:gramsuvidha/utility/utilityMethods.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:gramsuvidha/view/work_history.dart';
import 'package:gramsuvidha/view_modal/getactivity_vm.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../blocs/application_bloc.dart';
import '../modal/activityModal.dart';
import '../modal/dropdownCategoryModal.dart';
import '../utility/textcontroller.dart';
import 'package:http/http.dart' as http;
import '../view_modal/activity_vm.dart';
import '../view_modal/getActivityByIdVm.dart';
import '../view_modal/getDashboardActivityVm.dart';
import '../view_modal/post_otp_vm.dart';

class ActivityForms extends StatefulWidget {
  @override
  State<ActivityForms> createState() => ActivityFormsState();
}

final activityVm = Get.put(ActivityVM());
final List<GramSuvidhaActivity> activityImages = [];

class ActivityFormsState extends State<ActivityForms> {
  final getActivityVm = Get.put(GetActivityVm());
  final dashboardActivity = Get.put(GetDashboardActivityVm());
  final getActivityInfoById = Get.put(GetActivityByIdVm());

  ///varriables for image upload flutter
  var imageLink;

  // List<XFile>? image;
  // String? imagePath;
  // String fileName = '';
  // String? imgBytes;

  Future uploadImages(String path, String name) async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    print('image1122');
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://$kBaseUrl/GramSuvidhaActivity/upload-multiple-Activity-photos'));
    request.files.add(
      await http.MultipartFile.fromPath(
        'files',
        path,
      ),
    );
    var response = await request.send();
    if (response.statusCode == 200) {}

    print(response.statusCode);
    final res = await http.Response.fromStream(response);
    print(res.body);

    /*request.fields['FolderName'] = 'Samadhan';
    request.fields['DocumentType'] = 'jpg';*/

    Map temp = json.decode(res.body);
    imageLink = temp['responseData'];
    if (applicationBloc.isUpdate) {
      setState(() {
        getActivityByIdVm.updatedActivityImageLinks.add(imageLink);
      });
    }
    print("***$imageLink***");
    activityImages.add(GramSuvidhaActivity(
        createdBy: userIdValue.read('userId'),
        modifiedBy: 0,
        createdDate: DateTime.now().toIso8601String(),
        modifiedDate: DateTime.now().toIso8601String(),
        isDeleted: true,
        id: 0,
        activityId: 0,
        imagePath: imageLink,
        imageName: name,
        timestamp: DateTime.now().toIso8601String(),
        grampanchayatId: 0));
  }

  int imageCount() {
    return imageSelected!.isEmpty
        ? 3
        : imageSelected!.length == 1
            ? 2
            : imageSelected!.length == 2
                ? 1
                : imageSelected!.length == 3
                    ? 0
                    : 1;
  }

  int updateImageCount() {
    return getActivityByIdVm.updatedActivityImageLinks.isEmpty
        ? 3
        : getActivityByIdVm.updatedActivityImageLinks.length == 1
            ? 2
            : getActivityByIdVm.updatedActivityImageLinks.length == 2
                ? 1
                : getActivityByIdVm.updatedActivityImageLinks.length == 3
                    ? 0
                    : 1;
  }

  /*Future uploadImages()async{
    var request = http.MultipartRequest(
        'POST', Uri.parse(
        'http://demovalvemgtapi.eanifarm.com/GramSuvidhaActivity/upload-multiple-Activity-photo')
    );
    */ /*request.fields['FolderName']='GramDoc';
    request.fields['DocumentType'] = 'jpg';*/ /*
    if(image != null){
      image?.forEach((element) {
        imagePath =  element.path;
      });
    }
    request.files.add(await http.MultipartFile.fromPath(
      'files',
      imagePath.toString(),
    ),
    );

    var response = await request.send();
    if(response.statusCode == 200){
      print(response.stream);
      print(response.statusCode);
    }
    final res = await http.Response.fromStream(response);
    print(res.body);
  */ /*  Map temp = json.decode(res.body);
    imagePathResult = temp['responseData'];
    print('***$imagePath****');*/ /*
  }*/

  ///IMAGE PIC FUNCTIONALITY
/*  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageList = [];*/

  ///Image select method
/*  Future<void> imageSelect() async {

    if ( _imageList.length < 4 ) {
      List<XFile>? selectedImage = await _picker.pickMultiImage();
      if (selectedImage.isNotEmpty && selectedImage.length <= 3) {
        _imageList.addAll(selectedImage);
        selectedImage.forEach((element) async {
          fileName = element.name;
       imagePath = element.path;
          var t = await imagePath;
          imgBytes = t;

          print('**********${element.path}*********');
          print('********${element.name}');
        });
        // print('*******${selectedImage.path.toString()}');
      } else if (selectedImage.length >= 4) {
        UtilityMethods.snackBarMethod(context, 'Limit Exceeded!');
      }
    }

    setState(() {});
  }*/

  ///open images Method
  final picker = HLImagePicker();
  List<HLPickerItem>? imagefiles = [];
  static List<HLPickerItem>? selectedImages = [];
  static List<HLPickerItem>? imageSelected = [];
  bool isCroppingEnabled = false;
  bool includePrevSelected = false;
  bool enablePreview = true;
  bool isExportThumbnail = true;
  bool usedCameraButton = true;
  MediaType type = MediaType.image;
  int numberOfColumn = 3;

  Future openImages() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    try {
      selectedImages = await picker.openPicker(
          cropping: isCroppingEnabled,
          selectedIds: includePrevSelected
              ? selectedImages!.map((e) => e.id).toList()
              : null,
          pickerOptions: HLPickerOptions(
            mediaType: type,
            enablePreview: enablePreview,
            isExportThumbnail: isExportThumbnail,
            thumbnailCompressFormat: CompressFormat.jpg,
            thumbnailCompressQuality: 0.9,
            maxSelectedAssets: isCroppingEnabled
                ? 1
                : applicationBloc.isUpdate
                    ? updateImageCount()
                    : imageCount(),
            usedCameraButton: usedCameraButton,
            numberOfColumn: numberOfColumn,
            isGif: true,
          ),
          localized: LocalizedImagePicker(
              maxSelectedAssetsErrorText: 'exceedImageMsg'.tr,
              okText: 'okBtn'.tr)

          /*  count: imageCount(),
        pickType: PickType.image,
        language: Language.English,*/
          );

      if (!applicationBloc.isUpdate) {
        setState(() {
          imageSelected?.addAll(selectedImages!);
        });
      } else if (applicationBloc.isUpdate) {
        for (int i = 0; i < selectedImages!.length; i++) {
          print('#####*****${selectedImages!.length}');
          print('Hello');

          await uploadImages(
              selectedImages![i].path, selectedImages![i].path.split('/').last);

          print('${'*********${activityImages.length}####****###'}');
          print('${activityImages.first.imagePath}');
          print('***************${selectedImages![i].path}**********');
          print(
              '**********${selectedImages![i].path.split('/').last}**********');
        }

        /*getActivityInfoById.updatedActivityImageLinks
              .add(selectedImages.toString());*/
      }
      /*   if (selectedImages != null && selectedImages!.length <= 3) {
          imagefiles = selectedImages;
          selectedImages!.forEach((element) {
            print('***************${element.path}**********');
            print('**********${element.path.split('/').last}**********');
          });
        }*/
    } catch (e) {
      print("error while picking file.");
    }
  }

  static int categoryId = 0;

  ///category list
  static List<DropdownCategoryModal> categories = [];

  ///selected category
  static DropdownCategoryModal? selectedCategory;

  DateTime? pickedDate;

  ///open Calender

  ///FutureMethod for category

  Future<List<DropdownCategoryModal>> listCategory(String endpoint) async {
    http.Response response = await http.get(Uri.parse(endpoint));
    String body = response.body;
    Map<String, dynamic> jsonResponse = jsonDecode(body);
    List data = jsonResponse['responseData'];
    return data.map((e) => DropdownCategoryModal.fromJson(e)).toList();
  }

  ///on select category
  void onCategoryChange(category) {
    setState(() {
      selectedCategory = category;
      categoryId = selectedCategory!.id!;
      print(categoryId);
    });
  }

  void openCalender() async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: context.mediaQueryWidth / 0.6,
              width: context.mediaQueryWidth / 1.2,
              child: child,
            ),
          ],
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        datePicController.text = DateFormat('dd/MM/yyyy').format(pickedDate!);
      });
    }
  }

  Uri? categoryUri;

  @override
  void initState() {
    super.initState();
    var applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
    print('#######${getActivityByIdVm.updatedActivityImageLinks}######');
    applicationBloc.setCurrentLocation();
    print('${applicationBloc.lang}');
    print('${applicationBloc.lat}');
    print(applicationBloc.address);

    ///load categories
    categoryUri = Uri.http('demovalvemgtapi.eanifarm.com',
        '/GramSuvidhaActivity/GetAllGramActivityCategory');

    listCategory(categoryUri.toString())
        .then((List<DropdownCategoryModal> value) {
      print('List of Category is loaded');
      setState(() {
        categories = value;
        // categoryId = selectedCategory!.id.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        setState(() {
          applicationBloc.isUpdate = false;
          titleController.clear();
          descriptionController.clear();
          imageSelected!.clear();
          selectedImages!.clear();
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: splashBackgroundColor,
          centerTitle: true,
          title: Text(
            'activityAppBarTitle'.tr,
            style: TextStyle(fontSize: context.mediaQueryWidth / 21),
          ),
          leading: IconButton(
            enableFeedback: true,
            splashRadius: context.mediaQueryWidth / 22,
            icon: const Icon(
              Icons.arrow_back,
              size: 22,
            ),
            onPressed: () {
              setState(() {
                applicationBloc.isUpdate = false;
                titleController.clear();
                descriptionController.clear();
                imageSelected!.clear();
                selectedImages!.clear();
              });
              Get.back();
            },
          ),
          actions: [
            !applicationBloc.isUpdate
                ? IconButton(
                    icon: const Icon(
                      Icons.format_list_bulleted_outlined,
                      size: 20,
                    ),
                    enableFeedback: true,
                    splashRadius: context.mediaQueryWidth / 22,
                    onPressed: () {
                      Get.offNamed('/workHistory');
                    },
                  )
                : const SizedBox.shrink()
          ],
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: WillPopScope(
            onWillPop: () async {
              Get.offAndToNamed('/gramSuvidhaDashboardScreen');
              return true;
            },
            child: ProgressHUD(
              indicatorWidget: progressIndicator(),
              padding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.none,
                  child: Column(
                    children: [
                      ///Date field
                      // Row(
                      //   children: [
                      //     const Expanded(
                      //         flex: 2,
                      //         child: Text('Date', style: TextStyle(fontSize: 13))),
                      //     Expanded(
                      //         flex: 3,
                      //         child: TextFormField(
                      //           style: const TextStyle(fontSize: 13),
                      //           keyboardType: TextInputType.none,
                      //           onTap: openCalender,
                      //           controller: datePicController,
                      //           textAlignVertical: TextAlignVertical.center,
                      //           decoration: InputDecoration(
                      //               hintText: 'Select Date',
                      //               hintStyle: const TextStyle(
                      //                 fontSize: 13,
                      //               ),
                      //               isDense: true,
                      //               fillColor: const Color(0XFFEFEEF5),
                      //               filled: true,
                      //               border: InputBorder.none,
                      //               suffixIcon: Icon(
                      //                 Icons.calendar_month,
                      //                 size: 20,
                      //                 color: splashBackgroundColor,
                      //               )),
                      //         ))
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: context.mediaQueryWidth / 20,
                      // ),

                      ///category field
                      // Row(
                      //   children: [
                      //     const Expanded(
                      //         flex: 2,
                      //         child: Text('Category', style: TextStyle(fontSize: 13))),
                      //     Expanded(
                      //         flex: 3,
                      //         child: DropdownButtonFormField<DropdownCategoryModal>(
                      //             isExpanded: true,
                      //             hint:  const Text('Select Category'),
                      //             // value: selectedCategory,
                      //             style: const TextStyle(
                      //                 overflow: TextOverflow.ellipsis,
                      //                 fontSize: 12,
                      //                 color: Colors.black54),
                      //             decoration: const InputDecoration(
                      //               filled: true,
                      //               fillColor: Color(0XFFEFEEF5),
                      //               border: InputBorder.none,
                      //             ),
                      //             items:
                      //                 categories.map((DropdownCategoryModal category) {
                      //               return DropdownMenuItem<DropdownCategoryModal>(
                      //                 value: category,
                      //                 child: Text(category.category!),
                      //               );
                      //             }).toList(),
                      //             onChanged: onCategoryChange))
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: context.mediaQueryWidth / 20,
                      // ),

                      ///Title field
                      ///

                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 25,
                            vertical: MediaQuery.of(context).size.height / 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 5.0)
                            ]),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text: 'title'.tr,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50),
                                      children: const [
                                    TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'OpenSans'))
                                  ])),

                              ///Title
                              Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 80,
                                    bottom: MediaQuery.of(context).size.height /
                                        60),
                                child: TextFormField(
                                  controller: titleController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(
                                        '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                                  ],
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'title'.tr,
                                    hintStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              60,
                                    ),
                                    isDense: true,
                                    isCollapsed: true,
                                    fillColor: const Color(0XFFEFEEF5),
                                    contentPadding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                70,
                                        bottom:
                                            MediaQuery.of(context).size.height /
                                                70,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                50),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: 'description'.tr,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50),
                                      children: const [
                                    TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'OpenSans'))
                                  ])),

                              ///Description
                              Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        MediaQuery.of(context).size.height / 80,
                                    bottom: MediaQuery.of(context).size.height /
                                        60),
                                child: TextFormField(
                                  maxLines: 12,
                                  controller: descriptionController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(
                                        '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                                  ],
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'desHint'.tr,
                                    hintStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              60,
                                    ),
                                    isDense: true,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.only(
                                        left: context.mediaQueryWidth / 50,
                                        top: context.mediaQueryHeight / 80),
                                    fillColor: const Color(0XFFEFEEF5),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),

                              ///Photos add button
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (!applicationBloc.isUpdate) {
                                          imageSelected!.length < 3
                                              ? openImages()
                                              : UtilityMethods.snackBarMethod(
                                                  context, 'exceedImageMsg'.tr);
                                        } else {
                                          getActivityByIdVm
                                                      .updatedActivityImageLinks
                                                      .length <
                                                  3
                                              ? openImages()
                                              : UtilityMethods.snackBarMethod(
                                                  context, 'exceedImageMsg'.tr);
                                        }
                                      },
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.photo_library_outlined,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  22,
                                              color: splashBackgroundColor,
                                            ),
                                            Text(
                                              'addPhotoBtn'.tr,
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  40,
                                              color: splashBackgroundColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                      flex: 5, child: SizedBox.shrink())
                                ],
                              ),

                              ///Photos preview
                              imageSelected!.isNotEmpty ||
                                      (getActivityByIdVm
                                              .updatedActivityImageLinks
                                              .isNotEmpty &&
                                          applicationBloc.isUpdate)
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              80,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              80),
                                      height: context.mediaQueryWidth / 3.6,
                                      width: double.infinity,

                                      // color: Colors.red,
                                      child: !applicationBloc.isUpdate
                                          ? ListView.builder(
                                              itemCount: imageSelected!.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) =>
                                                  Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: selectedImages!
                                                        .isNotEmpty
                                                    ? Container(
                                                        width: context
                                                                .mediaQueryWidth /
                                                            4,
                                                        color: Colors.black,
                                                        child: Stack(
                                                          fit: StackFit.expand,
                                                          children: [
                                                            Image.file(
                                                              File(
                                                                  imageSelected![
                                                                          index]
                                                                      .path),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            Positioned(
                                                                right: 4,
                                                                top: 4,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      showDialog(
                                                                        barrierDismissible:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) =>
                                                                                AlertDialog(
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                          actionsAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          actionsPadding:
                                                                              EdgeInsets.only(bottom: context.mediaQueryHeight / 50),
                                                                          contentPadding: EdgeInsets.only(
                                                                              top: context.mediaQueryHeight / 60,
                                                                              bottom: context.mediaQueryHeight / 80),
                                                                          title:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                flex: 1,
                                                                                child: ClipRRect(
                                                                                  child: SvgPicture.asset('assets/images/registrationOtp_screen/Gram Login Logo.svg', height: 30),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Expanded(
                                                                                flex: 5,
                                                                                child: Text(
                                                                                  'deleteTitle'.tr.padRight(30, ' '),
                                                                                  style: const TextStyle(
                                                                                      // fontFamily: 'Montserrat-Medium',
                                                                                      fontSize: 17,
                                                                                      fontWeight: FontWeight.w400),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          content:
                                                                              Text(
                                                                            'contentTitle'.tr,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                // fontFamily: 'Montserrat-Medium',
                                                                                fontSize: context.mediaQueryWidth / 25),
                                                                          ),
                                                                          actions: [
                                                                            MaterialButton(
                                                                              onPressed: () {
                                                                                Get.back();
                                                                              },
                                                                              color: Colors.redAccent,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                              height: context.mediaQueryHeight / 25,
                                                                              child: Text('cancelBtn'.tr, style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.white)),
                                                                            ),
                                                                            MaterialButton(
                                                                              color: Colors.green,
                                                                              height: context.mediaQueryHeight / 25,
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  imageSelected!.removeAt(index);
                                                                                  FocusScope.of(context).unfocus();
                                                                                  Get.back();
                                                                                });
                                                                              },
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                              child: Text(
                                                                                'okBtn'.tr,
                                                                                style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    });
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete_forever,
                                                                    color: Colors
                                                                        .red
                                                                        .shade200,
                                                                  ),
                                                                )),
                                                          ],
                                                        ))
                                                    : Container(),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: getActivityByIdVm
                                                  .updatedActivityImageLinks
                                                  .length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: getActivityByIdVm
                                                          .updatedActivityImageLinks
                                                          .isNotEmpty
                                                      ? Container(
                                                          width: context
                                                                  .mediaQueryWidth /
                                                              4,
                                                          color: Colors.black,
                                                          child: Stack(
                                                            fit:
                                                                StackFit.expand,
                                                            children: [
                                                              Image.network(
                                                                getActivityByIdVm
                                                                        .updatedActivityImageLinks[
                                                                    index],
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              Positioned(
                                                                  right: 4,
                                                                  top: 4,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        showDialog(
                                                                          barrierDismissible:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              AlertDialog(
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                            actionsAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            actionsPadding:
                                                                                EdgeInsets.only(bottom: context.mediaQueryHeight / 50),
                                                                            contentPadding:
                                                                                EdgeInsets.only(top: context.mediaQueryHeight / 60, bottom: context.mediaQueryHeight / 80),
                                                                            title:
                                                                                Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  flex: 1,
                                                                                  child: ClipRRect(
                                                                                    child: SvgPicture.asset('assets/images/registrationOtp_screen/Gram Login Logo.svg', height: 30),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Expanded(
                                                                                  flex: 5,
                                                                                  child: Text(
                                                                                    'deleteTitle'.tr.padRight(30, ' '),
                                                                                    style: const TextStyle(
                                                                                        // fontFamily: 'Montserrat-Medium',
                                                                                        fontSize: 17,
                                                                                        fontWeight: FontWeight.w400),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            content:
                                                                                Text(
                                                                              'contentTitle'.tr,
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                  // fontFamily: 'Montserrat-Medium',
                                                                                  fontSize: context.mediaQueryWidth / 25),
                                                                            ),
                                                                            actions: [
                                                                              MaterialButton(
                                                                                onPressed: () {
                                                                                  Get.back();
                                                                                },
                                                                                color: Colors.redAccent,
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                                height: context.mediaQueryHeight / 25,
                                                                                child: Text('cancelBtn'.tr, style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.white)),
                                                                              ),
                                                                              MaterialButton(
                                                                                color: Colors.green,
                                                                                height: context.mediaQueryHeight / 25,
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    if (activityImages.isNotEmpty) {
                                                                                      if (activityImages.length == getActivityByIdVm.updatedActivityImageLinks.length) {
                                                                                        activityImages.removeAt(index);
                                                                                      } else {
                                                                                        activityImages.length == 1
                                                                                            ? activityImages.removeAt(0)
                                                                                            : activityImages.length == 2
                                                                                                ? activityImages.removeAt(1)
                                                                                                : null;
                                                                                      }
                                                                                    }
                                                                                    getActivityByIdVm.updatedActivityImageLinks.removeAt(index);
                                                                                    Get.back();
                                                                                  });
                                                                                },
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                                child: Text(
                                                                                  'okBtn'.tr,
                                                                                  style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      });
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete_forever,
                                                                      color: Colors
                                                                          .red
                                                                          .shade200,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ))
                                                      : Container(),
                                                );
                                              }),

                                      /*        GridView.builder(

                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1
                              ),
                              itemCount: _imageList.length,
                              itemBuilder: (context, index) {
                                return ;
                              },
                            ),*/
                                    )
                                  : const SizedBox.shrink(),

                              imageSelected!.isNotEmpty
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              90,
                                    ),

                              ///Submit or update button
                              Builder(
                                builder: (context) {
                                  return Center(
                                    child: !applicationBloc.isUpdate
                                        ? MaterialButton(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20,
                                            minWidth:
                                                context.mediaQueryWidth / 2.5,
                                            onPressed: () async {
                                              final progress =
                                                  ProgressHUD.of(context);
                                              if (titleController
                                                  .text.isEmpty) {
                                                UtilityMethods.snackBarMethod(
                                                    context, 'emptyTitle'.tr);
                                              } else if (descriptionController
                                                  .text.isEmpty) {
                                                UtilityMethods.snackBarMethod(
                                                    context,
                                                    'emptyDescription'.tr);
                                              } else {
                                                progress?.show();

                                                if (imageSelected != null) {
                                                  print(
                                                      '#######${imageSelected!.length}#######');
                                                  for (int i = 0;
                                                      i < imageSelected!.length;
                                                      i++) {
                                                    ///image post api call
                                                    await uploadImages(
                                                        imageSelected![i].path,
                                                        imageSelected![i]
                                                            .path
                                                            .split('/')
                                                            .last);
                                                  }
                                                }

                                                progress?.dismiss();
                                                if (!mounted) return;
                                                progress?.show();

                                                ///main post api call
                                                await activityVm.activityInfo(
                                                    ActivityModal(), context);
                                                progress?.dismiss();
                                                // await dashboardActivity.getDashboardActivity(pageCount);

                                                // datePicController.text = '';

                                                /*    applicationBloc
                                                      .newAddressValue = '';
                                                  locationController.text = '';
                                                  selectedImages = [];
                                                  categories.length = 0;*/
                                                // selectedCategory = null;
                                                /*   listCategory(categoryUri.toString())
                                            .then((List<DropdownCategoryModal> value) {
                                          print('List of Category is loaded');
                                          setState(() {
                                            categories = value;
                                            // categoryId = selectedCategory!.id.toString();
                                          });
                                        });*/
                                              } /*else if (datePicController
                                                  .text.isEmpty) {
                                                UtilityMethods.snackBarMethod(
                                                    context,
                                                    'Select valid date');
                                              } */ /*else if (selectedCategory ==
                                                  null) {
                                                UtilityMethods.snackBarMethod(
                                                    context,
                                                    'Select valid category.');
                                              } */ /*else if (applicationBloc
                                                      .newAddressValue
                                                      .isEmpty ||
                                                  applicationBloc
                                                      .address.isEmpty) {
                                                UtilityMethods.snackBarMethod(
                                                    context,
                                                    'Select valid location.');
                                              }*/
                                            },
                                            color: splashBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              'postBtn'.tr,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          55),
                                            ),
                                          )
                                        : MaterialButton(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20,
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            onPressed: () async {
                                              final progress =
                                                  ProgressHUD.of(context);
                                              if (titleController
                                                  .text.isEmpty) {
                                                UtilityMethods.snackBarMethod(
                                                    context, 'emptyTitle'.tr);
                                              } else if (descriptionController
                                                  .text.isEmpty) {
                                                UtilityMethods.snackBarMethod(
                                                    context,
                                                    'emptyDescription'.tr);
                                              } else {
                                                progress?.show();
                                                if (activityImages.isEmpty) {
                                                  print(
                                                      '#######${selectedImages!.length}#######');
                                                  for (int i = 0;
                                                      i <
                                                          getActivityByIdVm
                                                              .updatedActivityImageLinks
                                                              .length;
                                                      i++) {
                                                    activityImages.add(GramSuvidhaActivity(
                                                        createdBy: userIdValue
                                                            .read('userId'),
                                                        modifiedBy: userIdValue
                                                            .read('userId'),
                                                        createdDate: DateTime.now()
                                                            .toIso8601String(),
                                                        modifiedDate:
                                                            DateTime.now()
                                                                .toIso8601String(),
                                                        isDeleted: true,
                                                        id: 0,
                                                        activityId: 0,
                                                        imagePath: getActivityByIdVm
                                                                .updatedActivityImageLinks[
                                                            i],
                                                        imageName: getActivityByIdVm
                                                            .updatedActivityImageLinks[
                                                                i]
                                                            .split('/')
                                                            .last,
                                                        timestamp: DateTime.now()
                                                            .toIso8601String(),
                                                        grampanchayatId: 0));
                                                  }
                                                } else {
                                                  activityImages.clear();
                                                  for (int i = 0;
                                                      i <
                                                          getActivityByIdVm
                                                              .updatedActivityImageLinks
                                                              .length;
                                                      i++) {
                                                    activityImages.add(GramSuvidhaActivity(
                                                        createdBy: userIdValue
                                                            .read('userId'),
                                                        modifiedBy: userIdValue
                                                            .read('userId'),
                                                        createdDate: DateTime.now()
                                                            .toIso8601String(),
                                                        modifiedDate:
                                                            DateTime.now()
                                                                .toIso8601String(),
                                                        isDeleted: true,
                                                        id: 0,
                                                        activityId: 0,
                                                        imagePath: getActivityByIdVm
                                                                .updatedActivityImageLinks[
                                                            i],
                                                        imageName: getActivityByIdVm
                                                            .updatedActivityImageLinks[
                                                                i]
                                                            .split('/')
                                                            .last,
                                                        timestamp: DateTime.now()
                                                            .toIso8601String(),
                                                        grampanchayatId: 0));
                                                  }
                                                }

                                                progress?.dismiss();

                                                progress?.show();

                                                print(getActivityByIdVm
                                                    .updatedActivityImageLinks
                                                    .length);

                                                ///main post api call
                                                if (!mounted) return;
                                                activityVm.activityUpdate(
                                                    ActivityModal(),
                                                    context,
                                                    applicationBloc.recordId!);
                                                progress?.dismiss();
                                              }
                                            },
                                            color: splashBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text('updateBtn'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            55)),
                                          ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),

                      ///Location Field
                      /*       Row(
                        children: [
                          Expanded(
                              flex: 6,
                              child: RichText(
                                text: const TextSpan(
                                    text: 'Location',
                                    style: TextStyle(color: Colors.black, fontSize: 13),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ' * ',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 13))
                                    ]),
                              )),
                          Expanded(
                              flex: 7,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const GoogleMapScreen()),
                                  );
                                },
                                child: TextFormField(
                                  enabled: false,
                                  style: const TextStyle(fontSize: 13),
                                  controller: locationController,
                                  minLines: 1,
                                  maxLines: ((applicationBloc.location.length)).round(),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText:
                                        (!applicationBloc.newAddressValue.isNotEmpty)
                                            ? 'Location'
                                            : locationController.text = applicationBloc.newAddressValue,
                                    hintStyle: const TextStyle(
                                        fontSize: 13, color: Colors.black),
                                    isDense: true,
                                    fillColor: const Color(0XFFEFEEF5),
                                    filled: true,
                                    border: InputBorder.none,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed('/googleMapScreen',
                                      preventDuplicates: true);
                                },
                                child: const Card(
                                  color: Color(0XFFEFEEF5),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                ),
                              )),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
