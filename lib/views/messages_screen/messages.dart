import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/controllers/message_controller.dart';
import 'package:gurkha_pasal/views/widgets_common/message_card.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageController messageController = Get.put(MessageController());

    return Scaffold(
      backgroundColor: bgColor, // Light background for the screen
      appBar: AppBar(
        title:
            "Messages".text
                .fontFamily(bold)
                .color(const Color.fromARGB(255, 3, 3, 3))
                .size(20)
                .make(),
        backgroundColor: whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 65, 63, 63),
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 56, 55, 55),
            ),
            onPressed: () {
              // Implement search functionality if needed
              Get.snackbar("Search", "Search functionality coming soon!");
            },
          ),
          TextButton(
            onPressed: () {
              messageController.markAllAsRead();
            },
            child:
                "Mark all as read".text
                    .color(redColor)
                    .fontFamily(semibold)
                    .make(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tabs Section
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color.fromARGB(
                255,
                37,
                37,
                37,
              ), // White background for tabs section
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTab(
                      "Chats",
                      messageController.selectedTab.value == "Chats",
                      () => messageController.changeTab("Chats"),
                    ),
                    8.widthBox,
                    _buildTab(
                      "Orders",
                      messageController.selectedTab.value == "Orders",
                      () => messageController.changeTab("Orders"),
                    ),
                    8.widthBox,
                    _buildTab(
                      "Activities",
                      messageController.selectedTab.value == "Activities",
                      () => messageController.changeTab("Activities"),
                    ),
                    8.widthBox,
                    _buildTab(
                      "Promos",
                      messageController.selectedTab.value == "Promos",
                      () => messageController.changeTab("Promos"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Messages List
          Expanded(
            child: Obx(() {
              final messages = messageController.getMessagesForTab();
              if (messages.isEmpty) {}
              return Container(
                color: whiteColor, // White background for messages list
                child: ListView.builder(
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
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child:
                                message.timestamp.text
                                    .color(fontGrey)
                                    .fontFamily(semibold)
                                    .size(12)
                                    .make()
                                    .centered(),
                          ),
                        MessageCard(message: message),
                        12.heightBox,
                      ],
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Redesigned Tab Widget
  Widget _buildTab(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? redColor : whiteColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: redColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : [
                    BoxShadow(
                      color: darkFontGrey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
        ),
        child:
            title.text
                .color(isSelected ? whiteColor : darkFontGrey)
                .fontFamily(semibold)
                .size(14)
                .make(),
      ),
    );
  }

  // Redesigned Empty State
}
