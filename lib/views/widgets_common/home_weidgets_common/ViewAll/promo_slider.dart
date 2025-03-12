import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/controllers/home_controller.dart';

import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/ViewAll/round_image.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/circular_container.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key, required this.banner});
  final List<String> banner;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeControllers());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: banner.map((url) => RoundImage(imageUrl: url)).toList(),
        ),
        const SizedBox(height: 16),
        Center(
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < banner.length; i++)
                  CircularContainer(
                    width: 20,
                    height: 4,
                    radius: 2,
                    margine: const EdgeInsets.only(right: 10),
                    backgroundColor:
                        controller.carousalCurrentIndex.value == i
                            ? Colors.blue
                            : Colors.grey,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
