import 'package:chatapp/pages/contact/controller.dart';
import 'package:chatapp/pages/message/controller.dart';
import 'package:get/get.dart';

import '../profile/controller.dart';
import 'index.dart';

class ApplicationBinding implements Bindings{
  @override
  void dependencies() {

    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<MessageController>(() => MessageController());
    Get.lazyPut<ProfileController>(() => ProfileController());

  }

}