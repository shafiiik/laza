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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(homeRepository: HomeRepository())
        ..add(LoadHomeEvent(page: 1)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(AssetsPath.logo),
          actions: [
            CustomSvgIconButton(
              svgIconPath: AssetsPath.cartIcon,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cart);
              },
            )
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadedState) {
              return SingleChildScrollView(
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
                    ],
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
      ),
    );
  }
}
