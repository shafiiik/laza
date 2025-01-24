import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRepository {
  final String baseUrl;

  ProductRepository({required this.baseUrl});

  // Fetch products with pagination
  Future<List<Product>> fetchProducts(int page, int limit) async {
    final url = Uri.parse('$baseUrl/products?_page=$page&_limit=$limit');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  // Update a specific product
  Future<Product> updateProduct(int productId, Map<String, dynamic> updatedData) async {
    final url = Uri.parse('$baseUrl/products/$productId');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData),
      );
      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }
}
