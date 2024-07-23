import 'dart:convert';

UpdateCommentModal updateCommentModalFromJson(String str) =>
    UpdateCommentModal.fromJson(json.decode(str));

String updateCommentModalToJson(UpdateCommentModal data) =>
    json.encode(data.toJson());

class UpdateCommentModal {
  UpdateCommentModal({
    this.createdBy,
    this.modifiedBy,
    this.createdDate,
    this.modifiedDate,
    this.isDeleted,
    this.id,
    this.activityId,
    this.comments,
    this.timestamp,
  });

  int? createdBy;
  int? modifiedBy;
  DateTime? createdDate;
  DateTime? modifiedDate;
  bool? isDeleted;
  int? id;
  int? activityId;
  String? comments;
  DateTime? timestamp;

  factory UpdateCommentModal.fromJson(Map<String, dynamic> json) =>
      UpdateCommentModal(
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
        id: json["id"],
        activityId: json["activityId"],
        comments: json["comments"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate!.toIso8601String(),
        "modifiedDate": modifiedDate!.toIso8601String(),
        "isDeleted": isDeleted,
        "id": id,
        "activityId": activityId,
        "comments": comments,
        "timestamp": timestamp!.toIso8601String(),
      };
}
