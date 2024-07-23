import 'dart:convert';

LikeActivityModal likeCommentModalFromJson(String str) =>
    LikeActivityModal.fromJson(json.decode(str));

String likeCommentModalToJson(LikeActivityModal data) =>
    json.encode(data.toJson());

class LikeActivityModal {
  LikeActivityModal({
    this.createdBy,
    this.modifiedBy,
    this.createdDate,
    this.modifiedDate,
    this.isDeleted,
    this.id,
    this.activityId,
    this.likeTypeId,
    this.imageName,
    this.timestamp,
  });

  int? createdBy;
  int? modifiedBy;
  DateTime? createdDate;
  DateTime? modifiedDate;
  bool? isDeleted;
  int? id;
  int? activityId;
  int? likeTypeId;
  String? imageName;
  DateTime? timestamp;

  factory LikeActivityModal.fromJson(Map<String, dynamic> json) =>
      LikeActivityModal(
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
        id: json["id"],
        activityId: json["activityId"],
        likeTypeId: json["likeTypeId"],
        imageName: json["imageName"],
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
        "likeTypeId": likeTypeId,
        "imageName": imageName,
        "timestamp": timestamp!.toIso8601String(),
      };
}
