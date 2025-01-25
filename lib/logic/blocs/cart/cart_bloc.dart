import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza/data/models/cart_item.dart';
import 'package:laza/data/repositories/cart_repository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitialState()) {
    on<AddToCartItem>(_onAddToCart);
    on<RemoveCartItem>(_onRemoveFromCart);
    on<UpdateCartItem>(_onUpdateCart);
    on<LoadCartEvent>(_onLoadCart);
    on<ClearCartEvent>(_onClearCart);
  }

  void _onAddToCart(AddToCartItem event, Emitter<CartState> emit) async {
    try {
      await cartRepository.addToCart(event.item);
      final cartItems = cartRepository.getCartItems();
      emit(CartLoadedState(cartItems: cartItems));
    } catch (error) {
      emit(CartErrorState(error: error.toString()));
    }
  }

  void _onRemoveFromCart(RemoveCartItem event, Emitter<CartState> emit) async {
    try {
      await cartRepository.removeFromCart(event.productId);
      final cartItems = cartRepository.getCartItems();
      emit(CartLoadedState(cartItems: cartItems));
    } catch (error) {
      emit(CartErrorState(error: error.toString()));
    }
  }

  void _onUpdateCart(UpdateCartItem event, Emitter<CartState> emit) async {
    try {
      await cartRepository.updateCart(event.item);
      final cartItems = cartRepository.getCartItems();
      emit(CartLoadedState(cartItems: cartItems));
    } catch (error) {
      emit(CartErrorState(error: error.toString()));
    }
  }

  void _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoadingState());
      final cartItems = cartRepository.getCartItems();
      emit(CartLoadedState(cartItems: cartItems));
    } catch (error) {
      emit(CartErrorState(error: error.toString()));
    }
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoadingState());
      await cartRepository.clearCart();
      final cartItems = cartRepository.getCartItems();
      emit(CartLoadedState(cartItems: cartItems));
    } catch (error) {
      emit(CartErrorState(error: error.toString()));
    }
  }
}
