import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/controllers/product_controller.dart';
import 'package:gurkha_pasal/views/widgets_common/exclusive_product_card.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';

class ExclusiveDealsScreen extends StatelessWidget {
  const ExclusiveDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title:
            "Exclusive Deals".text
                .color(const Color.fromARGB(255, 236, 234, 234))
                .make(),
        backgroundColor: const Color.fromRGBO(239, 104, 8, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(255, 12, 12, 12),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: controller.exclusiveDeals.length,
          itemBuilder: (context, index) {
            return ExclusiveDealCard(product: controller.exclusiveDeals[index]);
          },
        ),
      ),
    );
  }
}
