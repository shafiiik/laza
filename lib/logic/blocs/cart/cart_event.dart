part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCartItem extends CartEvent {
  final CartItem item;

  AddToCartItem({required this.item});

  @override
  List<Object> get props => [item];
}

class RemoveCartItem extends CartEvent {
  final int productId;

  RemoveCartItem({required this.productId});

  @override
  List<Object> get props => [productId];
}

class UpdateCartItem extends CartEvent {
  final CartItem item;

  UpdateCartItem({required this.item});

  @override
  List<Object> get props => [item];
}

class LoadCartEvent extends CartEvent {}

class ClearCartEvent extends CartEvent {}
