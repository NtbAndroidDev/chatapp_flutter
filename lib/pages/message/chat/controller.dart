import 'dart:io';

import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/store/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/utils/security.dart';
import 'index.dart';
import 'dart:math';
import 'dart:convert';

class ChatController extends GetxController {
  final state = ChatState();

  ChatController();

  var docId;
  final textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final userId = UserStore.to.token;
  final db = FirebaseFirestore.instance;

  var listener;
  File? _photo;
  final ImagePicker _picker = ImagePicker();


  Future imageFromGallery() async {
    final pickerFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickerFile != null){
      _photo =  File(pickerFile.path);
      uploadFile();

    }
  }

  Future getImgUrl(String name) async {
    final spaceRef = FirebaseStorage.instance.ref("image").child(name);
    var str = await spaceRef.getDownloadURL();
    return str??"";
  }

  Future uploadFile() async{
    if(_photo == null) return;
    final fileName = getRandomString(15) + extension(_photo!.path);

    try{
      final ref = FirebaseStorage.instance.ref("image").child(fileName);
      await ref.putFile(_photo!).snapshotEvents.listen((event) async{
        switch(event.state){
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String imgUrl = await getImgUrl(fileName);
            sendImgMessage(imgUrl);
            break;
          default:
        }

      });
    }catch(e){
      print("There's an error $e");
    }

  }
  String extension(String filePath) {
    int dotIndex = filePath.lastIndexOf('.');
    if (dotIndex != -1 && dotIndex < filePath.length - 1) {
      return filePath.substring(dotIndex); // Trả về phần mở rộng của tệp
    }
    return ''; // Không tìm thấy phần mở rộng hoặc không hợp lệ
  }
  //
  // String getRandomString(int length) {
  //   final random = Random();
  //   const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  //   return String.fromCharCodes(
  //     List.generate(length, (index) => chars.codeUnitAt(random.nextInt(chars.length))),
  //   );
  // }

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    docId = data['doc_id'];
    state.toUId.value = data['to_uid'] ?? "";
    state.toName.value = data['to_name'] ?? "";
    state.toAvatar.value = data['to_avatar'] ?? "";
  }


  sendMessage() async {
    String sendContent = textController.text;
    final content = Msgcontent(
      uid: userId,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
    );

    await db.collection("message").doc(docId).collection("msglist").withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msgContent, options) => msgContent.toFirestore()
    ).add(content).then((DocumentReference doc){
      print("Document snapshot added with id, ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });

    await db.collection("message").doc(docId).update({
      "last_msg": sendContent,
      "last_time": Timestamp.now()
    });
  }

  sendImgMessage(String url) async {
    final content = Msgcontent(
      uid: userId,
      content: url,
      type: "image",
      addtime: Timestamp.now()
    );

    await db.collection("message").doc(docId).collection("msglist").withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msgContent, options) => msgContent.toFirestore()
    ).add(content).then((DocumentReference doc){
      print("Document snapshot added with id, ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });

    await db.collection("message").doc(docId).update({
      "last_msg": "[Image]",
      "last_time": Timestamp.now()
    });
  }

  @override
  void onReady() {
    super.onReady();
    var messages = db.collection("message").doc(docId).collection("msglist").withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msgContent, options) => msgContent.toFirestore()
    ).orderBy("addtime", descending: false);
    state.msgContentList.clear();
    listener = messages.snapshots().listen((event) {
      for(var change in event.docChanges){
        switch(change.type){
          case DocumentChangeType.added:
            if(change.doc.data() != null){
              state.msgContentList.insert(0, change.doc.data()!);
            }
            break;
          case DocumentChangeType.modified:
            break;

          case DocumentChangeType.removed:
            break;

        }
      }
    },
    onError: (error) => print("Listen failed: $error")

    );
    getLocation();
  }

  getLocation() async {
    try{
      var userLocation = await db.collection("users").where("id", isEqualTo: state.toUId.value).withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore()
      ).get();
      var location = userLocation.docs.first.data().location;
      if(location != ""){
        print("my_location $location");
        state.toLocation.value = location??"unknown";
      }
    }catch(e){
      print("We have error $e");
    }
  }

  @override
  void dispose(){
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }
}
