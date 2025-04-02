import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart' as consts;
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/controllers/cart_controller.dart';
import 'package:gurkha_pasal/controllers/wishlist_controller.dart';
import 'package:gurkha_pasal/models/product.dart';
import 'package:gurkha_pasal/views/cart_screen/cart.dart';
import 'package:gurkha_pasal/views/review_screen/user_review.dart';
import 'package:gurkha_pasal/views/widgets_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  final bool fromExclusiveDeals;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.fromExclusiveDeals = false,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showTabBar = false;
  double _lastOffset = 0.0;

  final GlobalKey _overviewKey = GlobalKey();
  final GlobalKey _ratingsKey = GlobalKey();
  final GlobalKey _detailsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Scroll listener to show/hide TabBar based on scroll direction
    _scrollController.addListener(() {
      double currentOffset = _scrollController.offset;
      if (currentOffset < _lastOffset) {
        // Scrolling up
        if (!_showTabBar) {
          setState(() {
            _showTabBar = true;
          });
        }
      } else if (currentOffset > _lastOffset) {
        // Scrolling down
        if (_showTabBar) {
          setState(() {
            _showTabBar = false;
          });
        }
      }
      _lastOffset = currentOffset;
    });

    // Tab listener to scroll to specific sections
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            _scrollToSection(_overviewKey);
            break;
          case 1:
            _scrollToSection(_ratingsKey);
            break;
          case 2:
            _scrollToSection(_detailsKey);
            break;
        }
      }
    });
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final WishlistController wishlistController =
        Get.find<WishlistController>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 244, 244),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.name,
              style: TextStyle(
                fontFamily: consts.bold,
                color: const Color.fromARGB(255, 5, 5, 5),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const CartScreen());
              },
              child: Image.asset(
                icCart,
                width: 24,
                color: const Color.fromARGB(255, 241, 118, 16),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 255, 245, 238),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                backgroundColor: const Color.fromARGB(255, 245, 244, 244),
                automaticallyImplyLeading: false,
                title:
                    _showTabBar
                        ? TabBar(
                          controller: _tabController,
                          labelColor: consts.redColor,
                          unselectedLabelColor: consts.darkFontGrey,
                          indicatorColor: consts.redColor,
                          tabs: const [
                            Tab(text: "Overview"),
                            Tab(text: "Ratings & Reviews"),
                            Tab(text: "Product Details"),
                          ],
                        )
                        : null,
                elevation: _showTabBar ? 2 : 0,
              ),
            ],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.product.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 300,
                      color: const Color.fromARGB(255, 43, 42, 42),
                      child: const Center(
                        child: Icon(Icons.error, color: consts.whiteColor),
                      ),
                    );
                  },
                ),
              ).p(16),
              if (widget.fromExclusiveDeals &&
                  widget.product.isExclusiveDeal &&
                  widget.product.dealEndTime != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "FLASH SALE".text.bold.black.size(14).make(),
                        DealTimer(dealEndTime: widget.product.dealEndTime!),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 5, 5, 5),
                              fontFamily: consts.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Obx(() {
                              bool isWishlisted = wishlistController
                                  .wishlistItems
                                  .contains(widget.product);
                              return IconButton(
                                onPressed: () {
                                  if (isWishlisted) {
                                    wishlistController.removeFromWishlist(
                                      widget.product,
                                    );
                                  } else {
                                    wishlistController.addToWishlist(
                                      widget.product,
                                    );
                                  }
                                },
                                icon: Icon(
                                  isWishlisted
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: consts.redColor,
                                  size: 24,
                                ),
                              );
                            }),
                            IconButton(
                              onPressed: () {
                                Get.snackbar(
                                  "Share",
                                  "Share functionality coming soon!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: consts.darkFontGrey,
                                  colorText: consts.whiteColor,
                                );
                              },
                              icon: Icon(
                                Icons.share,
                                color: consts.darkFontGrey,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    8.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs.${widget.product.price}",
                          style: TextStyle(
                            color: consts.redColor,
                            fontFamily: consts.bold,
                            fontSize: 18,
                          ),
                        ),
                        if (widget.product.originalPrice != null)
                          Text(
                            "Rs.${widget.product.originalPrice}",
                            style: TextStyle(
                              color: consts.fontGrey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 16,
                            ),
                          ),
                      ],
                    ),
                    if (widget.product.discount != null &&
                        widget.product.discount! > 0)
                      Text(
                        "${widget.product.discount}% OFF",
                        style: TextStyle(
                          color: consts.greenColor,
                          fontFamily: consts.bold,
                          fontSize: 16,
                        ),
                      ).pOnly(top: 8),
                    Row(
                      children: [
                        "${widget.product.rating?.toStringAsFixed(1) ?? 'N/A'} (${widget.product.reviews?.length ?? 0})"
                            .text
                            .color(Colors.black)
                            .size(14)
                            .make(),
                        4.widthBox,
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < (widget.product.rating?.round() ?? 0)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ),
                        ),
                        4.widthBox,
                        "${(widget.product.soldCount ?? 0) / 1000}K Sold".text
                            .color(Colors.grey)
                            .size(14)
                            .make(),
                      ],
                    ).pOnly(top: 8),
                    16.heightBox,
                    Row(
                      children: [
                        Icon(Icons.refresh, color: Colors.blue, size: 18),
                        8.widthBox,
                        "14 Days Free Returns".text
                            .color(Colors.black)
                            .size(14)
                            .make(),
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: Colors.blue,
                          size: 18,
                        ),
                        8.widthBox,
                        "Standard Delivery by 4-6 Apr to New Thimi".text
                            .color(Colors.black)
                            .size(14)
                            .make(),
                      ],
                    ),
                    16.heightBox,
                    "Vouchers".text
                        .color(const Color.fromARGB(255, 8, 8, 8))
                        .fontFamily(consts.semibold)
                        .size(16)
                        .make(),
                    8.heightBox,
                    Column(
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    "Rs. 70".text
                                        .color(Colors.green)
                                        .bold
                                        .make(),
                                    8.widthBox,
                                    "Min. Spend Rs. 999".text
                                        .color(Colors.black)
                                        .size(12)
                                        .make(),
                                    8.widthBox,
                                    "09/03/2025".text
                                        .color(Colors.grey)
                                        .size(10)
                                        .make(),
                                  ],
                                ),
                                "Collect".text
                                    .color(Colors.blue)
                                    .size(12)
                                    .make(),
                              ],
                            ),
                          ),
                        ),
                        8.heightBox,
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    "Free Shipping".text
                                        .color(Colors.blue)
                                        .bold
                                        .make(),
                                    8.widthBox,
                                    "No Min. Spend".text
                                        .color(Colors.black)
                                        .size(12)
                                        .make(),
                                  ],
                                ),
                                "Collect".text
                                    .color(Colors.blue)
                                    .size(12)
                                    .make(),
                              ],
                            ),
                          ),
                        ),
                        8.heightBox,
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    "15% OFF".text
                                        .color(Colors.red)
                                        .bold
                                        .make(),
                                    8.widthBox,
                                    "Limited Redemption".text
                                        .color(Colors.black)
                                        .size(12)
                                        .make(),
                                  ],
                                ),
                                const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    24.heightBox,
                    Container(
                      key: _overviewKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "GurkhaPasal Benefits".text
                              .color(const Color.fromARGB(255, 8, 8, 8))
                              .fontFamily(consts.semibold)
                              .size(16)
                              .make(),
                          8.heightBox,
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 112, 108, 108),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.verified_user,
                                      color: consts.primaryColor,
                                      size: 18,
                                    ),
                                    8.widthBox,
                                    Text(
                                      "100% Authentic",
                                      style: TextStyle(
                                        color: consts.darkFontGrey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                8.heightBox,
                                Row(
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      color: consts.primaryColor,
                                      size: 18,
                                    ),
                                    8.widthBox,
                                    Text(
                                      "GurkhaVerified",
                                      style: TextStyle(
                                        color: consts.darkFontGrey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                8.heightBox,
                                Row(
                                  children: [
                                    Icon(
                                      Icons.refresh,
                                      color: consts.primaryColor,
                                      size: 18,
                                    ),
                                    8.widthBox,
                                    Text(
                                      "15 Days Easy Return",
                                      style: TextStyle(
                                        color: consts.darkFontGrey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.heightBox,
                    Container(
                      key: _ratingsKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Ratings & Reviews (${widget.product.reviews?.length ?? 0})"
                              .text
                              .color(const Color.fromARGB(255, 8, 8, 8))
                              .fontFamily(consts.semibold)
                              .size(16)
                              .make(),
                          8.heightBox,
                          Row(
                            children: [
                              Text(
                                widget.product.rating?.toStringAsFixed(1) ??
                                    "N/A",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: consts.bold,
                                  color: const Color.fromARGB(255, 5, 5, 5),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    index <
                                            (widget.product.rating?.round() ??
                                                0)
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: const Color.fromARGB(
                                      255,
                                      241,
                                      118,
                                      16,
                                    ),
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${widget.product.reviews?.length ?? 0} reviews",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: const Color.fromARGB(255, 53, 51, 51),
                                ),
                              ),
                            ],
                          ),
                          16.heightBox,
                          widget.product.reviews == null ||
                                  widget.product.reviews!.isEmpty
                              ? "No reviews yet.".text
                                  .color(consts.darkFontGrey)
                                  .size(14)
                                  .make()
                              : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.product.reviews?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final review = widget.product.reviews![index];
                                  return Card(
                                    color: const Color.fromARGB(
                                      255,
                                      245,
                                      244,
                                      244,
                                    ),
                                    elevation: 2,
                                    margin: const EdgeInsets.only(bottom: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          231,
                                          138,
                                          25,
                                        ),
                                        child: Text(
                                          review.userId[0].toUpperCase(),
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                              255,
                                              49,
                                              47,
                                              47,
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "User ${review.userId}",
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                20,
                                                20,
                                                20,
                                                1,
                                              ),
                                              fontFamily: consts.semibold,
                                            ),
                                          ),
                                          Row(
                                            children: List.generate(
                                              5,
                                              (starIndex) => Icon(
                                                starIndex <
                                                        review.rating.round()
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: const Color.fromARGB(
                                                  255,
                                                  241,
                                                  118,
                                                  16,
                                                ),
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Flexible(
                                        child: Text(
                                          review.comment ??
                                              "No comment provided",
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                              255,
                                              53,
                                              51,
                                              51,
                                            ),
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                          16.heightBox,
                          "Want to Provide Review and rating".text
                              .color(const Color.fromARGB(255, 8, 8, 8))
                              .fontFamily(consts.semibold)
                              .size(16)
                              .make(),
                          8.heightBox,
                          ourButton(
                            color: const Color.fromARGB(255, 255, 245, 238),
                            title: "Give Review",
                            textColor: const Color.fromARGB(255, 241, 118, 16),
                            onPress: () {
                              Get.to(() => const ReviewScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                    24.heightBox,
                    Container(
                      key: _detailsKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Product Description".text
                              .color(const Color.fromARGB(255, 12, 12, 12))
                              .fontFamily(consts.semibold)
                              .size(16)
                              .make(),
                          8.heightBox,
                          Text(
                            widget.product.description,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 68, 65, 65),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.heightBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: consts.whiteColor,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ourButton(
                color: consts.redColor,
                title: consts.addToCart,
                textColor: consts.whiteColor,
                onPress: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder:
                        (context) => ProductSelectionBottomSheet(
                          product: widget.product,
                          cartController: cartController,
                        ),
                  );
                },
                icon: const Icon(Icons.shopping_cart, color: consts.whiteColor),
              ),
            ),
            8.widthBox,
            Expanded(
              child: ourButton(
                color: consts.lightGolden,
                title: consts.buyNow,
                textColor: consts.redColor,
                onPress: () {
                  final selectedColor =
                      widget.product.colors.isNotEmpty
                          ? widget.product.colors[0]
                          : '';
                  final productMap =
                      widget.product.toMap()
                        ..['selectedColor'] = selectedColor
                        ..['quantity'] = 1;
                  cartController.addToCart(productMap);
                  Get.snackbar(
                    "Success",
                    "${widget.product.name} added to cart!",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: consts.redColor,
                    colorText: consts.whiteColor,
                  );
                  Get.to(() => const CartScreen());
                },
                icon: const Icon(Icons.payment, color: consts.redColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DealTimer extends StatefulWidget {
  final DateTime dealEndTime;

  const DealTimer({super.key, required this.dealEndTime});

  @override
  _DealTimerState createState() => _DealTimerState();
}

class _DealTimerState extends State<DealTimer> {
  late Timer _timer;
  Duration _timeLeft = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateTimeLeft();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTimeLeft();
    });
  }

  void _updateTimeLeft() {
    final now = DateTime.now();
    final difference = widget.dealEndTime.difference(now);
    if (difference.isNegative) {
      setState(() {
        _timeLeft = Duration.zero;
      });
      _timer.cancel();
    } else {
      setState(() {
        _timeLeft = difference;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _timeLeft.inHours.toString().padLeft(2, '0');
    final minutes = (_timeLeft.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_timeLeft.inSeconds % 60).toString().padLeft(2, '0');

    return Text(
      "ENDS IN $hours:$minutes:$seconds",
      style: TextStyle(
        color: Colors.black,
        fontFamily: consts.bold,
        fontSize: 14,
      ),
    );
  }
}

class ProductSelectionBottomSheet extends StatefulWidget {
  final Product product;
  final CartController cartController;

  const ProductSelectionBottomSheet({
    super.key,
    required this.product,
    required this.cartController,
  });

  @override
  _ProductSelectionBottomSheetState createState() =>
      _ProductSelectionBottomSheetState();
}

class _ProductSelectionBottomSheetState
    extends State<ProductSelectionBottomSheet> {
  String selectedColor = '';
  String selectedStorage = '';
  String selectedSize = '';
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    selectedColor =
        widget.product.colors.isNotEmpty ? widget.product.colors[0] : '';
    selectedStorage =
        widget.product.storageOptions.isNotEmpty
            ? widget.product.storageOptions[0]
            : '';
    selectedSize =
        widget.product.sizes.isNotEmpty ? widget.product.sizes[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              IconButton(
                icon: const Icon(Icons.close, color: consts.darkFontGrey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.product.imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 80,
                      width: 80,
                      color: Colors.grey,
                      child: const Icon(Icons.error, color: consts.whiteColor),
                    );
                  },
                ),
              ),
              16.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(fontFamily: consts.bold, fontSize: 16),
                  ),
                  8.heightBox,
                  Text(
                    "Rs.${widget.product.price}",
                    style: TextStyle(color: consts.fontGrey),
                  ),
                ],
              ),
            ],
          ),
          24.heightBox,
          if (widget.product.colors.isNotEmpty) ...[
            "Color Family".text.fontFamily(consts.semibold).size(16).make(),
            8.heightBox,
            Wrap(
              spacing: 8.0,
              children:
                  widget.product.colors.map((color) {
                    return ChoiceChip(
                      label: Text(color),
                      selected: selectedColor == color,
                      onSelected: (selected) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      selectedColor: consts.redColor,
                      labelStyle: TextStyle(
                        color:
                            selectedColor == color
                                ? consts.whiteColor
                                : consts.darkFontGrey,
                      ),
                    );
                  }).toList(),
            ),
            24.heightBox,
          ],
          if (widget.product.storageOptions.isNotEmpty) ...[
            "Storage".text.fontFamily(consts.semibold).size(16).make(),
            8.heightBox,
            Wrap(
              spacing: 8.0,
              children:
                  widget.product.storageOptions.map((storage) {
                    return ChoiceChip(
                      label: Text(storage),
                      selected: selectedStorage == storage,
                      onSelected: (selected) {
                        setState(() {
                          selectedStorage = storage;
                        });
                      },
                      selectedColor: consts.redColor,
                      labelStyle: TextStyle(
                        color:
                            selectedStorage == storage
                                ? consts.whiteColor
                                : consts.darkFontGrey,
                      ),
                    );
                  }).toList(),
            ),
            24.heightBox,
          ],
          if (widget.product.sizes.isNotEmpty) ...[
            "Size".text.fontFamily(consts.semibold).size(16).make(),
            8.heightBox,
            Wrap(
              spacing: 8.0,
              children:
                  widget.product.sizes.map((size) {
                    return ChoiceChip(
                      label: Text(size),
                      selected: selectedSize == size,
                      onSelected: (selected) {
                        setState(() {
                          selectedSize = size;
                        });
                      },
                      selectedColor: consts.redColor,
                      labelStyle: TextStyle(
                        color:
                            selectedSize == size
                                ? consts.whiteColor
                                : consts.darkFontGrey,
                      ),
                    );
                  }).toList(),
            ),
            24.heightBox,
          ],
          "Quantity".text.fontFamily(consts.semibold).size(16).make(),
          8.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed:
                    quantity > 1
                        ? () {
                          setState(() {
                            quantity--;
                          });
                        }
                        : null,
                icon: const Icon(Icons.remove),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  quantity.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 5, 5, 5),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          24.heightBox,
          SizedBox(
            width: double.infinity,
            child: ourButton(
              color: consts.redColor,
              title: "Add to Cart",
              textColor: consts.whiteColor,
              onPress: () {
                final productMap =
                    widget.product.toMap()
                      ..['selectedColor'] = selectedColor
                      ..['selectedStorage'] = selectedStorage
                      ..['selectedSize'] = selectedSize
                      ..['quantity'] = quantity;
                widget.cartController.addToCart(productMap);
                Get.snackbar(
                  "Success",
                  "${widget.product.name} added to cart!",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: consts.redColor,
                  colorText: consts.whiteColor,
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
