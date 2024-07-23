import 'dart:convert';

GetDashboardActivity getDashboardActivityFromJson(String str) =>
    GetDashboardActivity.fromJson(json.decode(str));

String getDashboardActivityToJson(GetDashboardActivity data) =>
    json.encode(data.toJson());

class GetDashboardActivity {
  GetDashboardActivity({
    required this.id,
    required this.userName,
    required this.adminName,
    required this.mobileNo,
    required this.title,
    required this.description,
    required this.locationName,
    required this.categoryId,
    required this.activityDate,
    required this.activityTime,
    required this.createdDate,
    required this.createdTime,
    this.profilePhoto,
    required this.likeConut,
    required this.commentCount,
    required this.shareCount,
    required this.viewCount,
    required this.grampanchayatId,
    required this.likeDislike,
    required this.dashboardActivityImages,
    required this.dashboardActivityPageDetailsList,
  });

  int id;
  String userName;
  String adminName;
  String mobileNo;
  String title;
  String description;
  String locationName;
  int categoryId;
  String activityDate;
  String activityTime;
  String createdDate;
  String createdTime;
  dynamic profilePhoto;
  int likeConut;
  int commentCount;
  int shareCount;
  int viewCount;
  int grampanchayatId;
  bool likeDislike;
  List<dynamic> dashboardActivityImages;
  List<DashboardActivityPageDetails> dashboardActivityPageDetailsList;

  factory GetDashboardActivity.fromJson(Map<String, dynamic> json) =>
      GetDashboardActivity(
          id: json["id"],
          userName: json["userName"],
          adminName: json["adminName"],
          mobileNo: json["mobileNo"],
          title: json["title"],
          description: json["description"],
          locationName: json["locationName"],
          categoryId: json["categoryId"],
          activityDate: json["activityDate"],
          activityTime: json["activityTime"],
          createdDate: json["createdDate"],
          createdTime: json["createdTime"],
          profilePhoto: json["profilePhoto"],
          likeConut: json["like_Conut"],
          commentCount: json["comment_count"],
          shareCount: json["share_Count"],
          viewCount: json["view_Count"],
          grampanchayatId: json["grampanchayatId"],
          likeDislike: json['likeDislike'],
          dashboardActivityImages: List<DashboardActivityImage>.from(
              json["dashboardActivity_Images"]
                  .map((x) => DashboardActivityImage.fromJson(x))),
          dashboardActivityPageDetailsList:
              json['dashboardActivityPageDetailsList']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "adminName": adminName,
        "mobileNo": mobileNo,
        "title": title,
        "description": description,
        "locationName": locationName,
        "categoryId": categoryId,
        "activityDate": activityDate,
        "activityTime": activityTime,
        "createdDate": createdDate,
        "createdTime": createdTime,
        "profilePhoto": profilePhoto,
        "like_Conut": likeConut,
        "comment_count": commentCount,
        "share_Count": shareCount,
        "view_Count": viewCount,
        "grampanchayatId": grampanchayatId,
        "likeDislike": likeDislike,
        "dashboardActivity_Images":
            List<dynamic>.from(dashboardActivityImages.map((x) => x.toJson())),
        "dashboardActivityPageDetailsList": dashboardActivityPageDetailsList,
      };
}

class DashboardActivityImage {
  int id;
  int activityId;
  String imagePath;
  String imageName;
  DateTime timestamp;
  int grampanchayatId;

  DashboardActivityImage({
    required this.id,
    required this.activityId,
    required this.imagePath,
    required this.imageName,
    required this.timestamp,
    required this.grampanchayatId,
  });

  factory DashboardActivityImage.fromJson(Map<String, dynamic> json) =>
      DashboardActivityImage(
        id: json["id"],
        activityId: json["activityId"],
        imagePath: json["imagePath"],
        imageName: json["imageName"],
        timestamp: DateTime.parse(json["timestamp"]),
        grampanchayatId: json["grampanchayatId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "activityId": activityId,
        "imagePath": imagePath,
        "imageName": imageName,
        "timestamp": timestamp.toIso8601String(),
        "grampanchayatId": grampanchayatId,
      };
}

class DashboardActivityPageDetails {
  int pageNo;
  int totalPages;
  int pageCount;
  int totalCount;

  DashboardActivityPageDetails({
    required this.pageNo,
    required this.totalPages,
    required this.pageCount,
    required this.totalCount,
  });

  factory DashboardActivityPageDetails.fromJson(Map<String, dynamic> json) =>
      DashboardActivityPageDetails(
        pageNo: json["pageNo"],
        totalPages: json["totalPages"],
        pageCount: json["pageCount"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "pageNo": pageNo,
        "totalPages": totalPages,
        "pageCount": pageCount,
        "totalCount": totalCount,
      };
}
