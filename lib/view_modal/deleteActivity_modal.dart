import 'package:get/get.dart';
import 'package:gramsuvidha/modal/deleteActivityModal.dart';
import 'package:gramsuvidha/repository/deleteActivity_repo.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';

class DeleteActivityVm extends GetxController {
  var isLoading = true.obs;
  int? statusCode;
  String? statusMessage;

  deleteActivity(DeleteActivityModal delete, int activityId) async {
    await DeleteActivityRepo.deleteActivity(
        activityId, userIdValue.read('userId'));
    if (DeleteActivityRepo.statusCode!.isNotEmpty) {
      statusCode = int.parse(DeleteActivityRepo.statusCode!);
      statusMessage = DeleteActivityRepo.statusMessage;
    }
    isLoading.value = false;
  }
}
