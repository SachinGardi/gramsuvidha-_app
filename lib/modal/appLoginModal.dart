class AppLoginModal {
  int? userId;
  String? fullName;
  String? mobileNo;
  String? address;
  int? stateId;
  int? districtId;
  int? talukaId;
  int? villageId;
  int? userTypeId;
  int? yojanaId;
  int? networkId;
  String? userTypeName;
  String? yojanaName;
  int? grampanchayatId;
  int? appId;

  AppLoginModal({
    this.userId,
    this.fullName,
    this.mobileNo,
    this.address,
    this.stateId,
    this.districtId,
    this.talukaId,
    this.villageId,
    this.userTypeId,
    this.yojanaId,
    this.networkId,
    this.userTypeName,
    this.yojanaName,
    this.grampanchayatId,
    this.appId,
  });

  factory AppLoginModal.fromJson(Map<String, dynamic> json) => AppLoginModal(
        userId: json["userId"],
        fullName: json["fullName"],
        mobileNo: json["mobileNo"],
        address: json["address"],
        stateId: json["stateId"],
        districtId: json["districtId"],
        talukaId: json["talukaId"],
        villageId: json["villageId"],
        userTypeId: json["userTypeId"],
        yojanaId: json["yojanaId"],
        networkId: json["networkId"],
        userTypeName: json["userTypeName"],
        yojanaName: json["yojanaName"],
        grampanchayatId: json["grampanchayatId"],
        appId: json["appId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullName": fullName,
        "mobileNo": mobileNo,
        "address": address,
        "stateId": stateId,
        "districtId": districtId,
        "talukaId": talukaId,
        "villageId": villageId,
        "userTypeId": userTypeId,
        "yojanaId": yojanaId,
        "networkId": networkId,
        "userTypeName": userTypeName,
        "yojanaName": yojanaName,
        "grampanchayatId": grampanchayatId,
        "appId": appId
      };
}
