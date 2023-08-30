import 'dart:ffi';

import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/common/routes/routes.dart';
import 'package:chatapp/common/store/store.dart';
import 'package:chatapp/common/widgets/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gson/gson.dart';
import 'package:logger/logger.dart';
import 'index.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
  'openid',
]);

class SignInController extends GetxController {
  final state = SignInState();

  SignInController();

  final db = FirebaseFirestore.instance;

  Future<void> handleSignIn() async {
    try {
      var user = await _googleSignIn.signIn();
      // logger.d("hahahah", error: Gson().encode(user));

      if (user != null) {
        final _gauthentication = await user.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _gauthentication.idToken,
            accessToken: _gauthentication.accessToken);

        await FirebaseAuth.instance.signInWithCredential(_credential);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String url = user.photoUrl ?? "";

        UserLoginResponseEntity userProfile = UserLoginResponseEntity();

        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.photoUrl = url;
        userProfile.displayName = displayName;

        UserStore.to.saveProfile(userProfile);

        var userBase = await db
            .collection("users")
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, options) =>
                  userData.toFirestore(),
            )
            .where("id", isEqualTo: id)
            .get();

        if (userBase.docs.isEmpty) {
          final data = UserData(
              id: id,
              name: displayName,
              email: email,
              photourl: url,
              location: "",
              fcmtoken: "",
              addtime: Timestamp.now());

          await db
              .collection("users")
              .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userData, options) =>
                    userData.toFirestore(),
              )
              .add(data);
        }
        toastInfo(msg: "Login success");
        Get.offAndToNamed(AppRoutes.Application);
      }
    } catch (e) {
      toastInfo(msg: "Login error");
      print("hahahaha");
      print(e);
    }
  }

  @override
  void onReady() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("User is currently logged out");
      } else {
        print("User is logged in");
      }
    });

    super.onReady();
  }
}
