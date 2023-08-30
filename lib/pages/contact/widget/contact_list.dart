import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/common/entities/entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import '../controller.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});
  Widget BuildListItem(UserData item){
    return Container(
      padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w),
      child: InkWell(
        onTap: (){
          if(item.id != null){
            controller.goChat(item);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 15.w),
              child: SizedBox(
                width: 54.w,
                height: 54.h,
                child: CachedNetworkImage(imageUrl: "${item.photourl}",),
              ),
            ),
            Container(
              width: 250.w,
              padding: EdgeInsets.only(top: 15.w, left: 0.w, right: 0.w, bottom: 0.w),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xff35efe5))
                  )
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 200.w,
                    height: 42.w,
                    child: Text(
                      item.name??"",
                      style: TextStyle(
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.bold,
                          color: AppColors.thirdElement,
                          fontSize: 16
                      ),
                    ),
                  )
                ],
              ),

            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    return Obx(() => CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.h),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, i){
                  var item = controller.state.contactList[i];
                  return BuildListItem(item);
                },
                childCount: controller.state.contactList.length
            ),
          ),
        )
      ],
    ));
  }
}
