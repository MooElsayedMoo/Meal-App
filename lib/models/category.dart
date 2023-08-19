import 'package:flutter/material.dart';

class Category {
  final String title;
  final String id;
  final Color color;

  Category({
    required this.title,
    required this.id,
    this.color = Colors.orange,
  });
}
