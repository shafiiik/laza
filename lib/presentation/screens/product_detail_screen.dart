import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza/core/constants/app_colors.dart';
import 'package:laza/core/constants/app_strings.dart';
import 'package:laza/core/constants/assets_path.dart';
import 'package:laza/data/models/cart_item.dart';
import 'package:laza/data/models/product_model.dart';
import 'package:laza/logic/blocs/cart/cart_bloc.dart';
import 'package:laza/presentation/routes/app_routes.dart';
import 'package:laza/presentation/widgets/bottom_button.dart';
import 'package:laza/presentation/widgets/header_widget.dart';
import 'package:laza/presentation/widgets/svg_icon_button.dart';
import 'package:laza/presentation/widgets/images_row.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomButton(
        title: AppStrings.addToCart,
        onPressed: () {
          context.read<CartBloc>().add(
                AddToCartItem(
                  item: CartItem(
                    id: widget.product.id,
                    name: widget.product.title,
                    quantity: 1,
                    price: widget.product.price,
                    image: widget.product.images[0],
                  ),
                ),
              );
        },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.product.images[0],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image,
                        size: 300,
                      )),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSvgIconButton(
                        svgIconPath: AssetsPath.backIcon,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CustomSvgIconButton(
                        svgIconPath: AssetsPath.cartIcon,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.cart);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: headerDescriptionColumn(
                            "Description", widget.product.title),
                      ),
                      Expanded(
                        flex: 1,
                        child: headerDescriptionColumn(
                            AppStrings.price, "\$${widget.product.price}"),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ImagesRow(images: widget.product.images),
                  SizedBox(height: 16),
                  HeaderWidget(title: AppStrings.description),
                  buildExpandableDescription(widget.product.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column headerDescriptionColumn(String header, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.fontDisabled,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.title,
          ),
        ),
      ],
    );
  }

  Widget buildExpandableDescription(String description) {
    const int previewLength = 100;
    final bool shouldShowSeeMore = description.length > previewLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: isExpanded
                    ? description
                    : description.substring(0, previewLength) + '...',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.fontDisabled,
                ),
              ),
              if (shouldShowSeeMore)
                TextSpan(
                  text: isExpanded ? ' See less' : ' See more',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
