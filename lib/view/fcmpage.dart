import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';
import 'package:intl/intl.dart';

class FcmPage extends StatefulWidget {
  final String? id;
  final String? title;
  final String? body;
  final DateTime? date;
  AudioPlayer player;

  FcmPage(
      {Key? key,
      this.id,
      this.title,
      this.body,
      this.date,
      required this.player})
      : super(key: key);

  @override
  State<FcmPage> createState() => FcmPageState();
}

class FcmPageState extends State<FcmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: splashBackgroundColor,
          title: Text('notificationAppBarText'.tr),
          elevation: 0.0,
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[50],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: (widget.title != null &&
                      widget.body != null &&
                      widget.date != null)
                  ? Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'title'.tr,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                              ),
                              child: Text(
                                widget.title!,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'description'.tr,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 40,
                                  top:
                                      MediaQuery.of(context).size.height / 100),
                              height: MediaQuery.of(context).size.height / 14,
                              width: MediaQuery.of(context).size.width / 1.1,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                              ),
                              child: Text(
                                widget.body!,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat.yMMMEd().format(widget.date!),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            ),
          ],
        ));
  }
}
