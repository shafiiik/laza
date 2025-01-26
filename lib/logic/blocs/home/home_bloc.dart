import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laza/data/models/category_model.dart';
import 'package:laza/data/models/product_model.dart';
import 'package:laza/data/repositories/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeInitialState()) {
    on<LoadHomeEvent>(_onLoadHome);
    on<EditProductEvent>(_onEditProduct);
  }

  void _onLoadHome(LoadHomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState());

      final products =
          await homeRepository.fetchProducts();

      final categories = await homeRepository.fetchCategories();

      emit(HomeLoadedState(
        categories: categories,
        products: products,
        hasMore: false,
      ));
    } catch (error) {
      emit(HomeErrorState(error: error.toString()));
    }
  }

  void _onEditProduct(EditProductEvent event, Emitter<HomeState> emit) async {
    try {
      final updatedProduct = await homeRepository.updateProduct(
          event.productId, event.updatedData);

      final currentState = state as HomeLoadedState;

      final updatedProducts = currentState.products.map((product) {
        return product.id == updatedProduct.id ? updatedProduct : product;
      }).toList();

      emit(HomeLoadedState(
        categories: currentState.categories,
        products: updatedProducts,
        hasMore: currentState.hasMore,
      ));
    } catch (error) {
      emit(HomeErrorState(error: error.toString()));
    }
  }
}
