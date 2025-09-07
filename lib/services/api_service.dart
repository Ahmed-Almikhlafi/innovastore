import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse('$baseUrl/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> fetchProductById(int id) async {
    final url = Uri.parse('$baseUrl/products/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Failed to load product');
    }
  }
}
