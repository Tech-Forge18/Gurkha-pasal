import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/models/product.dart';
// Updated import
import 'package:gurkha_pasal/views/product_screen/product_details.dart';
import 'package:velocity_x/velocity_x.dart';

class ExclusiveDealCard extends StatelessWidget {
  final Product product;
  final bool isCompact;
  final bool showStockInfo;
  final bool showOriginalPrice;
  final bool hideOriginalPrice;
  final double? discountFontSize;
  final bool isHomeScreen;
  final bool fromExclusiveDeals;

  const ExclusiveDealCard({
    super.key,
    required this.product,
    this.isCompact = false,
    this.showStockInfo = false,
    this.showOriginalPrice = false,
    this.hideOriginalPrice = false,
    this.discountFontSize,
    this.isHomeScreen = false,
    this.fromExclusiveDeals = false, // Default to false
  });

  double _calculateOriginalPrice() {
    if (product.discount == null || product.discount! <= 0) {
      return product.price;
    }
    return product.price / (1 - (product.discount! / 100));
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth =
        isHomeScreen
            ? 124
            : isCompact
            ? 130
            : 160;
    final double cardHeight =
        isHomeScreen
            ? 160
            : isCompact
            ? 160
            : (showStockInfo ? 220 : 200);
    final double imageHeight =
        isHomeScreen
            ? cardHeight * 0.65
            : isCompact
            ? cardHeight * 0.65
            : cardHeight * 0.60;
    final double fontSizeTitle = isCompact ? 10 : 12;
    final double fontSizePrice = isCompact ? 8 : 10;
    final double padding = isCompact ? 4 : 8;
    final double borderRadius = isCompact ? 8 : 12;
    final double discountBadgeFontSize =
        isCompact ? 8 : (discountFontSize ?? 10);

    final originalPrice = _calculateOriginalPrice();
    final hasDiscount = product.discount != null && product.discount! > 0;

    return GestureDetector(
      onTap:
          () => Get.to(
            () => ProductDetailsScreen(
              product: product,
              fromExclusiveDeals: fromExclusiveDeals, // Pass the parameter
            ),
          ),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFDF0E6).withOpacity(0.9),
              const Color(0xFFC7C7C6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: imageHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(borderRadius),
                ),
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: Colors.grey,
                        child: const Center(
                          child: Icon(Icons.error, color: Colors.white),
                        ),
                      ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: padding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: cardWidth - (padding * 2),
                    ),
                    child:
                        product.name.text
                            .color(Colors.black)
                            .fontFamily("semibold")
                            .size(fontSizeTitle)
                            .maxLines(1)
                            .ellipsis
                            .make(),
                  ),
                  if (showStockInfo &&
                      !isHomeScreen &&
                      product.stock != null &&
                      product.stock! > 0)
                    Padding(
                      padding: EdgeInsets.only(top: isCompact ? 2 : 4),
                      child: Row(
                        children: [
                          "Only ${product.stock} left!".text
                              .color(Colors.red)
                              .size(fontSizePrice - 1)
                              .bold
                              .make(),
                          const SizedBox(width: 4),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: product.stock! / 10,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.red,
                              ),
                              minHeight: isCompact ? 3 : 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: isCompact ? 2 : 4),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding,
                      vertical: isCompact ? 2 : 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(isCompact ? 6 : 8),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: isCompact ? 0.5 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child:
                                  "Rs.${product.price.toStringAsFixed(0)}".text
                                      .color(Colors.red)
                                      .bold
                                      .size(
                                        isCompact
                                            ? fontSizePrice
                                            : fontSizePrice + 2,
                                      )
                                      .maxLines(1)
                                      .ellipsis
                                      .make(),
                            ),
                            if (hasDiscount)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isCompact ? 4 : 6,
                                  vertical: isCompact ? 1 : 2,
                                ),
                                margin: EdgeInsets.only(
                                  left: isCompact ? 2 : 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(
                                    isCompact ? 3 : 4,
                                  ),
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: isCompact ? 36 : 48,
                                ),
                                child:
                                    "${product.discount}%".text.white.bold
                                        .size(discountBadgeFontSize)
                                        .maxLines(1)
                                        .ellipsis
                                        .make(),
                              ),
                          ],
                        ),
                        if (!isHomeScreen && hasDiscount && !hideOriginalPrice)
                          Padding(
                            padding: EdgeInsets.only(top: isCompact ? 1 : 2),
                            child:
                                "Rs.${originalPrice.toStringAsFixed(0)}".text
                                    .color(Colors.grey)
                                    .lineThrough
                                    .size(fontSizePrice)
                                    .maxLines(1)
                                    .ellipsis
                                    .make(),
                          ),
                      ],
                    ),
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
