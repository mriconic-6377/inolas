import 'package:flutter/material.dart';

class ResourceCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final List<ResourceItem> items;

  ResourceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class ResourceItem {
  final String id;
  final String title;
  final String type; // 'PDF', 'Link', 'Video'
  final String url;
  final String size; // e.g., '2.5 MB'

  ResourceItem({
    required this.id,
    required this.title,
    required this.type,
    required this.url,
    required this.size,
  });
}
