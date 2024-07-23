import 'package:get/get.dart';
import 'package:gramsuvidha/repository/update_comment_repo.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';

import '../modal/updateCommentModal.dart';

class UpdateCommentVm extends GetxController {
  var isLoading = true.obs;

  List<UpdateCommentModal> updateCommentInfo = [];
  bool? isComment;

  updateComment(UpdateCommentModal updateComment, int commentId, int activityId,
      String updatedComment) async {
    await UpdateCommentRepo.updateComment(
        userIdValue.read('userId'),
        userIdValue.read('userId'),
        DateTime.now(),
        DateTime.now(),
        true,
        commentId,
        activityId,
        updatedComment,
        DateTime.now());

    isComment = UpdateCommentRepo.isCommentUpdated;
  }
}
