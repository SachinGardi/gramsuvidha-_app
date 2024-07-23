import 'dart:convert';

GetAllActivityModal activityModalFromJson(String str) =>
    GetAllActivityModal.fromJson(json.decode(str));

String activityModalToJson(GetAllActivityModal data) =>
    json.encode(data.toJson());

class GetAllActivityModal {
  GetAllActivityModal({
    required this.id,
    required this.title,
    required this.description,
    required this.activityDate,
    required this.categoryId,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.grampanchayatId,
    required this.gramSuvidhaActivities,
    required this.key,
    required this.createdBy,
    required this.modifiedBy,
    required this.createdDate,
    required this.modifiedDate,
    required this.isDeleted,
  });

  int id;
  String title;
  String description;
  String activityDate;
  int categoryId;
  String locationName;
  String latitude;
  String longitude;
  String timestamp;
  int grampanchayatId;
  List<dynamic> gramSuvidhaActivities;
  String key;
  int createdBy;
  int modifiedBy;
  String createdDate;
  String modifiedDate;
  bool isDeleted;

  factory GetAllActivityModal.fromJson(Map<String, dynamic> json) =>
      GetAllActivityModal(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        activityDate: json["activityDate"],
        categoryId: json["categoryId"],
        locationName: json["locationName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        timestamp: json["timestamp"],
        grampanchayatId: json["grampanchayatId"],
        gramSuvidhaActivities: List<GramSuvidhaActivity>.from(
            json["gramSuvidhaActivities"]
                .map((x) => GramSuvidhaActivity.fromJson(x))),
        key: json["key"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "activityDate": activityDate,
        "categoryId": categoryId,
        "locationName": locationName,
        "latitude": latitude,
        "longitude": longitude,
        "timestamp": timestamp,
        "grampanchayatId": grampanchayatId,
        "gramSuvidhaActivities":
            List<dynamic>.from(gramSuvidhaActivities.map((x) => x.toJson())),
        "key": key,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "isDeleted": isDeleted,
      };
}

class GramSuvidhaActivity {
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

  int id;
  int activityId;
  String imagePath;
  String imageName;
  String timestamp;
  int grampanchayatId;
  String key;
  int createdBy;
  int modifiedBy;
  String createdDate;
  String modifiedDate;
  bool isDeleted;

  factory GramSuvidhaActivity.fromJson(Map<String, dynamic> json) =>
      GramSuvidhaActivity(
        id: json["id"],
        activityId: json["activityId"],
        imagePath: json["imagePath"],
        imageName: json["imageName"],
        timestamp: json["timestamp"],
        grampanchayatId: json["grampanchayatId"],
        key: json["key"],
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        isDeleted: json["isDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activityId": activityId,
        "imagePath": imagePath,
        "imageName": imageName,
        "timestamp": timestamp,
        "grampanchayatId": grampanchayatId,
        "key": key,
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "isDeleted": isDeleted,
      };
}
