import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Application/Services/Navigation/navigation.dart';
import 'package:dummy/Data/DataSource/Resources/sized_box.dart';
import 'package:dummy/Data/DataSource/Resources/text_styles.dart';

import 'package:dummy/Presentation/Widgets/Messages/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

FirebaseAuth auth = FirebaseAuth.instance;

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
    // getUsersFromFirestore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(auth.toString());
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
                      height: 0.16.sh,
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
                                Gap.verticalSpace(5),
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
                    Text(
                      "Messages",
                      style: TextStyles.urbanistLar(
                        context,
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No users found'));
                    } else {
                      return ListView(
                        children: snapshot.data!.docs
                            .map<Widget>((doc) => buildUserListItem(doc))
                            .toList(),
                      );
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

  Widget buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> userData = document.data() as Map<String, dynamic>;

    // Check if the current user is not the same as the user in the list
    if (auth.currentUser!.email != userData['email']) {
      // Access the last message data from the Firestore collection
      FirebaseFirestore.instance
          .collection('messages')
          .doc('your_document_id')
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot lastMessage = querySnapshot.docs.first;

          Map<String, dynamic> lastMessageData =
              lastMessage.data() as Map<String, dynamic>;

          // Create a ListTile widget to display user information and last message
          return Expanded(
              child: ListTile(
            onTap: () {
              Navigate.to(
                context,
                MessagesScreen(
                  name: userData["displayName"],
                  uuid: userData["uuid"],
                ),
              );
            },
            contentPadding: const EdgeInsets.all(0),
            leading: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.network(
                  userData['photoURL'],
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            title: Text(
              userData['displayName'],
              style: TextStyles.urbanist(context, fontSize: 18),
            ),
            subtitle: Text(
              lastMessageData['message'], // Display last message
              style: TextStyles.urbanistMed(
                context,
                color: const Color(0xff272727),
              ),
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Optionally, you can display message timestamp here
                Text(
                  lastMessageData['timestamp'],
                  style: TextStyles.urbanistMed(context),
                ),
              ],
            ),
          ));
        } else {
          return const Center(child: Text("no data "));
        }
      });
    }
    return const Center(child: Text("no data found  "));
  }
}
