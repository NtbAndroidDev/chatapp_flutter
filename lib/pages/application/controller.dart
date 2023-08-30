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


class ApplicationController extends GetxController {
  final state = ApplicationState();

  ApplicationController();

  late final List<String> tabTitle;

  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  void handlePageChanged(int i){
    state.page = i;

  }

  void handleNavBarTap(int i){
    pageController.jumpToPage(i);
  }


  @override
  void onInit() {
    super.onInit();
    tabTitle = ['Chat', 'Contact', 'Profile'];
    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(Icons.message,
            color: AppColors.thirdElementText,
          ),
        activeIcon: Icon(Icons.message,
          color: AppColors.secondaryElementText,
        ),
        label: 'Chats',
        backgroundColor: AppColors.primaryBackground
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.contact_page,
            color: AppColors.thirdElementText,
          ),
          activeIcon: Icon(Icons.contact_page,
            color: AppColors.secondaryElementText,
          ),
          label: 'Contact',
          backgroundColor: AppColors.primaryBackground
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person,
            color: AppColors.thirdElementText,
          ),
          activeIcon: Icon(Icons.person,
            color: AppColors.secondaryElementText,
          ),
          label: 'Profile',
          backgroundColor: AppColors.primaryBackground
      )
    ];
    pageController = PageController(initialPage: state.page);
  }


  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
 
}
