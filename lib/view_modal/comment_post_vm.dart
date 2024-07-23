import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/repository/commentPost_Repo.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';
import '../modal/commentPostModal.dart';

class CommentPostVm extends GetxController {
  var isLoading = true.obs;
  int commentId = 0;
  List<CommentPostModal> commentPostInfo = [];

  addPost(CommentPostModal commentPost, BuildContext context) async {
    var applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);

    await CommentPostRepo.addComment(
        userIdValue.read('userId'),
        0,
        DateTime.now(),
        DateTime.now(),
        true,
        0,
        applicationBloc.activityId!,
        commentController.text,
        DateTime.now(),
        context);
    commentId = CommentPostRepo.commentId;

    print('*************$commentId*************');
    isLoading.value = false;
  }
}
