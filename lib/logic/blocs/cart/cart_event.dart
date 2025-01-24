part of 'cart_bloc.dart';


abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final Product product;

  AddToCartEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;

  RemoveFromCartEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class LoadCartEvent extends CartEvent {}
