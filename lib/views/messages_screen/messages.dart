import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/controllers/message_controller.dart';
import 'package:gurkha_pasal/views/widgets_common/message_card.dart';
import 'package:velocity_x/velocity_x.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageController messageController = Get.put(MessageController());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: "Messages".text.fontFamily(bold).color(darkFontGrey).make(),
        backgroundColor: whiteColor,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              messageController.markAllAsRead();
            },
            child: "Mark all as read".text.color(redColor).make(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tabs
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _buildTab(
                    "Chats",
                    messageController.selectedTab.value == "Chats",
                    () {
                      messageController.changeTab("Chats");
                    },
                  ),
                  8.widthBox,
                  _buildTab(
                    "Orders",
                    messageController.selectedTab.value == "Orders",
                    () {
                      messageController.changeTab("Orders");
                    },
                  ),
                  8.widthBox,
                  _buildTab(
                    "Activities",
                    messageController.selectedTab.value == "Activities",
                    () {
                      messageController.changeTab("Activities");
                    },
                  ),
                  8.widthBox,
                  _buildTab(
                    "Promos",
                    messageController.selectedTab.value == "Promos",
                    () {
                      messageController.changeTab("Promos");
                    },
                  ),
                ],
              ),
            ),
          ),
          // Messages List
          Expanded(
            child: Obx(() {
              final messages = messageController.getMessagesForTab();
              if (messages.isEmpty) {
                return "No messages available".text
                    .color(fontGrey)
                    .make()
                    .centered();
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0 ||
                          messages[index].timestamp !=
                              messages[index - 1].timestamp)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: message.timestamp.text.color(fontGrey).make(),
                        ),
                      MessageCard(message: message),
                      8.heightBox,
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? redColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child:
            title.text
                .color(isSelected ? whiteColor : darkFontGrey)
                .fontFamily(semibold)
                .make(),
      ),
    );
  }
}
