import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart' as consts;
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final TextEditingController nameController = TextEditingController(
      text: user?.displayName ?? '',
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title:
            "Edit Profile".text
                .fontFamily(consts.bold)
                .size(22)
                .color(consts.darkFontGrey)
                .make(),
        backgroundColor: consts.whiteColor,
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Update your profile details below.".text
                .fontFamily(consts.regular)
                .size(16)
                .color(consts.darkFontGrey)
                .make(),
            24.heightBox,
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: const TextStyle(color: consts.fontGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: consts.lightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: consts.primaryColor),
                ),
                filled: true,
                fillColor: consts.whiteColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            16.heightBox,
            ourButton(
              color: consts.primaryColor,
              title: "Save Changes",
              textColor: consts.whiteColor,
              onPress: () async {
                if (nameController.text.isNotEmpty) {
                  try {
                    await user?.updateDisplayName(nameController.text);
                    Get.back();
                    Get.snackbar(
                      "Success",
                      "Profile updated successfully!",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: consts.greenColor,
                      colorText: consts.whiteColor,
                    );
                  } catch (e) {
                    Get.snackbar(
                      "Error",
                      "Failed to update profile: $e",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: consts.redColor,
                      colorText: consts.whiteColor,
                    );
                  }
                } else {
                  Get.snackbar(
                    "Error",
                    "Name cannot be empty.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: consts.redColor,
                    colorText: consts.whiteColor,
                  );
                }
              },
            ).box.width(double.infinity).make(),
          ],
        ),
      ),
    );
  }
}
