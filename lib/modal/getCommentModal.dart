import 'dart:convert';

GetCommentModal getCommentModalFromJson(String str) =>
    GetCommentModal.fromJson(json.decode(str));

String getCommentModalToJson(GetCommentModal data) =>
    json.encode(data.toJson());

class GetCommentModal {
  GetCommentModal({
    this.id,
    this.activityId,
    this.comments,
    this.fullName,
    this.timestamp,
    this.key,
    this.createdBy,
    this.modifiedBy,
    this.createdDate,
    this.modifiedDate,
    this.isDeleted,
  });

  int? id;
  int? activityId;
  String? comments;
  String? fullName;
  DateTime? timestamp;
  String? key;
  int? createdBy;
  int? modifiedBy;
  DateTime? createdDate;
  DateTime? modifiedDate;
  bool? isDeleted;

  factory GetCommentModal.fromJson(Map<String, dynamic> json) =>
      GetCommentModal(
        id: json["id"],
        activityId: json["activityId"],
        comments: json["comments"],
        fullName: json["fullName"],
        timestamp: DateTime.parse(json["timestamp"]),
        key: json["key"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activityId": activityId,
        "comments": comments,
        "fullName": fullName,
        "timestamp": timestamp!.toIso8601String(),
        "key": key,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate!.toIso8601String(),
        "modifiedDate": modifiedDate!.toIso8601String(),
        "isDeleted": isDeleted,
      };
}
