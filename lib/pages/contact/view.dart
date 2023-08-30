import 'package:chatapp/common/widgets/app.dart';
import 'package:chatapp/pages/contact/widget/contact_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/values/colors.dart';
import 'controller.dart';



class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {


    AppBar _buildAppBar(){
      return transparentAppBar(
        title: Text(
          "Contact",
          style: TextStyle(
            color: AppColors.primaryBackground,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600
          ),
        )
      );
    }

    print(controller.state.contactList.length);

    return Scaffold(
      appBar: _buildAppBar(),
      body: ContactList(),
    );
  }
}
