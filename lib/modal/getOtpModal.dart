class OtpModal {
  int? userId;
  String? otp;

  OtpModal({this.userId, this.otp});

  ///convert from json to object
  factory OtpModal.fromJson(Map<String, dynamic> json) => OtpModal(
        userId: json["userId"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {"userId": userId, "otp": otp};
}
