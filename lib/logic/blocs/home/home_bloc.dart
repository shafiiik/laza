import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laza/data/models/category_model.dart';
import 'package:laza/data/models/product_model.dart';
import 'package:laza/data/repositories/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  final int productsPerPage = 10;

  HomeBloc({required this.homeRepository}) : super(HomeInitialState()) {
    on<LoadHomeEvent>(_onLoadHome);
    on<LoadMoreProductsEvent>(_onLoadMoreProducts);
    on<EditProductEvent>(_onEditProduct);
  }

  Future<void> _onLoadHome(LoadHomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState());

      final products = await homeRepository.fetchProducts();
      final categories = await homeRepository.fetchCategories();

      emit(HomeLoadedState(
        categories: categories,
        products: products.take(productsPerPage).toList(),
        hasMore: products.length > productsPerPage,
        allProducts: products,
        currentPage: 1,
      ));
    } catch (error) {
      emit(HomeErrorState(error: error.toString()));
    }
  }

  void _onLoadMoreProducts(
      LoadMoreProductsEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoadedState) {
      final currentState = state as HomeLoadedState;
      final currentPage = currentState.currentPage;
      final allProducts = currentState.allProducts;

      final nextPage = currentPage + 1;
      final startIndex = currentPage * productsPerPage;
      final endIndex =
          (startIndex + productsPerPage).clamp(0, allProducts.length);

      final moreProducts = allProducts.sublist(
        startIndex,
        endIndex,
      );

      emit(HomeLoadedState(
        categories: currentState.categories,
        products: [...currentState.products, ...moreProducts],
        hasMore: endIndex < allProducts.length,
        allProducts: allProducts,
        currentPage: nextPage,
      ));
    }
  }

  void _onEditProduct(EditProductEvent event, Emitter<HomeState> emit) async {
    if (state is HomeLoadedState) {
      try {
        final updatedProduct = await homeRepository.updateProduct(
          event.productId,
          event.updatedData,
        );

        final currentState = state as HomeLoadedState;

        final updatedProducts = currentState.products.map((product) {
          if (product.id == event.productId) {
            return updatedProduct;
          }
          return product;
        }).toList();

        emit(HomeLoadedState(
          categories: currentState.categories,
          products: updatedProducts,
          hasMore: currentState.hasMore,
          allProducts: currentState.allProducts.map((product) {
            if (product.id == event.productId) {
              return updatedProduct; // Update the product in the allProducts list too.
            }
            return product;
          }).toList(),
          currentPage: currentState.currentPage,
        ));
      } catch (error) {
        emit(HomeErrorState(error: error.toString()));
      }
    } else {
      emit(HomeErrorState(
        error: "Cannot edit product because the state is not loaded.",
      ));
    }
  }

}
