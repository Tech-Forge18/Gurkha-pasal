import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/images.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/ViewAll/circular_icon.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/ViewAll/product_title_text.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/ViewAll/round_image.dart';
import 'package:gurkha_pasal/views/widgets_common/home_weidgets_common/circular_container.dart';
import 'package:iconsax/iconsax.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.img, required this.name, required this.brand, required this.price, required this.discount});


final String img;
final String name;
final String brand;
final String price;
final String discount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        // height: 250,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange,
        ),
        child: Column(
          children: [
            CircularContainer(
              height: 145,
              padding: const EdgeInsets.all(0),
              radius: 5,
      
              backgroundColor: Colors.grey,
              // child: Image.asset(imgSs1),
              child: Stack(
                children: [
                  RoundImage(
                    width: 220,
                    height: 150,
                    imageUrl: img,
                    applyImageRadius: true,  
                    fit: BoxFit.cover,
                    padding: const EdgeInsets.all(0),
                  ),
                  Positioned(
                    top: 12,
                    left: 10,
                    child: CircularContainer(
               
                      radius: 10,
                      backgroundColor: Colors.orange.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      child: Text(
                        discount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
      
                    child: CircularIcon(height: 45, width: 45, icon: Iconsax.heart5, color: Colors.red),
                  ),
                ],
              ),
            ),
                  const SizedBox(height: 10),

       ProductTitleText(title : name  ),
            const SizedBox(height: 5),
      
            Row(
              children: [
                Text(brand,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                 style: Theme.of(context).textTheme.labelMedium
                ),
                const SizedBox(width: 5),
                const Icon(Iconsax.verify5, color: Colors.blue, size: 15),
              ],
            ),
      
            Row(
                mainAxisAlignment : MainAxisAlignment.spaceBetween ,
              children: [
                Text(price,
                maxLines: 1,
                
                overflow: TextOverflow.ellipsis,
                 style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                 ),
         
                ),
                Container (
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                  ),
                  child : const SizedBox(
                    width: 40,
                    height: 30,
                    child: Center(
                      child: Icon(Iconsax.add, color: Colors.white, ),
                    ),
                  )
                )
             
              ],
            )
      
      
          ],
        ),
      ),
    );
  }
}
