part of 'cart_bloc.dart';


abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<Product> cartItems;

  CartLoadedState({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}

class CartErrorState extends CartState {
  final String error;

  CartErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
