import 'package:hive/hive.dart';
import 'package:laza/data/models/cart_item.dart';

class CartRepository {
  final _cartBox = Hive.box<CartItem>('cart');

  Future<void> addToCart(CartItem item) async {
    await _cartBox.put(item.id, item);
  }

  Future<void> removeFromCart(int id) async {
    await _cartBox.delete(id);
  }

  Future<void> updateCart(CartItem item) async {
    await _cartBox.put(item.id, item);
  }

  List<CartItem> getCartItems() {
    return _cartBox.values.toList();
  }

  Future<void> clearCart() async {
    await _cartBox.clear();
  }
}
