import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/common/widgets/app.dart';
import 'package:chatapp/pages/message/chat/widgets/message_list.dart';
import 'package:chatapp/pages/welcomes/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';


import '../../../common/values/colors.dart';
import 'controller.dart';



class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {


    AppBar _buildAppBar(){
      return transparentAppBar(
        title: Text("Message",
            style: TextStyle(
            color: AppColors.primaryBackground,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600

        ),
        )

      );
    }


    return Scaffold(
      appBar: _buildAppBar(),
      body: MessageList(),
    );
  }
}
