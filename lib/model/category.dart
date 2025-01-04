import 'package:flutter/material.dart';

class Category {
  final int categoryId;
  final String name;
  final IconData icon;

  Category({
    required this.categoryId,
    required this.name,
    required this.icon,
  });

  // Define static categories
  static final allCategory = Category(
    categoryId: 0,
    name: 'All',
    icon: Icons.search,
  );

  static final musicCategory = Category(
    categoryId: 1,
    name: 'Music',
    icon: Icons.music_note,
  );

  static final meetUpCategory = Category(
    categoryId: 2,
    name: 'MeetUp',
    icon: Icons.location_on,
  );

  static final golfCategory = Category(
    categoryId: 3,
    name: 'Golf',
    icon: Icons.golf_course,
  );

  static final birthDayCategory = Category(
    categoryId: 4,
    name: 'BirthDay',
    icon: Icons.cake,
  );

  // List of categories
  static final categories = [
    allCategory,
    musicCategory,
    meetUpCategory,
    golfCategory,
    birthDayCategory,
  ];

}