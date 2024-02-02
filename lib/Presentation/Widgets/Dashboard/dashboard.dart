import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';

import 'package:dummy/Presentation/Widgets/Messages/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> names = [
    "Taif",
    "Nisma",
    "Kamal",
    "Hina",
    "Rehman",
    "Rimsha",
    "Ayesha"
  ];

  final List<String> images = [
    'assets/images/6.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/1.png',
    'assets/images/7.png',
  ];
  @override
  void initState() {
    getUsersFromFirestore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: const Color.fromARGB(255, 243, 243, 243),
                  pinned: false,
                  floating: false,
                  expandedHeight: 40.0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.zero,
                    title: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12)),
                      height: 56,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/search.svg",
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Search",
                                  hintStyle: TextStyles.urbanistMed(context,
                                      color: const Color(0xff757575),
                                      fontWeight: FontWeight.w400),
                                  contentPadding: EdgeInsets.all(9.sp),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/images/filter.svg",
                              width: 20,
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap.verticalSpace(24),
                    Text(
                      "Recently",
                      style: TextStyles.urbanistLar(
                        context,
                      ),
                    ),
                    Gap.verticalSpace(24),
                    SizedBox(
                      height: 0.11.sh,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.sp),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 60.h,
                                  height: 60.w,
                                  child: Image.asset(
                                    images[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  names[index],
                                  style: TextStyles.urbanistLar(context,
                                      color: const Color(0xff171717),
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Gap.verticalSpace(24),
                    Text(
                      "Messages",
                      style: TextStyles.urbanistLar(
                        context,
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: FutureBuilder(
                  future: getUsersFromFirestore(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // You can replace this with a loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No users found');
                    } else {
                      List<User> userList = snapshot.data!;
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox();
                          },
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              tileColor: Colors.greenAccent,
                              onTap: () {
                                Navigate.to(context, const MessagesScreen());
                              },
                              contentPadding: const EdgeInsets.all(0),
                              // leading: SizedBox(
                              //   child: Image.asset(
                              //     images[index],
                              //     fit: BoxFit.contain,
                              //   ),
                              // ),
                              title: Text(
                                'Person Name ${userList[index].displayName}',
                                style:
                                    TextStyles.urbanist(context, fontSize: 18),
                              ),
                              subtitle: Text(
                                'Message preview $index',
                                style: TextStyles.urbanistMed(
                                  context,
                                  color: const Color(0xff272727),
                                ),
                              ),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (index == 2 || index == 3)
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "3",
                                          style: TextStyles.urbanist(context,
                                              color: Colors.white,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  Text(
                                    '10:00',
                                    style: TextStyles.urbanistMed(
                                      context,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  final String uid;
  final String displayName;
  final String email;

  User({required this.uid, required this.displayName, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] ?? '',
      displayName: json['displayName'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

Future<List<User>> getUsersFromFirestore() async {
  List<User> userList = [];
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      User user = User.fromJson(document.data() as Map<String, dynamic>);
      userList.add(user);
    }
    return userList;
  } catch (error) {
    print(error);
    return [];
  }
}
