import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:laza/core/constants/app_strings.dart';
import 'package:laza/data/models/category_model.dart';
import '../models/product_model.dart';

class HomeRepository {

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('${AppStrings.baseUrl}v1/products/');
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

  Future<Product> updateProduct(
      int productId, Map<String, dynamic> updatedData) async {
    final url = Uri.parse('${AppStrings.baseUrl}v1/products/$productId');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData),
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Edited successfully");
        return Product.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  // Fetch categories
  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('${AppStrings.baseUrl}v1/categories/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) => Category.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
