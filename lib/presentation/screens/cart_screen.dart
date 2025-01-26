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
import 'package:laza/presentation/widgets/custom_icon_button.dart';
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
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // Border radius of 10
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      item.image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                  width: double.infinity,
                                                  alignment: Alignment.center,
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                    size: 100,
                                                  )),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          maxLines: 2,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${AppStrings.price}: \$${item.price}'),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomIconButton(
                                                  icon: Icons
                                                      .keyboard_arrow_down_outlined,
                                                  onPressed: () {
                                                    // context
                                                    //     .read<CartBloc>()
                                                    //     .add(UpdateCartItem(
                                                    //         item: CartItem(
                                                    //       id: item.id,
                                                    //       name: item.name,
                                                    //       quantity:
                                                    //           item.quantity++,
                                                    //       price: item.price,
                                                    //       image: item.image,
                                                    //     )));
                                                  },
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0),
                                                  child:
                                                      Text('${item.quantity}'),
                                                ),
                                                CustomIconButton(
                                                  icon: Icons.keyboard_arrow_up,
                                                  onPressed: () {
                                                    // context
                                                    //     .read<CartBloc>()
                                                    //     .add(UpdateCartItem(
                                                    //         item: CartItem(
                                                    //       id: item.id,
                                                    //       name: item.name,
                                                    //       quantity:
                                                    //           item.quantity--,
                                                    //       price: item.price,
                                                    //       image: item.image,
                                                    //     )));
                                                  },
                                                ),
                                                Spacer(),
                                                CustomIconButton(
                                                  icon: Icons.delete_outline,
                                                  onPressed: () {
                                                    context
                                                        .read<CartBloc>()
                                                        .add(RemoveCartItem(
                                                          productId: item.id,
                                                        ));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
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
