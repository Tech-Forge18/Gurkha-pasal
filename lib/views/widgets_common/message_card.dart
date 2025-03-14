import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:gurkha_pasal/controllers/message_controller.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 212, 211, 211),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: redColor.withOpacity(0.1),
          child: Icon(
            message.type == "Chats"
                ? Icons.person
                : message.type == "Orders"
                ? Icons.local_shipping
                : message.type == "Promos"
                ? Icons.local_offer
                : Icons.notifications,
            color: redColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            message.title.text
                .fontFamily(semibold)
                .color(const Color.fromARGB(255, 14, 13, 13))
                .size(16)
                .make(),
            if (!message.isRead)
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: redColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle:
            message.subtitle.text
                .color(const Color.fromARGB(255, 36, 35, 35))
                .size(14)
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .make(),
        onTap: () {
          // Handle message tap (e.g., navigate to chat or details screen)
          Get.snackbar("Message", "Tapped on ${message.title}");
        },
      ),
    );
  }
}
