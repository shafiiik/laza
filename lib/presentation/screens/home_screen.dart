import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza/core/constants/app_strings.dart';
import 'package:laza/core/constants/assets_path.dart';
import 'package:laza/data/repositories/home_repository.dart';
import 'package:laza/logic/blocs/home/home_bloc.dart';
import 'package:laza/presentation/routes/app_routes.dart';
import 'package:laza/presentation/widgets/category_card.dart';
import 'package:laza/presentation/widgets/header_widget.dart';
import 'package:laza/presentation/widgets/svg_icon_button.dart';
import 'package:laza/presentation/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(LoadHomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset(AssetsPath.logo),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomSvgIconButton(
              svgIconPath: AssetsPath.cartIcon,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cart);
              },
            ),
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadedState) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    state.hasMore) {
                  context.read<HomeBloc>().add(LoadMoreProductsEvent());
                }
                return true;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWidget(title: AppStrings.categories),
                      CategoryCards(categories: state.categories),
                      SizedBox(height: 8),
                      HeaderWidget(title: AppStrings.products),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: state.products[index]);
                        },
                      ),
                      if (state.hasMore)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is HomeLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}
