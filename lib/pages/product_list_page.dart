import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _searchQuery = '';
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
    fetchProducts();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? '';
    });
  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('https://fakestoreapi.com/products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          _products = data.map((json) => Product.fromJson(json)).toList();
          _filteredProducts = _products;
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredProducts = _products.where((product) {
        return product.title.toLowerCase().contains(_searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_userName.isNotEmpty ? 'Welcome, $_userName' : 'InNova Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text('Error loading products'))
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onChanged: _filterProducts,
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = _filteredProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/details',
                                arguments: product,
                              );
                            },
                            child: Card(
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      product.image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text('\$${product.price.toString()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(height: 4),
                                  ElevatedButton(
                                    onPressed: () {
                                      cartProvider.addToCart(product);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Added to cart'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    child: Text('Add to Cart'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
