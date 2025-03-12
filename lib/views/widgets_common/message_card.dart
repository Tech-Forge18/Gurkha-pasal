import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/models/message.dart';
import 'package:velocity_x/velocity_x.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                message.imageUrl,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 80,
                    color: lightGrey,
                    child: const Icon(Icons.image, color: darkFontGrey),
                  );
                },
              ),
            ),
            16.widthBox,
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.tag != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:
                          message.tag!.text.color(whiteColor).size(12).make(),
                    ),
                  4.heightBox,
                  message.title.text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .size(16)
                      .make(),
                  4.heightBox,
                  message.description.text.color(fontGrey).size(14).make(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
