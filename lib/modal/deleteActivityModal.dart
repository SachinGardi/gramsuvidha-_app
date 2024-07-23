import 'dart:convert';

DeleteActivityModal deleteActivityModalFromJson(String str) =>
    DeleteActivityModal.fromJson(json.decode(str));

String deleteActivityModalToJson(DeleteActivityModal data) =>
    json.encode(data.toJson());

class DeleteActivityModal {
  DeleteActivityModal({
    this.id,
    this.deletedBy,
  });

  int? id;
  int? deletedBy;

  factory DeleteActivityModal.fromJson(Map<String, dynamic> json) =>
      DeleteActivityModal(
        id: json["id"],
        deletedBy: json["deletedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deletedBy": deletedBy,
      };
}
