
import 'dart:convert';

import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/routes/names.dart';
import 'package:chatapp/common/store/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'index.dart';

class ProfileController extends GetxController {
  final state = ProfileState();

  ProfileController();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String> [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly'
  ]);

  asyncLoadAllData() async {
    String profile = await UserStore.to.getProfile();
    if(profile.isNotEmpty){
      UserLoginResponseEntity userData = UserLoginResponseEntity.fromJson(jsonDecode(profile));
      state.headDetail.value = userData;
    }
  }

  @override
  void onInit() {
    super.onInit();
    asyncLoadAllData();

    List myList = [
      {"name":"Account", "icon": "assets/icons/1.png", "route": "/account"},
      {"name":"Chat", "icon": "assets/icons/2.png", "route": "/chat"},
      {"name":"Notification", "icon": "assets/icons/3.png", "route": "/notification"},
      {"name":"Privacy", "icon": "assets/icons/4.png", "route": "/privacy"},
      {"name":"Help", "icon": "assets/icons/5.png", "route": "/help"},
      {"name":"About", "icon": "assets/icons/6.png", "route": "/about"},
      {"name":"Logout", "icon": "assets/icons/7.png", "route": "/logout"}
    ];

    for(int i = 0; i < myList.length; i++){
      MeListItem result = MeListItem();
      result.icon = myList[i]["icon"];
      result.name = myList[i]["name"];
      result.route = myList[i]["route"];
      state.meListItem.add(result);
    }

  }

  Future<void> onLogout()async {
    UserStore.to.onLogout();
    await _googleSignIn.signOut();
    Get.offAndToNamed(AppRoutes.SIGN_IN);
  }
}
