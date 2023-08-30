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

class PhotoImageViewController extends GetxController {
  final state = PhotoImageViewState();
  PhotoImageViewController();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;
  


  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    if(data['url'] != null){
      state.url.value = data['url']!;
    }
  }
}
