import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class UtilityMethods {
  ///Snackbar for the messages
  static snackBarMethod(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0.0,
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 8,
        right: MediaQuery.of(context).size.width / 8,
        bottom: MediaQuery.of(context).size.width / 8,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Row(children: <Widget>[
        Expanded(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        )
      ]),
      duration: const Duration(milliseconds: 1500),
    ));
  }

  ///App Exit Confirmation Dialog
  static Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'exitAppTitle'.tr,
              style: const TextStyle(fontFamily: 'Montserrat-Regular'),
            ),
            content: Text(
              'exitAppMsg'.tr,
              style: const TextStyle(fontFamily: 'Montserrat-Regular'),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                    backgroundColor: getCodeButtonColor),
                //return false when click on "NO"
                child: Text(
                  'no'.tr,
                  style: const TextStyle(fontFamily: 'Montserrat-Regular'),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                    backgroundColor: getCodeButtonColor),
                //return true when click on "Yes"
                child: Text(
                  'yes'.tr,
                  style: const TextStyle(fontFamily: 'Montserrat-Regular'),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  ///Internet connectivity check

  static late StreamSubscription subscription;
  static var isDeviceConnected = false;
  static bool isAlertSet = false;

  static getConnectivity(BuildContext context) => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("No Connection"),
                    content: const Text("Please check Internet Connectivity"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                            isAlertSet = false;
                          },
                          child: const Text("OK"))
                    ],
                  ));
        }
      });
}
