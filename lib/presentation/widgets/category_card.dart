import 'package:flutter/material.dart';
import 'package:laza/core/constants/assets_path.dart';
import 'package:laza/data/models/category_model.dart';

class CategoryCards extends StatelessWidget {
  const CategoryCards({required this.categories, super.key});

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: Colors.transparent,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
            categories.map((category) => _buildCard(category.name)).toList(),
      ),
    );
  }

  Container _buildCard(String title) {
    return Container(
      alignment: Alignment.center,
      width: 90,
      height: 90,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: ClipOval(
              child: Image.asset(
                AssetsPath.categoryCard,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
