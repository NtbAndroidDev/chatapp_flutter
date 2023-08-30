import 'package:chatapp/pages/message/chat/controller.dart';
import 'package:chatapp/pages/message/chat/widgets/chat_left_item.dart';
import 'package:chatapp/pages/message/chat/widgets/chat_right_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/values/colors.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      color: AppColors.chatbg,
      padding: EdgeInsets.only(bottom: 50.h),
      child: CustomScrollView(
        reverse: true,
        controller: controller.msgScrolling,
        slivers: [
          SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                        (context, i){
                      var item = controller.state.msgContentList[i];
                      if(controller.userId == item.uid){
                        return ChatRightItem(item);
                      }
                      return ChatLeftItem(item);
                    },
                  childCount: controller.state.msgContentList.length
                ),
              )
          )
        ],
      ),
    ));
  }
}
