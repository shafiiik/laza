import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza/core/constants/app_strings.dart';
import 'package:laza/data/models/cart_item.dart';
import 'package:laza/presentation/widgets/custom_icon_button.dart';

import '../../logic/blocs/cart/cart_bloc.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({required this.item, super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // Border radius of 10
        border: Border.all(
          color: Colors.grey,
          width: 0.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                  errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image,
                        size: 100,
                      )),
                  loadingBuilder: (context, child, loadingProgress) {
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppStrings.price}: \$${item.price}'),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconButton(
                              icon: Icons.keyboard_arrow_down_outlined,
                              onPressed: () {
                                context.read<CartBloc>().add(UpdateCartItem(
                                      item: item.copyWith(
                                          quantity: item.quantity - 1),
                                    ));
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('${item.quantity}'),
                            ),
                            CustomIconButton(
                              icon: Icons.keyboard_arrow_up,
                              onPressed: () {
                                context.read<CartBloc>().add(UpdateCartItem(
                                      item: item.copyWith(
                                          quantity: item.quantity + 1),
                                    ));
                              },
                            ),
                            Spacer(),
                            CustomIconButton(
                              icon: Icons.delete_outline,
                              onPressed: () {
                                context.read<CartBloc>().add(RemoveCartItem(
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
  }
}
