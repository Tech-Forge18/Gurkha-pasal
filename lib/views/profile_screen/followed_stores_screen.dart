import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart' as consts;
import 'package:gurkha_pasal/controllers/followed_stores_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class FollowedStoresScreen extends StatelessWidget {
  const FollowedStoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FollowedStoresController followedStoresController = Get.put(
      FollowedStoresController(),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title:
            "Followed Stores".text
                .fontFamily(consts.bold)
                .size(22)
                .color(consts.darkFontGrey)
                .make(),
        backgroundColor: consts.whiteColor,
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.3),
      ),
      body: Obx(() {
        if (followedStoresController.followedStores.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.storefront, size: 80, color: consts.fontGrey),
              16.heightBox,
              "You haven't followed any stores yet.".text
                  .fontFamily(consts.semibold)
                  .size(18)
                  .color(consts.darkFontGrey)
                  .make(),
              16.heightBox,
              "Follow stores to get updates on new products!".text
                  .fontFamily(consts.regular)
                  .size(14)
                  .color(consts.fontGrey)
                  .make(),
            ],
          ).centered();
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: followedStoresController.followedStores.length,
          itemBuilder: (context, index) {
            final store = followedStoresController.followedStores[index];
            return Card(
              color: consts.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        store.logoUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: consts.lightGrey,
                            child: const Center(
                              child: Icon(
                                Icons.store,
                                color: consts.darkFontGrey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    12.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          store.name.text
                              .fontFamily(consts.semibold)
                              .size(16)
                              .color(consts.darkFontGrey)
                              .make(),
                          4.heightBox,
                          "${store.followers} Followers".text
                              .fontFamily(consts.regular)
                              .size(14)
                              .color(consts.fontGrey)
                              .make(),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        followedStoresController.unfollowStore(index);
                      },
                      child:
                          "Unfollow".text
                              .fontFamily(consts.semibold)
                              .size(14)
                              .color(consts.redColor)
                              .make(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
