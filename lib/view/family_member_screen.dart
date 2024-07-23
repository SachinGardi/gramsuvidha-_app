import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utilityColor.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';

class FamilyMemberScreen extends StatefulWidget {
  const FamilyMemberScreen({Key? key}) : super(key: key);

  @override
  State<FamilyMemberScreen> createState() => _FamilyMemberScreenState();
}

class _FamilyMemberScreenState extends State<FamilyMemberScreen> {
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
            onPressed: () {},
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
            ///Grid and List View Icon
            Padding(
              padding: EdgeInsets.only(
                  left: context.mediaQueryWidth / 1.12,
                  top: context.mediaQueryWidth / 4.5),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isGridView = !isGridView;
                      print(isGridView);
                    });
                  },
                  child: isGridView
                      ? const Icon(
                          Icons.grid_view,
                          color: Color(0XFF428EC1),
                        )
                      : const Icon(Icons.list_alt_rounded,
                          color: Color(0XFF428EC1))),
            ),

            ///Family member container with grid and listview
            Padding(
              padding: EdgeInsets.only(top: context.mediaQueryWidth / 3.2),
              child: SizedBox(
                  height: context.mediaQueryHeight / 1.12,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.mediaQueryWidth / 20),
                      child: isGridView
                          ? GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 10,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 25,
                                      crossAxisSpacing: 25),
                              itemBuilder: (context, index) => Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
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

                                      ///Circle Avtar
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
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15))),
                                      )
                                    ],
                                  )),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 10,
                              itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom: context.mediaQueryWidth / 30),
                                  child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    height: context.mediaQueryWidth / 5,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                          ),
                                          child: Container(
                                            height:
                                                context.mediaQueryWidth / 5.4,
                                            width: context.mediaQueryWidth / 70,
                                            color: index.isEven
                                                ? const Color(0XFF3DCD13)
                                                : const Color(0XFFFC4F4F),
                                          ),
                                        ),

                                        SizedBox(
                                          width: context.mediaQueryWidth / 50,
                                        ),
                                        CircleAvatar(
                                          radius: context.mediaQueryWidth / 14,
                                          backgroundColor:
                                              const Color(0XFFE2E1E6),
                                          child: CircleAvatar(
                                            radius:
                                                context.mediaQueryWidth / 14.5,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: context.mediaQueryWidth /
                                                  15.5,
                                              backgroundColor: Colors.teal,
                                              backgroundImage: const NetworkImage(
                                                  'https://pbs.twimg.com/media/Eu7kZRRWgAMJjj8?format=png&name=large'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.mediaQueryWidth / 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  context.mediaQueryWidth / 25),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Amit Sanjay Thorat',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0XFF3256D8),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    width: context
                                                            .mediaQueryWidth /
                                                        3.7,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    context.mediaQueryWidth /
                                                        35,
                                              ),
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: context
                                                            .mediaQueryWidth /
                                                        60,
                                                    backgroundColor:
                                                        const Color(0XFFB2D1E6),
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
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                  SizedBox(
                                                    width: context
                                                            .mediaQueryWidth /
                                                        10,
                                                  ),
                                                  CircleAvatar(
                                                    radius: context
                                                            .mediaQueryWidth /
                                                        60,
                                                    backgroundColor:
                                                        const Color(0XFFB2D1E6),
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
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        ///Delete iconButton
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
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
                                  )),
                            ))),
            ),

            ///Add user button
            Padding(
              padding: EdgeInsets.only(
                top: context.mediaQueryHeight / 1.2,
              ),
              child: Center(
                child: SizedBox(
                  height: context.mediaQueryWidth / 10,
                  width: context.mediaQueryWidth / 2.5,
                  child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Get.toNamed('/addUserScreen');
                      },
                      child: const Text(
                        'Add User',
                        style: TextStyle(
                            fontFamily: 'Montserrat-Regular', fontSize: 13),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
