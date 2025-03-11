import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _reviewController = TextEditingController();
  final List<Map<String, String>> _reviews = [];

  void _submitReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        _reviews.add({
          "user": "Current User",
          "comment": _reviewController.text,
        });
      });
      _reviewController.clear();
      Get.back();
      Get.snackbar(
        "Success",
        "Review submitted successfully!",
        backgroundColor: greenColor,
        colorText: whiteColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Write a Review".text.white.make(),
        backgroundColor: redColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Review Form
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your review...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: whiteColor,
              ),
            ),
            16.heightBox,
            ourButton(
              color: primaryColor,
              title: "Submit Review",
              textColor: whiteColor,
              onPress: _submitReview,
              icon: const Icon(Icons.send, color: whiteColor),
            ),

            // Existing Reviews
            24.heightBox,
            "Existing Reviews".text.fontFamily(semibold).size(16).make(),
            Expanded(
              child: ListView.builder(
                itemCount: _reviews.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: lightGolden,
                      child: Text("U", style: TextStyle(color: whiteColor)),
                    ),
                    title: _reviews[index]["user"]!.text.make(),
                    subtitle: _reviews[index]["comment"]!.text.make(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
