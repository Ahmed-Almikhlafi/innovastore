import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/product_list_page.dart';
import 'pages/product_details_page.dart';
import 'pages/cart_page.dart';
import 'pages/profile_page.dart';  
import 'providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  final prefs = await SharedPreferences.getInstance();
  final bool isProfileCreated = prefs.getBool('isProfileCreated') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: InNovaApp(isProfileCreated: isProfileCreated),
    ),
  );
}

class InNovaApp extends StatelessWidget {
  final bool isProfileCreated;
  InNovaApp({required this.isProfileCreated});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InNova',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isProfileCreated ? ProductListPage() : ProfilePage(),
      routes: {
        '/details': (context) => ProductDetailsPage(),
        '/cart': (context) => CartPage(),
      },
    );
  }
}

