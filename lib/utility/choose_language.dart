import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_widgets.dart';
import 'localization_file.dart';

final selectLanguage = GetStorage();
final chooseLanguage = GetStorage();

class ChooseLangugeAlertDialog extends StatefulWidget {
  const ChooseLangugeAlertDialog({Key? key}) : super(key: key);

  @override
  State<ChooseLangugeAlertDialog> createState() =>
      _ChooseLangugeAlertDialogState();
}

class _ChooseLangugeAlertDialogState extends State<ChooseLangugeAlertDialog> {
  ///App Language Selection DialogBox

  String _radioBtnVal = selectLanguage.read('language') ?? selectedLanguage;
  bool isShown = true;

  ///Method to handle language Change
  _handleChange(String? value) {
    setState(() {
      _radioBtnVal = value.toString();
      selectedLanguage = _radioBtnVal;
      selectLanguage.write('language', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(
        bottom: context.mediaQueryHeight / 25,
        top: context.mediaQueryHeight * 0.01,
        left: context.mediaQueryWidth * 0.23,
        right: context.mediaQueryWidth * 0.23,
      ),
      contentPadding: EdgeInsets.only(
          top: !showCloseIcon
              ? context.mediaQueryHeight / 20
              : context.mediaQueryHeight * 0.001),
      titlePadding: EdgeInsets.only(right: context.mediaQueryHeight * 0.002),
      actionsAlignment: MainAxisAlignment.spaceAround,
      title: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: showCloseIcon
                ? IconButton(
                    splashRadius: context.mediaQueryWidth/22,
                    icon: SvgPicture.asset(
                        'assets/images/dashboard_screen/close.svg',width: context.mediaQueryWidth/25),
                    onPressed: () {
                      Get.back();
                    },
                  )
                : Container(),
          ),
        ],
      ),
      content: Text(
        'chooseLanguage'.tr,
        textAlign: TextAlign.center,
      ),
      actions: [
        Column(
          children: [
            ///English
            GestureDetector(
              onTap: () {
                setState(() {
                  _handleChange(english);
                });
              },
              child: Container(
                height: context.mediaQueryWidth / 12,
                width: context.mediaQueryWidth * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _radioBtnVal == english
                          ? const Color(0XFF2980B9)
                          : Colors.grey,
                    )),
                child: Row(
                  children: [
                    Radio(
                        value: english,
                        groupValue: _radioBtnVal,
                        onChanged: _handleChange),
                    Text(
                      'english'.tr,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.mediaQueryWidth / 50),

            ///Marathi
            GestureDetector(
              onTap: () {
                setState(() {
                  _handleChange(marathi);
                });
              },
              child: Container(
                height: context.mediaQueryWidth / 12,
                width: context.mediaQueryWidth * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _radioBtnVal == marathi
                          ? const Color(0XFF2980B9)
                          : Colors.grey,
                    )),
                child: Row(
                  children: [
                    Radio(
                        value: marathi,
                        groupValue: _radioBtnVal,
                        onChanged: _handleChange),
                    Text(
                      'marathi'.tr,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.mediaQueryWidth / 50),

            ///Hindi
            GestureDetector(
              onTap: () {
                setState(() {
                  _handleChange(hindi);
                });
              },
              child: Container(
                height: context.mediaQueryWidth / 12,
                width: context.mediaQueryWidth * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _radioBtnVal == hindi
                          ? const Color(0XFF2980B9)
                          : Colors.grey,
                    )),
                child: Row(
                  children: [
                    Radio(
                        value: hindi,
                        groupValue: _radioBtnVal,
                        onChanged: _handleChange),
                    Text(
                      'hindi'.tr,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.mediaQueryWidth / 40),

            GestureDetector(
              onTap: () async {
                setState(() {
                  var locale = _radioBtnVal == english
                      ? const Locale('en', "US")
                      : _radioBtnVal == marathi
                          ? const Locale('mr', "IN")
                          : _radioBtnVal == hindi
                              ? const Locale('hi', "IN")
                              : const Locale('en', "US");
                  Get.updateLocale(locale);
                });
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setBool('isShown', true);
                chooseLanguage.write('langSelected', true);
                /*  if(preferences.getBool('login') == null){
                  Get.offAllNamed('/registrationOtp');
                }*/

                Get.back();
              },
              child: Padding(
                padding: EdgeInsets.only(top: context.mediaQueryWidth / 20),
                child: const CircleAvatar(
                  backgroundColor: Color(0XFF2980B9),
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
