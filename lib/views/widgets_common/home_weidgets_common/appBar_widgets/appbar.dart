import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AAppbar({
    super.key,
    this.title,
this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingonPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0,),
     child: AppBar(
      automaticallyImplyLeading: false,
      
      leading: showBackArrow? 
      IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left)) 
      : leadingIcon != null ? IconButton(onPressed: leadingonPressed, icon: Icon(leadingIcon)) : null,
    title: title,
      actions: actions,
  
    ),);
  }
    
   

  @override

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
