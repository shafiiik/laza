import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laza/data/models/product_model.dart';



part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  // final CartRepository cartRepository;

  CartBloc(/*{required this.cartRepository}*/) : super(CartInitialState()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<LoadCartEvent>(_onLoadCart);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      // await cartRepository.addToCart(event.product);
      // final cartItems = await cartRepository.getCartItems();
      // emit(CartLoadedState(cartItems: cartItems));
    } catch (error) {
      emit(CartErrorState(error: error.toString()));
    }
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    try {
      // await cartRepository.removeFromCart(event.productId);
      // final cartItems = await cartRepository.getCartItems();
      // emit(CartLoadedState(cartItems: cartItems));
    } catch (error) {
      emit(CartErrorState(error: error.toString()));
    }
  }

  void _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoadingState());
      // final cartItems = await cartRepository.getCartItems();
      // emit(CartLoadedState(cartItems: cartItems));
    } catch (error) {
      emit(CartErrorState(error: error.toString()));
    }
  }
}
