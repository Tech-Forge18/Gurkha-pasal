import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;
  final ValueChanged<bool> onSelect;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onSelect,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            Checkbox(
              value: item["selected"] ?? false,
              onChanged: (value) => onSelect(value ?? false),
              activeColor: redColor,
            ),
            8.widthBox,
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item["imageUrl"] ?? "",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: lightGrey,
                    child: const Center(
                      child: Icon(Icons.image, color: darkFontGrey),
                    ),
                  );
                },
              ),
            ),
            16.widthBox,
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    item["name"] ?? "",
                    style: const TextStyle(
                      color: darkFontGrey,
                      fontFamily: semibold,
                      fontSize: 16,
                    ),
                  ),
                  4.heightBox,
                  // Display selected options
                  if (item["selectedColor"] != null)
                    Text(
                      "Color Family: ${item["selectedColor"]}",
                      style: const TextStyle(color: fontGrey, fontSize: 12),
                    ),
                  8.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (item["originalPrice"] != null)
                            Text(
                              "Rs. ${item["originalPrice"]}",
                              style: const TextStyle(
                                color: fontGrey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                              ),
                            ),
                          8.widthBox,
                          Text(
                            "Rs. ${item["price"]}",
                            style: const TextStyle(
                              color: redColor,
                              fontFamily: bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: darkFontGrey,
                              size: 20,
                            ),
                            onPressed: onDecrease,
                          ),
                          Text(
                            "${item["quantity"]}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: darkFontGrey,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: darkFontGrey,
                              size: 20,
                            ),
                            onPressed: onIncrease,
                          ),
                        ],
                      ),
                    ],
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
