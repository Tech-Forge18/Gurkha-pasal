import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/Categories/vertical_image.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (_, index) {
          return VerticalImageText(image: imgS6, title: 'Shoes', onTap: () {});
        },
      ),
    );
  }
}
