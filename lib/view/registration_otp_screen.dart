import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import '../utility/choose_language.dart';
import '../utility/textcontroller.dart';
import '../utility/utilityColor.dart';
import '../utility/utilityMethods.dart';
import '../view_modal/varify_number.dart';

class RegistrationOtpScreen extends StatefulWidget {
  const RegistrationOtpScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationOtpScreen> createState() => RegistrationOtpScreenState();
}

final otpViewModal = Get.put(OTPViewModal());
bool stopMusic = false;

class RegistrationOtpScreenState extends State<RegistrationOtpScreen> {
  static DateTime currentDate = DateTime.now();
  static String title = '';
  static String body = '';
  static String date = '';

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    FirebaseMessaging _firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token) {
      print("token is $token");
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chooseLanguage.read('langSelected') == null) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                const ChooseLangugeAlertDialog());
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  bool iconShow = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => UtilityMethods.showExitPopup(context),
      child: Scaffold(
        backgroundColor: registrationOtpScreenBackgroundColor,
        body: (_connectionStatus == ConnectivityResult.none)
            ? const AlertDialog(
                title: Text("No Connection"),
                content: Text("Please check Internet Connectivity"),
              )
            : ProgressHUD(
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
                        'login'.tr,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Text('otpMessage'.tr),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width / 2.1,
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
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    value.length == 10
                                        ? iconShow = true
                                        : iconShow = false;
                                  });
                                },
                                controller: mobileController,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Text('mobileLable'.tr),
                                    hintText: 'mobileHintText'.tr,
                                    hintStyle: const TextStyle(fontSize: 15),
                                    counterText: "",
                                    isDense: true,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: context.mediaQueryHeight / 70,
                                        horizontal:
                                            context.mediaQueryWidth / 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    suffixIconConstraints: const BoxConstraints(
                                        maxHeight: 20, minWidth: 30),
                                    suffixIcon: iconShow
                                        ? SvgPicture.asset(
                                            'assets/images/registrationOtp_screen/Green Tik.svg',
                                            fit: BoxFit.scaleDown,
                                          )
                                        : null),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 15),
                              Builder(
                                builder: (context) {
                                  return Center(
                                    child: MaterialButton(
                                      minWidth: 150,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      color: getCodeButtonColor,
                                      onPressed: () async {
                                        final progress =
                                            ProgressHUD.of(context);
                                        progress?.showWithText('Loading...');
                                        await otpViewModal.getOTPInformation(
                                            mobileController.text, context);
                                        progress?.dismiss();
                                      },
                                      child: Text(
                                        'getOtp'.tr,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat-Regular'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
