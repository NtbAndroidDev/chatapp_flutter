import 'dart:convert';
import 'dart:ffi';

import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/routes/routes.dart';
import 'package:chatapp/common/store/store.dart';
import 'package:chatapp/common/widgets/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gson/gson.dart';
import 'package:logger/logger.dart';
import '../../common/values/colors.dart';
import 'index.dart';

class ContactController extends GetxController {
  final ContactState state = ContactState();

  ContactController();

  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  goChat(UserData toUserData) async {
    var fromMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: token)
        .where("to_uid", isEqualTo: toUserData.id)
        .get();

    var toMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: toUserData.id)
        .where("to_uid", isEqualTo: token)
        .get();

    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity userData =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));
      var msgData = Msg(
          from_uid: userData.accessToken,
          to_uid: toUserData.id,
          from_name: userData.displayName,
          to_name: toUserData.name,
          to_avatar: toUserData.photourl,
          last_msg: "",
          last_time: Timestamp.now(),
          msg_num: 0);
      db.collection("message")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .add(msgData)
          .then((value) {
        Get.toNamed("/chat", parameters: {
          "doc_id": value.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? ""
        });
      });
    } else {
      if (fromMessages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": fromMessages.docs.first.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? ""
        });
      }

      if (toMessages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": toMessages.docs.first.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? ""
        });
      }
    }
  }

  asyncLoadAllData() async {
    var userBase = await db
        .collection("users")
        .where("id", isNotEqualTo: token)
        .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userdata, options) => userdata.toFirestore())
        .get();

    for (var doc in userBase.docs) {
      state.contactList.add(doc.data());

      print(doc.toString());
    }
  }
}
