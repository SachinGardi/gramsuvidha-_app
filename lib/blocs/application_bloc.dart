import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:gramsuvidha/services/geolocator_service.dart';
import 'package:gramsuvidha/services/places_service.dart';
import 'package:gramsuvidha/utility/constant.dart';
import 'package:gramsuvidha/view_modal/deleteActivity_modal.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import '../modal/deleteActivityModal.dart';
import '../modal/getDashboardActivityModal.dart';
import '../modal/likeActivityModal.dart';
import '../utility/textcontroller.dart';
import '../view_modal/activity_like_vm.dart';
import '../view_modal/getDashboardActivityVm.dart';
import '../view_modal/getactivity_vm.dart';
import '../view_modal/post_otp_vm.dart';
import '../view_modal/updateProfileVm.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();

  ///variables
  Position? currentLocation;
  List<Placemark>? currentAddress;
  Placemark? place;
  String address = '';
  List<Marker> myMarkers = [];
  String newAddressValue = '';
  final key = 'AIzaSyBQ6AVl92dee-iIN0NQ8LfXiBrL7emvSnI';
  GoogleMapController? mapController;
  var newlatlang;
  var oldLatLong;
  String location = "Search Location";

  ///lat long
  var lat = 0.0;
  var lang = 0.0;

  // List<PlaceSearch> searchResults = [];
  MapType currentMapType = MapType.satellite;

  // final Set<Marker> markers = {};

  ApplicationBloc() {
    setCurrentLocation();
  }

  /* @override
  void dispose(){
    selectedLocation.close();
    super.dispose();

  }*/

  ///set current location
  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    lat = currentLocation!.latitude;
    lang = currentLocation!.longitude;
    currentAddress =
        await geoLocatorService.getCurrentAddress(currentLocation!);
    place = currentAddress![0];
    address =
        '${place!.street}, ${place!.name} ,${place!.thoroughfare}, ${place!.subLocality}, ${place!.locality}, ${place!.administrativeArea},${place!.postalCode}, ${place!.country} ';
    myMarkers.add(Marker(
        markerId: MarkerId('$currentLocation'),
        position: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: address)));
    notifyListeners();
  }

/*  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }*/

  ///Map type change
  changeMapType() {
    currentMapType = currentMapType == MapType.satellite
        ? MapType.normal
        : MapType.satellite;
    notifyListeners();
  }

  handleTap(LatLng tappedPoint) async {
    myMarkers = [];
    myMarkers.add(
      Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          infoWindow: InfoWindow(
            title: '${tappedPoint.latitude}: ${tappedPoint.longitude}',
          )),
    );
    lat = tappedPoint.latitude;
    lang = tappedPoint.longitude;
    newlatlang = tappedPoint;

    currentAddress = await placemarkFromCoordinates(
        tappedPoint.latitude, tappedPoint.longitude);
    place = currentAddress![0];
    address =
        '${place!.street}, ${place!.name} ,${place!.thoroughfare}, ${place!.subLocality}, ${place!.locality}, ${place!.administrativeArea},${place!.postalCode}, ${place!.country}';
    notifyListeners();
  }

/*  setSelectedLocation(String placeId)async{
     selectedLocation.add(await placesService.getPlace(placeId));
     searchResults.clear();
    notifyListeners();
  }*/

  getSearchPlaces(BuildContext context) async {
    var place = await PlacesAutocomplete.show(
        context: context,
        apiKey: key,
        mode: Mode.overlay,
        types: [],
        strictbounds: false,
        onError: (err) {
          print(err);
        });
    if (place != null) {
      location = place.description!
          .split(
            ',',
          )
          .first
          .toString();

      // address = place.description.toString();

      //form google_maps_webservice package
      final plist = GoogleMapsPlaces(
          apiKey: key, apiHeaders: await const GoogleApiHeaders().getHeaders());
      String placeid = place.placeId ?? "0";
      print(placeid);
      final detail = await plist.getDetailsByPlaceId(placeid);
      final geometry = detail.result.geometry!;
      lat = geometry.location.lat;
      lang = geometry.location.lng;
      var adressDetails = await placemarkFromCoordinates(lat, lang);
      var pincode = adressDetails[0];

      address = '${place.description.toString()},${pincode.postalCode}';
      newlatlang = LatLng(lat, lang);
      print(newlatlang);

      if (oldLatLong == newlatlang) {
        myMarkers.clear();
        myMarkers.add(Marker(
            markerId: MarkerId(
              oldLatLong.toString(),
            ),
            position: oldLatLong));
      } else if (oldLatLong != newlatlang) {
        myMarkers.clear();
        myMarkers.add(Marker(
            markerId: MarkerId(
              newlatlang.toString(),
            ),
            position: newlatlang));
      }

      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: newlatlang, zoom: 18.8, tilt: 35)));
    }
    notifyListeners();
  }

  setValueOnButtonTap() {
    if (address != newAddressValue && newlatlang != oldLatLong) {
      newAddressValue = address;
      oldLatLong = newlatlang;
    }

    notifyListeners();
  }

  resetValues() {
    address = newAddressValue;
    myMarkers.clear();
    if (oldLatLong != null) {
      myMarkers.add(Marker(
          markerId: MarkerId(
            oldLatLong.toString(),
          ),
          position: oldLatLong));
    }
  }

  ///Profile Image Selection for update

  bool permissionGranted = false;

  Future getStoragePermission() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt <= 32) {
      Permission.storage.request();
    } else {
      Permission.photos.request();
    }

    notifyListeners();
  }

  final picker = HLImagePicker();

  // Media? imageFiles;
  List<HLPickerItem> pickedImage = [];
  String? imagePath;
  final updateProfileVm = Get.put(UpdateProfileVm());
  MediaType type = MediaType.image;
  bool enablePreview = true;
  bool isExportThumbnail = true;
  bool isCroppingEnabled = false;
  bool usedCameraButton = true;
  int numberOfColumn = 3;
  bool includePrevSelected = false;
  CropAspectRatio? aspectRatio;
  List<CropAspectRatioPreset>? aspectRatioPresets;
  double compressQuality = 0.9;
  CroppingStyle croppingStyle = CroppingStyle.normal;

  Future openGallery() async {
    try {
      final images = await picker.openPicker(
        selectedIds:
            includePrevSelected ? pickedImage.map((e) => e.id).toList() : null,
        pickerOptions: HLPickerOptions(
          mediaType: type,
          enablePreview: enablePreview,
          isExportThumbnail: isExportThumbnail,
          thumbnailCompressFormat: CompressFormat.jpg,
          thumbnailCompressQuality: 0.9,
          maxSelectedAssets: isCroppingEnabled ? 1 : 1,
          usedCameraButton: usedCameraButton,
          numberOfColumn: numberOfColumn,
          isGif: true,
        ),
        cropOptions: HLCropOptions(
          aspectRatio: aspectRatio,
          aspectRatioPresets: aspectRatioPresets,
          compressQuality: compressQuality,
          compressFormat: CompressFormat.jpg,
          croppingStyle: croppingStyle,
        ),
        cropping: true,
      );

      pickedImage = images;

      for (var element in pickedImage) {
        imagePath = element.path;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      debugPrintStack();
    }
    notifyListeners();
  }

  uploadProfileImage(String imagePath) async {
    await uploadImageToServer(imagePath);
    notifyListeners();
  }

  ///Upload profile image to server
  String imageLink = '';

  // UpdateProfile? profileData;
  Future uploadImageToServer(String? path) async {
    var request = http.MultipartRequest(
        'Post', Uri.parse('http://$kBaseUrl/UserRegistration/UplodFile'));
    request.fields['FolderName'] = 'Sachin';
    request.fields['DocumentType'] = 'jpg';
    request.files
        .add(await http.MultipartFile.fromPath('UploadDocPath', path!));
    var response = await request.send();
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      print(res.body);
      Map temp = json.decode(res.body);
      imageLink = temp['responseData'];
      print(userIdValue.read('userId'));
    }
  }

  ///get ActivityId
  int? activityId;

  getActivityId(int id) {
    activityId = id;
    notifyListeners();
  }

  bool isUpdate = false;
  int? recordId;

  bool showUpdateButton(bool value, int recordIdValue) {
    isUpdate = value;
    recordId = recordIdValue;
    // print('######$recordId#####');
    notifyListeners();
    return isUpdate;
  }

  int getCommentCount(int count) {
    return count;
  }

  ///get comment time
  String commentTime(Duration time) {
    return time.inSeconds < 60
        ? '${time.inSeconds} sec'
        : time.inSeconds > 60 && time.inMinutes < 60
            ? '${time.inMinutes} min'
            : time.inMinutes > 60 && time.inMinutes < 1440
                ? '${time.inHours} hours'
                : time.inMinutes > 1440 && time.inMinutes < 86400
                    ? '${time.inDays} days'
                    : time.inDays > 365 && time.inMinutes > 86400
                        ? '${time.inDays / 365} year'
                        : '${time.inSeconds} sec';
  }

  int checkLikeCount(int count) {
    return count;
  }

  final activityLikeVm = Get.put(ActivityLikeVm());
  final dashboardActivity = Get.put(GetDashboardActivityVm());
  var like = 0;

  chekLikeValue(int activityId, bool likeStatus) async {
    // await dashboardActivity.getDashboardActivity(pageCount);
    var data = dashboardActivity.getDashboardActivityData
        .where((element) => element.id == activityId);
    data.map((e) {
      if (e.id == activityId) {
        if (!likeStatus) {
          likeStatus = true;
          e.likeDislike = likeStatus;
          e.likeConut++;
          like = 1;
          print('######$like#####');
        } else if (likeStatus && e.likeConut != 0) {
          likeStatus = false;
          e.likeDislike = likeStatus;
          e.likeConut--;
          like = 0;
          print('######$like#####');
        }
        print('#########${e.id}');
        print('#########$activityId');
        // like = e.likeConut==0?1:0;
      }
    }).toList();
    // dashboardActivity.isLoading.value = true;
    // dashboardActivity.getDashboardActivity(pageCount);
    await activityLikeVm.getActivityLikeCount(
        LikeActivityModal(), activityId, like);
    // await dashboardActivity.getDashboardActivity(page);
    notifyListeners();
  }

  onPresses(
    Iterable<GetDashboardActivity> data,
    String fullName,
    String locationText,
    String createdDate,
    String createdTime,
    String description,
    int likeCount,
    int commentCount,
    int shareCount,
    List<dynamic> imageList,
  ) {
    print('*****$commentCount######');
    for (var value in data) {
      if (data.first.id == activityId) {
        fullName = value.userName;
        location = value.locationName;
        createdDate = value.createdDate;
        createdTime = value.createdTime;
        description = value.description;
        likeCount = value.likeConut;
        value.commentCount = commentCount;
        shareCount = value.shareCount;
        imageList = value.dashboardActivityImages;
      }
    }
    print('####$commentCount******');
    notifyListeners();
  }

  ///update comment controller

  updateCommentControllerFun(String updateComment) {
    updateCommentController.text = updateComment;
    notifyListeners();
  }

  deletePost(DeleteActivityVm deleteActivityVm, GetActivityVm getActivityVm,
      int activityId, int index) async {
    deleteActivityVm.isLoading.value = true;
    await deleteActivityVm.deleteActivity(DeleteActivityModal(), activityId);
    if (deleteActivityVm.statusCode == 200) {
      getActivityVm.getActivityList.removeAt(index);
    }
    notifyListeners();
  }

  deleteDashboardPost(
      DeleteActivityVm deleteActivityVm,
      GetDashboardActivityVm getDashboardActivityVm,
      int activityId,
      int index) async {
    deleteActivityVm.isLoading.value = true;
    await deleteActivityVm.deleteActivity(DeleteActivityModal(), activityId);
    if (deleteActivityVm.statusCode == 200) {
      getDashboardActivityVm.getDashboardActivityData.removeAt(index);
    }
    notifyListeners();
  }

/*
  ///Dropdown category
  List<DropdownCategoryModal> categoryItemlist = [];

  Future getAllCategory()async{
    var baseUrl = Uri.http('demovalvemgtapi.eanifarm.com',
        '/GramSuvidhaActivity/GetAllGramActivityCategory');
    http.Response response = await http.get(baseUrl);

    if(response.statusCode == 200){
      Map data = json.decode(response.body);
          data['responseData'].forEach((element){
            categoryItemlist.add(
                DropdownCategoryModal(
                    id: element['id'],
                    category: element['category']
                )
            );
          });

      notifyListeners();
    }
  }
*/
}
