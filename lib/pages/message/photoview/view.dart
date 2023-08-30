import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/common/widgets/app.dart';
import 'package:chatapp/pages/welcomes/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:photo_view/photo_view.dart';


import '../../../common/values/colors.dart';
import 'controller.dart';



class PhotoImageViewPage extends GetView<PhotoImageViewController> {
  const PhotoImageViewPage({super.key});

  @override
  Widget build(BuildContext context) {


    AppBar _buildAppBar(){
      return AppBar(
        bottom: PreferredSize(
          child: Container(
            color: AppColors.secondaryElement,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
        title: Text("PhotoImageView",
            style: TextStyle(
            color: AppColors.primaryText,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal

        ),
        )

      );
    }


    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(controller.state.url.value),
        ),
      ),
    );
  }
}
