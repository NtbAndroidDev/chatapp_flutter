import 'package:get/get.dart';

import 'index.dart';

class MessageBinding implements Bindings{
  @override
  void dependencies() {

    Get.lazyPut<MessageController>(() => MessageController());

  }

}