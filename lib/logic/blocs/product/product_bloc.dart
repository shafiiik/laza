import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laza/data/models/product_model.dart';
import 'package:laza/data/repositories/product_repository.dart';



part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // final ProductRepository productRepository;

  ProductBloc(/*{required this.productRepository}*/) : super(ProductInitialState()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<EditProductEvent>(_onEditProduct);
  }

  void _onLoadProducts(LoadProductsEvent event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoadingState());
      // final products = await productRepository.fetchProducts(event.page, event.limit);
      // emit(ProductLoadedState(products: products, hasMore: products.length == event.limit));
    } catch (error) {
      emit(ProductErrorState(error: error.toString()));
    }
  }

  void _onEditProduct(EditProductEvent event, Emitter<ProductState> emit) async {
    try {
      // final updatedProduct = await productRepository.updateProduct(event.productId, event.updatedData);
      // emit(ProductUpdatedState(updatedProduct: updatedProduct));
    } catch (error) {
      emit(ProductErrorState(error: error.toString()));
    }
  }
}
