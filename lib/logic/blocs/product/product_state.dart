part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;
  final bool hasMore;

  ProductLoadedState({required this.products, required this.hasMore});

  @override
  List<Object> get props => [products, hasMore];
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class ProductUpdatedState extends ProductState {
  final Product updatedProduct;

  ProductUpdatedState({required this.updatedProduct});

  @override
  List<Object> get props => [updatedProduct];
}
