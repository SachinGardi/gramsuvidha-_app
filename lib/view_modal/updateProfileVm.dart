import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/repository/updateProfile_Repo.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';

class UpdateProfileVm extends GetxController {
  var isLoading = true.obs;

  updateUserProfile(
      UpdateProfileVm updateProfileVm, BuildContext context) async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    await UpdateProfileData.updateProfileData(
      userIdValue.read('userId'),
      fullNameController.text,
      mobileNoController.text,
      emailIdController.text,
      updateAddressController.text,
      applicationBloc.imageLink.isEmpty
          ? profileImage
          : applicationBloc.imageLink,
      context,
    );
    isLoading.value = false;
  }
}
