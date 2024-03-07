import 'dart:developer';

import 'package:dummy/Application/Services/ApiServices/Apis.dart';
import 'package:dummy/Data/DataSource/Resources/assets.dart';
import 'package:dummy/Data/DataSource/Resources/strings.dart';
import 'package:dummy/Domain/Model/chat_user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../States/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardCubitState> {
  FirebaseAuth auth = FirebaseAuth.instance;

  DashboardCubit(this.auth) : super(DashboardCubitInitial()) {
    loadUserList();
    initSystemChannels();
  }

  void loadUserList() {
    log("loadUserList");
    try {
      APIs().getAllUsers().listen((snapshot) {
        final List<ChatUser> userList = snapshot.docs
            .map((doc) => ChatUser.fromJson(doc.data()))
            .where((user) => user.id != auth.currentUser!.uid)
            .toList();
        log(userList.toString());
        emit(DashboardCubitLoaded(user: userList));
      });
    } catch (e, stackTrace) {
      log("Error loading user list: $e\n$stackTrace");

      emit(DashboardCubitError(errorMessage: "Error loading user list"));
    }
  }

  final List<String> names = [
    AppStrings.taif,
    AppStrings.nisma,
    AppStrings.kamal,
    AppStrings.sana,
    AppStrings.rehman,
    AppStrings.rimsha,
    AppStrings.ayesha,
  ];

  final List<String> images = const [
    Assets.avatar1,
    Assets.avatar2,
    Assets.avatar3,
    Assets.avatar4,
    Assets.avatar5,
    Assets.avatar6,
    Assets.avatar7,
  ];
  void initSystemChannels() {
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (auth.currentUser != null) {
        if (message.toString().contains(AppStrings.resumed)) {
          APIs.updateActiveStatus(true);
        } else if ((message.toString().contains(AppStrings.inactive))) {
          APIs.updateActiveStatus(false);
        } else if ((message.toString().contains(AppStrings.hidden))) {
          APIs.updateActiveStatus(false);
        } else if ((message.toString().contains(AppStrings.paused))) {
          APIs.updateActiveStatus(false);
        } else if ((message.toString().contains(AppStrings.detached))) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }
}
