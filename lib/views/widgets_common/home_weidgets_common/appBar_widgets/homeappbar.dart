import 'package:flutter/material.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/appBar_widgets/appbar.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/cart_widgets/cart_menue.dart';
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning,',
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: Colors.grey),
          ),
          Text(
            'Ishwor',
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.apply(color: Colors.white),
          ),
        ],
      ),
      actions: [
        CartCounterIcon(
          iconColor: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}
