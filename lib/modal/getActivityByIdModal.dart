import 'dart:convert';

GetActivityByIdModal updateActivityModalFromJson(String str) =>
    GetActivityByIdModal.fromJson(json.decode(str));

String updateActivityModalToJson(GetActivityByIdModal data) =>
    json.encode(data.toJson());

class GetActivityByIdModal {
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
  String? key;
  int? createdBy;
  int? modifiedBy;
  DateTime? createdDate;
  DateTime? modifiedDate;
  bool? isDeleted;

  GetActivityByIdModal({
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
    this.key,
    this.createdBy,
    this.modifiedBy,
    this.createdDate,
    this.modifiedDate,
    this.isDeleted,
  });

  factory GetActivityByIdModal.fromJson(Map<String, dynamic> json) =>
      GetActivityByIdModal(
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
        key: json["key"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedDate: DateTime.parse(json["modifiedDate"]),
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
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
        "key": key,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate!.toIso8601String(),
        "modifiedDate": modifiedDate!.toIso8601String(),
        "isDeleted": isDeleted,
      };
}

class GramSuvidhaActivity {
  int id;
  int activityId;
  String imagePath;
  String imageName;
  DateTime timestamp;
  int grampanchayatId;
  String key;
  int createdBy;
  int modifiedBy;
  DateTime createdDate;
  DateTime modifiedDate;
  bool isDeleted;

  GramSuvidhaActivity({
    required this.id,
    required this.activityId,
    required this.imagePath,
    required this.imageName,
    required this.timestamp,
    required this.grampanchayatId,
    required this.key,
    required this.createdBy,
    required this.modifiedBy,
    required this.createdDate,
    required this.modifiedDate,
    required this.isDeleted,
  });

  factory GramSuvidhaActivity.fromJson(Map<String, dynamic> json) =>
      GramSuvidhaActivity(
        id: json["id"],
        activityId: json["activityId"],
        imagePath: json["imagePath"],
        imageName: json["imageName"],
        timestamp: DateTime.parse(json["timestamp"]),
        grampanchayatId: json["grampanchayatId"],
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
        "imagePath": imagePath,
        "imageName": imageName,
        "timestamp": timestamp.toIso8601String(),
        "grampanchayatId": grampanchayatId,
        "key": key,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate.toIso8601String(),
        "modifiedDate": modifiedDate.toIso8601String(),
        "isDeleted": isDeleted,
      };
}
