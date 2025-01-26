import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laza/core/constants/app_colors.dart';
import 'package:laza/core/constants/app_strings.dart';
import 'package:laza/core/constants/assets_path.dart';
import 'package:laza/logic/blocs/cart/cart_bloc.dart';
import 'package:laza/presentation/routes/app_routes.dart';
import 'package:laza/presentation/widgets/bottom_button.dart';
import 'package:laza/presentation/widgets/cart_item_card.dart';
import 'package:laza/presentation/widgets/header_widget.dart';
import 'package:laza/presentation/widgets/information_row.dart';
import 'package:laza/presentation/widgets/svg_icon_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int cartItemsLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomButton(
        title: AppStrings.checkout,
        onPressed: () {
          if (cartItemsLength == 0) {
            Fluttertoast.showToast(msg: AppStrings.yourCartIsEmpty);
          } else {
            context.read<CartBloc>().add(ClearCartEvent());

            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.confirmPage,
              (Route<dynamic> route) => false,
            );
          }
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: CustomSvgIconButton(
            svgIconPath: AssetsPath.backIcon,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          AppStrings.cart,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CartLoadedState) {
                    final cartItems = state.cartItems;
                    cartItemsLength = cartItems.length;
                    if (cartItems.isEmpty) {
                      return const Center(
                        child: Text(AppStrings.emptyCart),
                      );
                    }
                    return ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return CartItemCard(item: item);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                },
              ),
            ),
            HeaderWidget(title: AppStrings.paymentMethod),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: AppColors.iconButtonBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: Row(
                  children: [
                    Text(AppStrings.cashOnDelivery),
                    Spacer(),
                    SvgPicture.asset(AssetsPath.check)
                  ],
                ),
              ),
            ),
            HeaderWidget(title: AppStrings.orderInfo),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartLoadedState) {
                        final subTotalPrice = state.cartItems.fold(
                          0.0,
                          (sum, item) => sum + item.price * item.quantity,
                        );
                        final totalPrice = state.cartItems.fold(
                              0.0,
                              (sum, item) => sum + item.price * item.quantity,
                            ) +
                            10;
                        return Column(
                          children: [
                            InformationRow(
                              title: AppStrings.subTotal,
                              subTitle: '\$${subTotalPrice.toStringAsFixed(2)}',
                            ),
                            InformationRow(
                              title: AppStrings.shippingCost,
                              subTitle:
                                  state.cartItems.isEmpty ? '\$0' : '\$10',
                            ),
                            InformationRow(
                              title: AppStrings.total,
                              subTitle: state.cartItems.isEmpty
                                  ? '\$0'
                                  : '\$${totalPrice.toStringAsFixed(2)}',
                            ),
                            SizedBox(height: 16),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
