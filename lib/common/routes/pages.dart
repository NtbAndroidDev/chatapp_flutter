
import 'package:chatapp/common/middlewares/middlewares.dart';
import 'package:chatapp/pages/message/photoview/index.dart';
import 'package:chatapp/pages/profile/bindings.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';



import '../../pages/application/bindings.dart';
import '../../pages/application/view.dart';
import '../../pages/contact/bindings.dart';
import '../../pages/contact/view.dart';
import '../../pages/message/bindings.dart';
import '../../pages/message/chat/bindings.dart';
import '../../pages/message/chat/view.dart';
import '../../pages/message/view.dart';
import '../../pages/profile/view.dart';
import '../../pages/sign_in/index.dart';
import '../../pages/welcomes/index.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const APPlication = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1)
      ]
    ),

    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        // RouteAuthMiddleware(priority: 1),
      ],
    ),


    // 最新路由
    // 首页
    GetPage(name: AppRoutes.Contact, page: () => const ContactPage(), binding: ContactBinding()),

    GetPage(name: AppRoutes.Chat, page: () => const ChatPage(), binding: ChatBinding()),

    //消息
    GetPage(name: AppRoutes.Message, page: () => MessagePage(), binding: MessageBinding()),
    GetPage(name: AppRoutes.Photoimgview, page: () => const PhotoImageViewPage(), binding: PhotoImageViewBinding()),
    GetPage(name: AppRoutes.Me, page: () => const ProfilePage(), binding: ProfileBinding()),
    /*

    //我的
    GetPage(name: AppRoutes.Me, page: () => MePage(), binding: MeBinding()),
    //聊天详情

   ,*/
  ];






}
