import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza/data/models/product_model.dart';
import 'package:laza/data/repositories/cart_repository.dart';
import 'package:laza/logic/blocs/cart/cart_bloc.dart';
import 'package:laza/presentation/screens/cart_screen.dart';
import 'package:laza/presentation/screens/confirm_screen.dart';
import 'package:laza/presentation/screens/home_screen.dart';
import 'package:laza/presentation/screens/product_detail_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
  static const String confirmPage = '/confirmPage';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      productDetails: (context) {
        final product = ModalRoute.of(context)?.settings.arguments as Product;
        return ProductDetailScreen(product: product);
      },
      cart: (context) => BlocProvider(
          create: (context) =>
              CartBloc(cartRepository: CartRepository())..add(LoadCartEvent()),
          child: const CartScreen()),

      confirmPage: (context) => const ConfirmScreen(),
    };
  }
}
