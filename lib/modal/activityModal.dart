import 'dart:convert';

ActivityModal activityModalFromJson(String str) =>
    ActivityModal.fromJson(json.decode(str));

String activityModalToJson(ActivityModal data) => json.encode(data.toJson());

class ActivityModal {
  ActivityModal({
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
  String? createdDate;
  String? modifiedDate;
  bool? isDeleted;
  int? id;
  String? title;
  String? description;
  String? activityDate;
  int? categoryId;
  String? locationName;
  String? latitude;
  String? longitude;
  String? timestamp;
  int? grampanchayatId;
  List<GramSuvidhaActivity>? gramSuvidhaActivities;

  factory ActivityModal.fromJson(Map<String, dynamic> json) => ActivityModal(
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        isDeleted: json["isDeleted"],
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
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "isDeleted": isDeleted,
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
            List<dynamic>.from(gramSuvidhaActivities!.map((x) => x.toJson())),
      };
}

class GramSuvidhaActivity {
  GramSuvidhaActivity({
    this.createdBy,
    this.modifiedBy,
    this.createdDate,
    this.modifiedDate,
    this.isDeleted,
    this.id,
    this.activityId,
    this.imagePath,
    this.imageName,
    this.timestamp,
    this.grampanchayatId,
  });

  int? createdBy;
  int? modifiedBy;
  String? createdDate;
  String? modifiedDate;
  bool? isDeleted;
  int? id;
  int? activityId;
  String? imagePath;
  String? imageName;
  String? timestamp;
  int? grampanchayatId;

  factory GramSuvidhaActivity.fromJson(Map<String, dynamic> json) =>
      GramSuvidhaActivity(
        createdBy: json["createdBy"],
        modifiedBy: json["modifiedBy"],
        createdDate: json["createdDate"],
        modifiedDate: json["modifiedDate"],
        isDeleted: json["isDeleted"],
        id: json["id"],
        activityId: json["activityId"],
        imagePath: json["imagePath"],
        imageName: json["imageName"],
        timestamp: json["timestamp"],
        grampanchayatId: json["grampanchayatId"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate,
        "modifiedDate": modifiedDate,
        "isDeleted": isDeleted,
        "id": id,
        "activityId": activityId,
        "imagePath": imagePath,
        "imageName": imageName,
        "timestamp": timestamp,
        "grampanchayatId": grampanchayatId,
      };
}
