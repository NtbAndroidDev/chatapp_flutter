import 'package:get/get.dart';

import 'index.dart';

class ContactBinding implements Bindings{
  @override
  void dependencies() {

    Get.lazyPut<ContactController>(() => ContactController());

  }

}