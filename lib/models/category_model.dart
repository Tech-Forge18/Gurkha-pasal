// lib/models/category_model.dart
import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final String? image; // Optional image path (e.g., from consts/images.dart)

  Category({required this.name, required this.icon, this.image});
}
