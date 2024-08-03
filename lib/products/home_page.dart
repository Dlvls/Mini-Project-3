import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:miniproject3/products/popular_product.dart';

import '../data/firestore/bloc/products/f_products_bloc.dart';
import '../data/firestore/bloc/products/f_products_event.dart';
import '../resources/colors.dart';
import '../resources/styles.dart';
import 'category_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  void initState() {
    super.initState();
    // Trigger the event to load products from Firestore
    context.read<FirestoreProductsBloc>().add(LoadFirestoreProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        title: Text(
          'Search Products',
          style: Styles.appbarText.copyWith(color: primaryText),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/cart');
            },
            icon: const Icon(Icons.shopping_cart),
            color: primaryText,
          ),
          PopupMenuTheme(
            data: const PopupMenuThemeData(
              color: secondaryColor,
              textStyle: TextStyle(color: primaryText),
            ),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'profile') {
                  context.push('/profile');
                }
              },
              icon: const Icon(Icons.more_vert),
              color: secondaryColor,
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Text(
                    'Profile',
                    style: Styles.title.copyWith(color: primaryText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        color: secondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration(
                    hintText: "Try 'Men's Cotton Jacket'",
                    hintStyle: TextStyle(color: secondaryText),
                    filled: true,
                    fillColor: cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CategoryProduct(searchQuery: _searchQuery),
                const SizedBox(height: 32),
                const PopularProduct(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
