import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject3/data/firestore/bloc/cart/f_cart_event.dart';
import 'package:miniproject3/data/firestore/bloc/products/f_products_event.dart';

import 'data/firestore/bloc/cart/f_cart_bloc.dart';
import 'data/firestore/bloc/cart/f_cart_state.dart';
import 'data/firestore/bloc/products/f_products_bloc.dart';
import 'data/firestore/bloc/products/f_products_state.dart';
import 'data/firestore/f_products_model.dart';
import 'data/firestore/services/f_cart_repository.dart';
import 'data/firestore/services/f_product_repository.dart';

class TryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final bloc =
                  FirestoreCartBloc(context.read<FirestoreRepository>());
              bloc.add(LoadCartEvent());
              return bloc;
            },
          ),
          BlocProvider(
            create: (context) {
              final bloc = FirestoreProductsBloc(
                  context.read<FirestoreProductRepository>());
              bloc.add(
                  LoadFirestoreProductsEvent()); // Trigger the event to load products
              return bloc;
            },
          ),
        ],
        child: BlocBuilder<FirestoreCartBloc, FirestoreState>(
          builder: (context, cartState) {
            if (cartState is FirestoreLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (cartState is FirestoreLoaded) {
              // Log the cartState data
              // print('Cart State Loaded: ${cartState.carts}');

              return BlocBuilder<FirestoreProductsBloc, FirestoreProductsState>(
                builder: (context, productState) {
                  if (productState is FirestoreProductsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (productState is FirestoreProductsLoadedState) {
                    // Log the productState data
                    // print('Product State Loaded: ${productState.products}');

                    final carts = cartState.carts;
                    final products = productState.products;

                    return ListView.builder(
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        final cart = carts[index];
                        return ListTile(
                          title: Text('Cart ID: ${cart.id}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: cart.products.map((productQuantity) {
                              // Using firstWhere with a default value
                              final productQuantityProductId =
                                  productQuantity.productId;
                              print(
                                  'Searching for product with ID: $productQuantityProductId');

                              final productId =
                                  productQuantity.productId.toString();

                              final product = products.firstWhere(
                                (p) {
                                  final match = p.id.toString() ==
                                      productId; // Ensure both IDs are strings
                                  if (match) {
                                    print('Product found: ${p.title}');
                                  }
                                  return match;
                                },
                                orElse: () {
                                  print('Product not found, using default');
                                  return FirestoreProductModel(
                                    documentId: 'unknown',
                                    id: 'unknown',
                                    title: 'Unknown Product',
                                    image: '',
                                    description: 'No description',
                                    price: 0.0,
                                    rating: Rating(rate: 0.0, count: 0),
                                    category: 'Unknown',
                                  );
                                },
                              );

                              print('Final product: ${product.title}');

                              print('Final product: ${product.title}');

                              // Log each product being processed
                              print(
                                  'Processing Product: ${product.id}, Title: ${product.title}');

                              return Text(
                                'Product ID: ${product.id}, Title: ${product.title}',
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  } else if (productState is FirestoreProductsErrorState) {
                    return Center(child: Text('Error: ${productState.error}'));
                  } else {
                    return const Center(child: Text('No products available'));
                  }
                },
              );
            } else if (cartState is FirestoreError) {
              return Center(child: Text('Error: ${cartState.error}'));
            } else {
              return const Center(child: Text('No carts available'));
            }
          },
        ),
      ),
    );
  }
}
