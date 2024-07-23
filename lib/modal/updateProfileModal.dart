import 'dart:convert';

UpdateProfile updateProfileFromJson(String str) =>
    UpdateProfile.fromJson(json.decode(str));

String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

class UpdateProfile {
  UpdateProfile({
    required this.userId,
    required this.fullName,
    required this.mobileNo,
    required this.emailId,
    required this.address,
    required this.profilePhoto,
  });

  int userId;
  String fullName;
  String mobileNo;
  String emailId;
  String address;
  String profilePhoto;

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
        userId: json["userId"],
        fullName: json["fullName"],
        mobileNo: json["mobileNo"],
        emailId: json["emailId"],
        address: json["address"],
        profilePhoto: json["profilePhoto"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullName": fullName,
        "mobileNo": mobileNo,
        "emailId": emailId,
        "address": address,
        "profilePhoto": profilePhoto,
      };
}
