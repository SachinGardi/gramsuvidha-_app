import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../utility/utilityColor.dart';

int? bottomIndex;

class BottomNavigationBarClass extends StatefulWidget {
  const BottomNavigationBarClass({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarClass> createState() =>
      _BottomNavigationBarClassState();
}

class _BottomNavigationBarClassState extends State<BottomNavigationBarClass> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bottomIndex = 2;
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      letIndexChange: (value) {
        if (value != 2) {
          return false;
        }
        return true;
      },
      animationCurve: Curves.linear,
      index: bottomIndex!,
      height: MediaQuery.of(context).size.height / 14.5,
      items: <Widget>[
        Text(''),
        Text(''),
        bottomNavigationItemLogin(context,
            height: MediaQuery.of(context).size.height / 30,
            name: "Activity".tr,
            color: Colors.white),
        Text(''),
        Text(''),
      ],

      backgroundColor: Colors.transparent,
      buttonBackgroundColor: getCodeButtonColor,
      onTap: (int index) async {
        switch (index) {
          case 2:
            Get.toNamed("/activityScreen");
            break;
          case 1:
            break;
          case 0:
            break;
          case 3:
            break;
          case 4:
            break;
          case 5:
            break;
        }
      },

      // letIndexChange: (index) => index == 4 ? false:true,
    );
  }
}

Widget bottomNavigationItem(
  BuildContext context, {
  String imgPath = "",
  String name = "home",
  double height = 35,
  Color color = Colors.orangeAccent,
}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 70,
        ),
        SvgPicture.asset(imgPath, height: height, color: color),
        SizedBox(
          height: MediaQuery.of(context).size.height / 150,
        ),
        Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height / 80),
        ),
      ],
    );

Widget bottomNavigationItemLogin(
  BuildContext context, {
  IconData icon = Icons.add,
  String name = "home",
  double height = 35,
  Color color = Colors.orangeAccent,
}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
      ],
    );
