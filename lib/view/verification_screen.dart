import 'package:countdown_widget/countdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_widgets/progress_indicator.dart';
import '../repository/post_otp.dart';
import '../utility/textcontroller.dart';
import '../utility/utilityColor.dart';
import '../utility/utilityMethods.dart';
import '../view_modal/post_otp_vm.dart';
import '../view_modal/varify_number.dart';

final nameStorage = GetStorage();

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final postOtpViewModal = Get.put(PostOtpViewModal());
  final otpViewModal = Get.put(OTPViewModal());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: registrationOtpScreenBackgroundColor,
      body: ProgressHUD(
        indicatorWidget: progressIndicator(),
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10),
                child: Center(
                    child: SvgPicture.asset(
                        'assets/images/registrationOtp_screen/Gram Login Logo.svg')),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Text(
                'otp'.tr,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Text('ovMessage'.tr),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('+(91)${mobileController.text}'),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAndToNamed('/registrationOtp');
                      otpController2.clear();
                    },
                    child: SvgPicture.asset(
                      'assets/images/dashboard_screen/resize.svg',
                      height: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Container(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          spreadRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: registrationOtpContainerColor),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 30,
                      left: MediaQuery.of(context).size.width / 15,
                      right: MediaQuery.of(context).size.width / 15),
                  child: Column(
                    children: [
                      PinCodeTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        useHapticFeedback: true,
                        autoDisposeControllers: false,

                        dialogConfig: DialogConfig(
                            dialogTitle: 'pasteTitle'.tr,
                            negativeText: 'no'.tr,
                            dialogContent: 'pasteContent'.tr,
                            affirmativeText: 'yes'.tr),
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            borderWidth: 2,
                            fieldWidth: 45,
                            borderRadius: BorderRadius.circular(10),
                            selectedFillColor: Colors.white,
                            inactiveColor: Colors.grey,
                            selectedColor: const Color(0XFF5D52FF),
                            inactiveFillColor: Colors.white,
                            activeFillColor: Colors.white,
                            activeColor: Colors.black),
                        backgroundColor: Colors.white,
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 5,
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {},
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        controller: otpController2,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },

                        beforeTextPaste: (textValue) {
                          return true;
                        },
                        onChanged: (String value) {},
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 15,
                      ),
                      Builder(
                        builder: (context) => MaterialButton(
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: getCodeButtonColor,
                          onPressed: () async {
                            final progress = ProgressHUD.of(context);
                            progress?.show();
                            await postOtpViewModal.postAllInformation(context);
                            progress?.dismiss();
                            if (PostOtpData.loginDetails.isNotEmpty) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('login', true);
                              nameStorage.write('userName', userName);
                            }
                          },
                          child: Text(
                            'submit'.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat-Regular'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              CountDownWidget(
                duration: const Duration(milliseconds: 60000),
                builder: (
                  context,
                  duration,
                ) {
                  print(duration);
                  return Column(
                    children: [
                      Text(
                        'otpNotReceivedText'.tr,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 3),
                        child: Column(
                          children: [
                            Builder(
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 18),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (duration ==
                                            const Duration(
                                                milliseconds: 00000)) {
                                          print('Hello');
                                          final progress =
                                              ProgressHUD.of(context);
                                          progress?.show();

                                          ///getOtp api call
                                          await otpViewModal.getOTPInformation(
                                              mobileController.text, context);
                                          progress?.dismiss();
                                          postOtpViewModal.restart();
                                          if (!mounted) return;
                                          UtilityMethods.snackBarMethod(context,
                                              "resendOtpSnackBarMsg".tr);
                                        }
                                      },
                                      child: Text(
                                        'resendText'.tr,
                                        style: TextStyle(
                                          color: Colors.transparent,
                                          decoration: TextDecoration.underline,
                                          decorationColor: duration ==
                                                  const Duration(
                                                      milliseconds: 00000)
                                              ? const Color(0XBB564CFF)
                                              : Colors.grey.shade500,
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(0, -5),
                                              color: duration ==
                                                      const Duration(
                                                          milliseconds: 00000)
                                                  ? const Color(0XBB564CFF)
                                                  : Colors.grey.shade500,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                    ),
                                    Text(
                                      "0:${duration.inSeconds}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0XFF6359FE),
                                          fontFamily: 'Montserrat Regular',
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
                onControllerReady: (controller) {
                  if (mounted) countDownController = controller;
                },
                onDurationRemainChanged: (duration) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
