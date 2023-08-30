import 'dart:io';

import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/store/store.dart';
import 'package:chatapp/common/utils/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'index.dart';
import 'dart:math';
import 'dart:convert';

class MessageController extends GetxController {
  final state = MessageState();
  MessageController();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;


  final RefreshController refreshController =  RefreshController(
        initialRefresh: true
      );



  @override
  void onReady() {
    super.onReady();
    getUserLocation();
    getFCMToken();
  }

  void onRefresh(){
    asyncLoadAllData().then((_){
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_){
      refreshController.refreshFailed();
    });
  }

  void onLoading(){
    asyncLoadAllData().then((_){
      refreshController.loadComplete();
    }).catchError((_){
      refreshController.loadFailed();
    });
  }

  asyncLoadAllData() async {
    var fromMessage = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore()
    ).where(
      "from_uid", isEqualTo: token
    ).get();

    var toMessage = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore()
    ).where(
        "to_uid", isEqualTo: token
    ).get();


    state.msgList.clear();

    if(fromMessage.docs.isNotEmpty){
      state.msgList.assignAll(fromMessage.docs);
    }

    if(toMessage.docs.isNotEmpty){
      state.msgList.assignAll(toMessage.docs);
    }


  }

  getUserLocation() async {
    try{
      final location = await Location().getLocation();
      String address = "${location.latitude}, ${location.longitude}";
      String url = "https://maps.googleapis.com/maps/api/geocode/json?address=${address}&key=AIzaSyCMESvjp3G5FtPnukZ28_GVOuFSvEhSS9c";
      var response = await HttpUtil().get(url);
      MyLocation locationRes = MyLocation.fromJson(response);
      if(locationRes.status == "OK"){
        String? myAddress = locationRes.results?.first.formattedAddress;
        if(myAddress != null){
          var userLocation = await db.collection("users").where("id", isEqualTo: token).get();
          if(userLocation.docs.isNotEmpty){
            var docId = userLocation.docs.first.id;
            await db.collection("users").doc(docId).update({"location": myAddress});
          }
        }
      }
    }catch(e){
      print("Getting error $e");
    }

  }
  getFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if(fcmToken != null){
      var user = await db.collection("users").where("id", isEqualTo: token).get();
      if(user.docs.isNotEmpty){
        var docId = user.docs.first.id;
        await db.collection("users").doc(docId).update({"fcmtoken":fcmToken});
      }
    }
  }
}
