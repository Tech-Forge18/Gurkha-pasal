import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/consts.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: whiteColor,
      child: Align(
        alignment: Alignment.centerLeft, 
        child: TabBar(
          tabs: tabs,
          isScrollable: false, 
          indicatorColor: redColor,
          labelColor: redColor,
          unselectedLabelColor: fontGrey,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
