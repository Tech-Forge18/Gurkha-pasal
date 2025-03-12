import 'package:flutter/material.dart';
import 'package:gurkha_pasal/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for products',
          prefixIcon: const Icon(Icons.search, color: Vx.gray100),
          filled: true,
          fillColor: Vx.gray100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
