import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/circular_container.dart';


class BrandCards extends StatelessWidget {
  const BrandCards({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.image,
    required this.brandname,
    required this.productCount,
  });

  final bool showBorder;
  final void Function()? onTap;
  final String image;
  final String brandname;
  final int productCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircularContainer(
        showBorder: showBorder,
        radius: 10,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Brand Logo Image
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Brand Details
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brandname,
                    style: const TextStyle(fontFamily: semibold),
                  ),
                  Text(
                    '$productCount Products',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: regular, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
