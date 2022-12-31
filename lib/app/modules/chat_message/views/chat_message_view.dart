import 'package:bubble/bubble.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as Types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';

import '../controllers/chat_message_controller.dart';

class ChatMessageView extends GetView<ChatMessageController> {
  const ChatMessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.softGray,
      ),
      body: SafeArea(
        child: Obx(
          () => controller.messages.isNotEmpty
              ? Chat(
                  messages: controller.messages,
                  onSendPressed: controller.handleSendPressed,
                  onAttachmentPressed: controller.handleImageSelection,
                  onMessageTap: controller.handleMessageTap,
                  user: controller.user,
                  bubbleBuilder: _bubbleBuilder,
                  onEndReached: controller.handleEndReached,
                  theme: const DefaultChatTheme(
                      messageInsetsHorizontal: 20.0,
                      messageInsetsVertical: 2.0,
                      messageBorderRadius: 30.0),
                )
              // bug framework getx when rxlist is empty
              : Chat(
                  messages: const [],
                  onSendPressed: controller.handleSendPressed,
                  user: controller.user,
                  emptyState: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Bắt đầu trò chuyện...',
                      style: subtitle1.copyWith(color: AppColors.gray),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) =>
      Bubble(
        color: controller.user.id != message.author.id ||
                message.type == Types.MessageType.image
            ? const Color(0xfff5f5f7)
            : const Color(0xff6f61e8),
        margin: nextMessageInGroup
            ? const BubbleEdges.symmetric(horizontal: 6)
            : null,
        nip: nextMessageInGroup
            ? BubbleNip.no
            : controller.user.id != message.author.id
                ? BubbleNip.leftBottom
                : BubbleNip.rightBottom,
        child: child,
      );
}
