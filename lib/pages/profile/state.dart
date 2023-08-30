import 'package:chatapp/common/entities/entities.dart';
import 'package:get/get.dart';

class ProfileState{


  var headDetail = Rx<UserLoginResponseEntity?>(null);
  RxList<MeListItem> meListItem = <MeListItem>[].obs;
}