import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import '../utility/utilityColor.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashBackgroundColor,
        centerTitle: true,
        title:Text(
          'addUser'.tr,
          style:TextStyle(fontSize: context.mediaQueryHeight/40),
        ),
        leading: IconButton(
          splashRadius: 20,
            onPressed: () {
            Get.back();
            }, icon: const Icon(Icons.arrow_back,size: 22,)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: context.mediaQueryWidth / 15,
                  right: context.mediaQueryWidth / 15,
                  top: context.mediaQueryHeight / 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text('userName'.tr),
                        hintStyle: const TextStyle(fontSize: 15),
                        labelStyle: const TextStyle(fontSize: 14)),
                  ),
                  SizedBox(
                    height: context.mediaQueryWidth / 60,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text('userContact'.tr),
                        hintStyle: const TextStyle(fontSize: 15),
                        labelStyle: const TextStyle(fontSize: 14)),
                  ),
                  SizedBox(
                    height: context.mediaQueryHeight / 60,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        isDense: true,
                        label: Text('rollOfUser'.tr),
                        hintStyle: const TextStyle(fontSize: 15),
                        labelStyle: const TextStyle(fontSize: 14)),
                  ),
                  SizedBox(
                    height: context.mediaQueryHeight / 20,
                  ),
                  Text(
                    'kycDocs'.tr,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: context.mediaQueryWidth / 60,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 15,
                        child: TextFormField(
                          decoration: InputDecoration(
                              enabled: false,
                              labelText: 'docsName'.tr,
                              prefixIcon: const Icon(
                                Icons.article,
                                color: Color(0XFF2980B9),
                              ),
                              isDense: true,
                              hintStyle: const TextStyle(fontSize: 14),
                              labelStyle: const TextStyle(fontSize: 14)),
                        ),
                      ),
                      SizedBox(
                        width: context.mediaQueryWidth / 30,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: context.mediaQueryWidth / 10,
                          child: FloatingActionButton(
                              elevation: 0.0,
                              backgroundColor: const Color(0XFF2980B9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {},
                              child: Icon(Icons.add)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.mediaQueryWidth / 60,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 15,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              enabled: false,
                              prefixIcon: Icon(
                                Icons.article,
                                color: Color(0XFF2980B9),
                              ),
                              isDense: true,
                              label: Text(
                                'Aadhar Card',
                                style: TextStyle(color: Colors.black),
                              ),
                              hintStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(fontSize: 14)),
                        ),
                      ),
                      SizedBox(
                        width: context.mediaQueryWidth / 30,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: context.mediaQueryWidth / 18),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20,
                              ),
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.mediaQueryWidth / 60,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 15,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              enabled: false,
                              prefixIcon: Icon(
                                Icons.article,
                                color: Color(0XFF2980B9),
                              ),
                              isDense: true,
                              label: Text(
                                'Pan Card',
                                style: TextStyle(color: Colors.black),
                              ),
                              hintStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(fontSize: 14)),
                        ),
                      ),
                      SizedBox(
                        width: context.mediaQueryWidth / 30,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: context.mediaQueryWidth / 18),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20,
                              ),
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.mediaQueryWidth / 60,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 15,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              enabled: false,
                              prefixIcon: Icon(
                                Icons.article,
                                color: Color(0XFF2980B9),
                              ),
                              isDense: true,
                              label: Text(
                                'Light Bill',
                                style: TextStyle(color: Colors.black),
                              ),
                              hintStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(fontSize: 14)),
                        ),
                      ),
                      SizedBox(
                        width: context.mediaQueryWidth / 30,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: context.mediaQueryWidth / 18),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20,
                              ),
                            )),
                      )
                    ],
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (context.mediaQueryHeight > 700) {
                        return SizedBox(
                          height: context.mediaQueryWidth / 2.5,
                        );
                      }
                      return SizedBox(
                        height: context.mediaQueryWidth / 6,
                      );
                    },
                  ),
                  Center(
                    child: SizedBox(
                      height: context.mediaQueryWidth / 10,
                      width: context.mediaQueryWidth / 2.5,
                      child: FloatingActionButton(
                          heroTag: 'Tag',
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: buttonColor,
                          onPressed: () {},
                          child: Text(
                            'addUser'.tr,
                            style: const TextStyle(
                                fontFamily: 'Montserrat-Regular', fontSize: 13),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
