import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';

Widget progressIndicator() => Center(
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10)),
        height: 80,
        width: 80,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 1,
          ),
          Text(
            "loaderWaitText".tr,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                decoration: TextDecoration.none),
          ),
        ]),
      ),
    );
