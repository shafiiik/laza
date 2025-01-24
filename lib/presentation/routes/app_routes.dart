import 'package:flutter/material.dart';
import 'package:laza/presentation/screens/cart_screen.dart';
import 'package:laza/presentation/screens/edit_product_screen.dart';
import 'package:laza/presentation/screens/home_screen.dart';
import 'package:laza/presentation/screens/product_detail_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
  static const String editProduct = '/edit-product';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      productDetails: (context) => const ProductDetailScreen(),
      cart: (context) => const CartScreen(),
      editProduct: (context) => const EditProductScreen(),
    };
  }
}
