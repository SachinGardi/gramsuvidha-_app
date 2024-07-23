import 'dart:convert';

DeleteCommentModal deleteCommentModalFromJson(String str) =>
    DeleteCommentModal.fromJson(json.decode(str));

String deleteCommentModalToJson(DeleteCommentModal data) =>
    json.encode(data.toJson());

class DeleteCommentModal {
  DeleteCommentModal({
    this.id,
    this.userId,
    this.deletedBy,
    this.modifiedDate,
    this.isDeleted,
  });

  int? id;
  int? userId;
  int? deletedBy;
  DateTime? modifiedDate;
  bool? isDeleted;

  factory DeleteCommentModal.fromJson(Map<String, dynamic> json) =>
      DeleteCommentModal(
        id: json["id"],
        userId: json["userId"],
        deletedBy: json["deletedBy"],
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "deletedBy": deletedBy,
        "modifiedDate": modifiedDate!.toIso8601String(),
        "isDeleted": isDeleted,
      };
}
