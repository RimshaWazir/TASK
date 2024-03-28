import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy/Data/DataSource/Resources/assets.dart';
import 'package:dummy/Data/DataSource/Resources/textstyle.dart';
import 'package:dummy/Presentation/Commons/bottom_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../api/apis.dart';
import '../models/chat_user.dart';
import '../widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> _list = [];
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<ChatUser> _searchList = [];
  final bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    firestore.collection('users').snapshots().listen((snapshot) {
      setState(() {
        _list = snapshot.docs
            .map((doc) => ChatUser.fromJson(doc.data()))
            .where((user) => user.id != APIs.user.uid)
            .toList();
      });
    });

    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 241, 241),
        body: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: const Color.fromARGB(255, 243, 241, 241),
                titleSpacing: 12,
                expandedHeight: 80,
                floating: false,
                pinned: true,
                stretch: true,
                title: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        fillColor: Colors.white,
                        prefix: const Icon(CupertinoIcons.search),
                        suffix: SvgPicture.asset(
                          "assets/images/filter.svg",
                          height: 24,
                          width: 24,
                        ),
                        border: InputBorder.none,
                        hintText: 'Search...'),
                    autofocus: true,
                    style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                    onChanged: (val) {
                      _searchList.clear();

                      for (var i in _list) {
                        if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                            i.email.toLowerCase().contains(val.toLowerCase())) {
                          _searchList.add(i);
                          setState(() {
                            _searchList;
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _list.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Recently",
                                  style: MyTextStyles.urbanist20(context),
                                ),
                                SizedBox(
                                  height: 90,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          CircleAvatar(
                                            minRadius: 28,
                                            backgroundImage: NetworkImage(
                                                _list[index].image),
                                          ),
                                          Text(
                                            _list[index].name,
                                            style: MyTextStyles.urbanist14(
                                                context),
                                          )
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                            width:
                                                10), // Adjust the width as needed
                                    itemCount: _list.length,
                                  ),
                                ),
                                Text(
                                  "Messages",
                                  style: MyTextStyles.urbanist20(context),
                                ),
                                ChatUserCard(
                                  user: _isSearching
                                      ? _searchList[index]
                                      : _list[index],
                                ),
                              ],
                            ),
                          );
                  },
                  childCount: _isSearching ? _searchList.length : _list.length,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.amber,
          height: 130,
          width: double.infinity,
          child: Row(
            children: [
              BottomIcon(
                  state: null, ontap: () {}, image: Assets.home, text: "Home"),
              BottomIcon(
                  state: null, ontap: () {}, image: Assets.home, text: "Home"),
              BottomIcon(
                  state: null, ontap: () {}, image: Assets.home, text: "Home"),
              BottomIcon(
                  state: null, ontap: () {}, image: Assets.home, text: "Home"),
              BottomIcon(
                  state: null, ontap: () {}, image: Assets.home, text: "Home"),
            ],
          ),
        ),
      ),
    );
  }
}
