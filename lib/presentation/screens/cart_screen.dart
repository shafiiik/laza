import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza/core/constants/app_colors.dart';
import 'package:laza/core/constants/app_strings.dart';
import 'package:laza/core/constants/assets_path.dart';
import 'package:laza/data/models/cart_item.dart';
import 'package:laza/logic/blocs/cart/cart_bloc.dart';
import 'package:laza/presentation/routes/app_routes.dart';
import 'package:laza/presentation/widgets/bottom_button.dart';
import 'package:laza/presentation/widgets/custom_icon_button.dart';
import 'package:laza/presentation/widgets/svg_icon_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomButton(
        title: AppStrings.checkout,
        onPressed: () {
          context.read<CartBloc>().add(ClearCartEvent());
          Navigator.pushNamed(context, AppRoutes.confirmPage);
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
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CartLoadedState) {
                  final cartItems = state.cartItems;
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
                            // You can change the border color here
                            width: 0.2, // You can adjust the border width here
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
                                      if (loadingProgress == null) return child;
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text('${item.quantity}'),
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

          // Cart Summary
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoadedState) {
                      final totalPrice = state.cartItems.fold(
                        0.0,
                        (sum, item) => sum + item.price * item.quantity,
                      );
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
