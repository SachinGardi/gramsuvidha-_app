import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/modal/deleteCommentModal.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';

import '../repository/delete_comment_repo.dart';

class DeleteCommentVm extends GetxController {
  var isLoading = true.obs;

  deleteComment(BuildContext context, DeleteCommentModal deleteComment,
      int commentId) async {
    await DeleteCommentRepo.deleteComment(
        context,
        commentId,
        userIdValue.read('userId'),
        userIdValue.read('userId'),
        DateTime.now(),
        true);

    isLoading.value = false;
  }
}
