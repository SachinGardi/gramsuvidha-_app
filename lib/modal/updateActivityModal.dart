import 'dart:convert';

UpdateActivityModal updateActivityModalFromJson(String str) =>
    UpdateActivityModal.fromJson(json.decode(str));

String updateActivityModalToJson(UpdateActivityModal data) =>
    json.encode(data.toJson());

class UpdateActivityModal {
  UpdateActivityModal({
    this.createdBy,
    this.modifiedBy,
    this.createdDate,
    this.modifiedDate,
    this.isDeleted,
    this.id,
    this.title,
    this.description,
    this.activityDate,
    this.categoryId,
    this.locationName,
    this.latitude,
    this.longitude,
    this.timestamp,
    this.grampanchayatId,
    this.gramSuvidhaActivities,
  });

  int? createdBy;
  int? modifiedBy;
  DateTime? createdDate;
  DateTime? modifiedDate;
  bool? isDeleted;
  int? id;
  String? title;
  String? description;
  DateTime? activityDate;
  int? categoryId;
  String? locationName;
  String? latitude;
  String? longitude;
  DateTime? timestamp;
  int? grampanchayatId;
  List<GramSuvidhaActivity>? gramSuvidhaActivities;

  factory UpdateActivityModal.fromJson(Map<String, dynamic> json) =>
      UpdateActivityModal(
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
        id: json["id"],
        title: json["title"],
        description: json["description"],
        activityDate: DateTime.parse(json["activityDate"]),
        categoryId: json["categoryId"],
        locationName: json["locationName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        timestamp: DateTime.parse(json["timestamp"]),
        grampanchayatId: json["grampanchayatId"],
        gramSuvidhaActivities: List<GramSuvidhaActivity>.from(
            json["gramSuvidhaActivities"]
                .map((x) => GramSuvidhaActivity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate!.toIso8601String(),
        "modifiedDate": modifiedDate!.toIso8601String(),
        "isDeleted": isDeleted,
        "id": id,
        "title": title,
        "description": description,
        "activityDate": activityDate!.toIso8601String(),
        "categoryId": categoryId,
        "locationName": locationName,
        "latitude": latitude,
        "longitude": longitude,
        "timestamp": timestamp!.toIso8601String(),
        "grampanchayatId": grampanchayatId,
        "gramSuvidhaActivities":
            List<dynamic>.from(gramSuvidhaActivities!.map((x) => x.toJson())),
      };
}

class GramSuvidhaActivity {
  GramSuvidhaActivity({
    required this.createdBy,
    required this.modifiedBy,
    required this.createdDate,
    required this.modifiedDate,
    required this.isDeleted,
    required this.id,
    required this.activityId,
    required this.imagePath,
    required this.imageName,
    required this.timestamp,
    required this.grampanchayatId,
  });

  int createdBy;
  int modifiedBy;
  DateTime createdDate;
  DateTime modifiedDate;
  bool isDeleted;
  int id;
  int activityId;
  String imagePath;
  String imageName;
  DateTime timestamp;
  int grampanchayatId;

  factory GramSuvidhaActivity.fromJson(Map<String, dynamic> json) =>
      GramSuvidhaActivity(
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
        id: json["id"],
        activityId: json["activityId"],
        imagePath: json["imagePath"],
        imageName: json["imageName"],
        timestamp: DateTime.parse(json["timestamp"]),
        grampanchayatId: json["grampanchayatId"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate.toIso8601String(),
        "modifiedDate": modifiedDate.toIso8601String(),
        "isDeleted": isDeleted,
        "id": id,
        "activityId": activityId,
        "imagePath": imagePath,
        "imageName": imageName,
        "timestamp": timestamp.toIso8601String(),
        "grampanchayatId": grampanchayatId
      };
}
