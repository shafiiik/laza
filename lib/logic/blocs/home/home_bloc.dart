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
}
