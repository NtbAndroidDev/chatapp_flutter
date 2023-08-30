import 'package:chatapp/common/entities/entities.dart';
import 'package:chatapp/pages/profile/widget/head_item.dart';
import 'package:chatapp/pages/welcomes/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../common/values/colors.dart';
import '../../common/values/shadows.dart';
import '../../common/widgets/app.dart';
import '../../common/widgets/button.dart';
import 'controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return transparentAppBar(
          title: Text(
        "Profile",
        style: TextStyle(
            color: AppColors.primaryBackground,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600),
      ));
    }

    Widget MeItem(MeListItem item) {
      return Container(
        height: 56.w,
        color: AppColors.primaryBackground,
        margin: EdgeInsets.only(bottom: 1.w),
        padding: EdgeInsets.only(top: 0.w, left: 15.w, right: 15.w),
        child: InkWell(
          onTap: () {
            if(item.route =="/logout") {
              controller.onLogout();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 56.w,
                    child: Image(
                      image: AssetImage(item.icon ?? ""),
                      width: 40.w,
                      height: 40.w,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 14.w),
                    child: Text(
                      item.name??"",
                      style: TextStyle(
                        color: AppColors.thirdElement,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage("assets/icons/ang.png"),
                      width: 15.w,
                      height: 15.w,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() => CustomScrollView(
            slivers: [
              SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
                  sliver: SliverToBoxAdapter(
                    child: controller.state.headDetail.value == null?
                    Container():HeadItem(controller.state.headDetail.value!),
                  ),
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, i) {
                    var item = controller.state.meListItem[i];
                    return MeItem(item);
                  },
                    childCount: controller.state.meListItem.length
                  ),
                ),
              )
            ],
          )),
    );
  }
}
