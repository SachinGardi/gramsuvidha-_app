import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import '../utility/utilityColor.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  ///RadioButton
  String male = 'Male';
  String female = 'Female';
  String gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F3F9),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.mediaQueryWidth / 5),
              child: Text(
                'rTitle'.tr,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(context.mediaQueryWidth / 15),
              height: context.mediaQueryWidth / 0.65,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer)
              ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: context.mediaQueryWidth / 15,
                    left: context.mediaQueryWidth / 12,
                    right: context.mediaQueryWidth / 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'nameHint'.tr,
                          hintStyle: const TextStyle(color: Colors.grey),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'mobileHint'.tr,
                          hintStyle: const TextStyle(color: Colors.grey),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'emailHint'.tr,
                          hintStyle: const TextStyle(color: Colors.grey),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),

                    ///RadioButtons
                    Row(
                      children: <Widget>[
                        Text(
                          'genderText'.tr,
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Radio(
                          activeColor: const Color(0xFF2980B9),
                          fillColor: MaterialStateProperty.all(
                              const Color(0xFF2980B9)),
                          value: male,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                        Text(
                          'maleRadioText'.tr,
                        ),
                        Radio(
                          activeColor: const Color(0xFF2980B9),
                          fillColor: MaterialStateProperty.all(
                              const Color(0xFF2980B9)),
                          value: female,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                        Text(
                          'femaleRadioText'.tr,
                        ),
                      ],
                    ),

                    TextFormField(
                      maxLines: 3,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'addressHint'.tr,
                          hintStyle: const TextStyle(color: Colors.grey),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),

                    ///can be replaced with dropdown
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'cityHint'.tr,
                          hintStyle: const TextStyle(color: Colors.grey),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'villageHint'.tr,
                          hintStyle: const TextStyle(color: Colors.grey),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'grampanchayatHint'.tr,
                          hintStyle: const TextStyle(color: Colors.grey),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),

                    MaterialButton(
                      minWidth: 150,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: buttonColor,
                      onPressed: () async {},
                      child: Text(
                        'rButton'.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat-Regular'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'existAccountText'.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 13),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/registrationOtp');
                          },
                          child: Text(
                            'login'.tr,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
