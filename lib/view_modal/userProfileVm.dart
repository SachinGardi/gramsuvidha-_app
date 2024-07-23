
import 'dart:async';
import 'package:get/get.dart';
import '../modal/userProfileModal.dart';
import '../repository/getUserProfile_Repo.dart';

class UserProfileVm extends GetxController {
  var isLoading = true.obs;
  List<GetUserProfile> getUserProfileInfoList = [];
  int userId = 0;
  String fullName = '';
  String mobileNumber = '';
  String email = '';
  String address = '';
  String profilePic = '';

  getUserProfileInfo() async {
    var profileInfo = await GetUserProfileRepo.getProfileInfo();

    if (profileInfo != null) {
      getUserProfileInfoList = profileInfo;
      for (int i = 0; i < getUserProfileInfoList.length; i++) {
        userId = getUserProfileInfoList[i].userId;
        fullName = getUserProfileInfoList[i].fullName;
        mobileNumber = getUserProfileInfoList[i].mobileNo;
        email = getUserProfileInfoList[i].emailId;
        address = getUserProfileInfoList[i].address;
        profilePic = getUserProfileInfoList[i].profilePhoto.toString();
      }
      isLoading.value = false;
    } else {
      Timer(const Duration(seconds: 1), () {
        isLoading.value = false;
      });
    }
  }
}
