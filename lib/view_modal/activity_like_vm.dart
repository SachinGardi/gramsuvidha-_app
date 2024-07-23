import 'package:get/get.dart';
import 'package:gramsuvidha/modal/likeActivityModal.dart';
import 'package:gramsuvidha/repository/activity_like_repo.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';

class ActivityLikeVm extends GetxController {
  var isLoading = true.obs;

  getActivityLikeCount(
    LikeActivityModal likeActivity,
    int activityId,
    int likeTypeId,
  ) async {
    await ActivityLikeRepo.getActivityLikeCount(
        userIdValue.read('userId'),
        userIdValue.read('userId'),
        DateTime.now(),
        DateTime.now(),
        true,
        // 0
        activityId,
        likeTypeId,
        '',
        DateTime.now());
    isLoading.value = false;
  }
}
