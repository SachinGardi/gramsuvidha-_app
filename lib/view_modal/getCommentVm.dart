import 'package:get/get.dart';
import 'package:gramsuvidha/repository/get_comment_repo.dart';
import 'package:gramsuvidha/view_modal/getDashboardActivityVm.dart';
import '../modal/getCommentModal.dart';

class GetCommentVm extends GetxController {
  var isLoading = true.obs;
  List<GetCommentModal> getCommentInfo = [];
  final dashboardActivityVm = Get.put(GetDashboardActivityVm());

  getComment(GetCommentModal getCommentModal, int id) async {
    var commentInfo = await GetCommentRepo.getComment(id);
    if (commentInfo != null) {
      getCommentInfo = commentInfo;
    }

    isLoading.value = false;
  }
}
