import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/views/product_screen/product_details.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;

  const CartItemCard({super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    print("Item map: $item"); // Debug print to see the data

    return Card(
      color: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  item["imageUrl"] ?? "",
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: lightGrey,
                      child: Center(
                        child: Icon(Icons.image, color: darkFontGrey),
                      ),
                    );
                  },
                ),
              ),
              if (item["discount"] != null && item["discount"] > 0)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: "${item["discount"]}% OFF".text.white.make(),
                  ),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(Icons.close, color: whiteColor),
                  onPressed: onRemove,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (item["name"] ?? "No name").text
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .make(),
                8.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "\$${item["price"] ?? 0}".text
                        .color(primaryColor)
                        .fontFamily(bold)
                        .make(),
                    if (item["originalPrice"] != null)
                      "\$${item["originalPrice"]}".text
                          .color(fontGrey)
                          .lineThrough
                          .make(),
                  ],
                ),
                8.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Qty: ${item["quantity"] ?? 0}".text.make(),
                    IconButton(
                      icon: Icon(Icons.delete, color: redColor),
                      onPressed: onRemove,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
