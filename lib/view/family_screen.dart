import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';

import '../utility/utilityColor.dart';

class AddFamilyMemberScreen extends StatefulWidget {
  const AddFamilyMemberScreen({Key? key}) : super(key: key);

  @override
  State<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends State<AddFamilyMemberScreen> {
  bool isGridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: splashBackgroundColor,
        centerTitle: true,
        title: Text('Add Family Member',
            style: TextStyle(fontSize: context.mediaQueryHeight / 40)),
        leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 22,
            )),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: context.mediaQueryHeight / 50,
                  right: context.mediaQueryWidth / 40),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: !isGridView
                          ? IconButton(
                              splashRadius: 20,
                              icon: Icon(
                                Icons.grid_view_outlined,
                                size: context.mediaQueryWidth / 15,
                              ),
                              color: const Color(0XFF2980B9),
                              onPressed: () {
                                setState(() {
                                  isGridView = !isGridView;
                                });
                              },
                            )
                          : IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                setState(() {
                                  isGridView = !isGridView;
                                });
                              },
                              icon: Icon(
                                Icons.list_alt_rounded,
                                size: context.mediaQueryWidth / 15,
                              ),
                              color: const Color(0XFF2980B9),
                            )),
                  SizedBox(
                    height: context.mediaQueryWidth / 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.mediaQueryHeight / 13),
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.mediaQueryWidth / 20),
                    child: Stack(
                      children: [
                        !isGridView
                            ? GridView.builder(
                                padding: EdgeInsets.only(
                                    bottom: context.mediaQueryWidth / 20),
                                itemCount: 4,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing:
                                            context.mediaQueryWidth / 20,
                                        crossAxisSpacing:
                                            context.mediaQueryWidth / 20),
                                itemBuilder: (context, index) => Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      ///Delete button
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, top: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: CircleAvatar(
                                                radius:
                                                    context.mediaQueryWidth /
                                                        50,
                                                backgroundColor:
                                                    const Color(0XFFB2D1E6),
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 10,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///Circle Avatar
                                      CircleAvatar(
                                        radius: context.mediaQueryWidth / 12,
                                        backgroundColor:
                                            const Color(0XFFE2E1E6),
                                        child: CircleAvatar(
                                          radius:
                                              context.mediaQueryWidth / 12.5,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius:
                                                context.mediaQueryWidth / 13,
                                            backgroundColor: Colors.teal,
                                            backgroundImage: const NetworkImage(
                                                'https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8?format=png&name=large'),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: context.mediaQueryWidth / 60,
                                      ),

                                      ///User Name
                                      const Text(
                                        'Amit Sanjay Thorat',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0XFF3256D8),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: context.mediaQueryWidth / 60,
                                      ),

                                      ///Person Description
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius:
                                                context.mediaQueryWidth / 60,
                                            backgroundColor:
                                                const Color(0XFFB2D1E6),
                                            child: const Icon(
                                              Icons.person,
                                              size: 8,
                                            ),
                                          ),
                                          SizedBox(
                                            width: context.mediaQueryWidth / 60,
                                          ),
                                          const Text(
                                            'Family Head',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: context.mediaQueryWidth / 70,
                                      ),

                                      ///Mobile number
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius:
                                                context.mediaQueryWidth / 60,
                                            backgroundColor:
                                                const Color(0XFFB2D1E6),
                                            child: const Icon(
                                              Icons.phone_in_talk,
                                              size: 8,
                                            ),
                                          ),
                                          SizedBox(
                                            width: context.mediaQueryWidth / 60,
                                          ),
                                          const Text(
                                            '9876543210',
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),

                                      ///botton colorful container
                                      Container(
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: index.isLowerThan(1)
                                                ? const Color(0XFF3DCD13)
                                                : const Color(0XFFFC4F4F),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: 4,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom: context.mediaQueryWidth / 40),
                                  child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    height: context.mediaQueryWidth / 5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          child: Container(
                                            height: context.mediaQueryWidth / 5,
                                            width: context.mediaQueryWidth / 60,
                                            decoration: BoxDecoration(
                                              color: index.isEven
                                                  ? const Color(0XFF3DCD13)
                                                  : const Color(0XFFFC4F4F),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            radius:
                                                context.mediaQueryWidth / 15,
                                            child: CircleAvatar(
                                              radius: context.mediaQueryWidth /
                                                  15.5,
                                              backgroundColor: Colors.white,
                                              child: CircleAvatar(
                                                radius:
                                                    context.mediaQueryWidth /
                                                        16,
                                                backgroundColor: Colors.teal,
                                                backgroundImage: const NetworkImage(
                                                    'https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8?format=png&name=large'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                'Amit Sanjay Thorat',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0XFF284ED6)),
                                              ),
                                              SizedBox(
                                                height:
                                                    context.mediaQueryWidth /
                                                        30,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: context
                                                                  .mediaQueryWidth /
                                                              60,
                                                          backgroundColor:
                                                              const Color(
                                                                  0XFFB2D1E6),
                                                          child: const Icon(
                                                            Icons.person,
                                                            size: 8,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: context
                                                                  .mediaQueryWidth /
                                                              60,
                                                        ),
                                                        const Text(
                                                          'Family Head',
                                                          style: TextStyle(
                                                              fontSize: 11),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 6,
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: context
                                                                  .mediaQueryWidth /
                                                              60,
                                                          backgroundColor:
                                                              const Color(
                                                                  0XFFB2D1E6),
                                                          child: const Icon(
                                                            Icons.phone_in_talk,
                                                            size: 8,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: context
                                                                  .mediaQueryWidth /
                                                              60,
                                                        ),
                                                        const Text(
                                                          '9876543210',
                                                          style: TextStyle(
                                                              fontSize: 11),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              right:
                                                  context.mediaQueryWidth / 60),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: CircleAvatar(
                                                  radius:
                                                      context.mediaQueryWidth /
                                                          50,
                                                  backgroundColor:
                                                      const Color(0XFFB2D1E6),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    size: 10,
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: context.mediaQueryHeight / 1.6,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: context.mediaQueryWidth / 10,
                              width: context.mediaQueryWidth / 2.5,
                              child: FloatingActionButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: buttonColor,
                                  onPressed: () {
                                    Get.toNamed('/addUserScreen');
                                  },
                                  child: Text(
                                    'addUser'.tr,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat-Regular',
                                      fontSize: 13,
                                    ),
                                  )),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
