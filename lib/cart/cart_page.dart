import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/firestore/bloc/cart/f_cart_bloc.dart';
import '../data/firestore/bloc/cart/f_cart_event.dart';
import '../data/firestore/bloc/cart/f_cart_state.dart';
import '../data/firestore/bloc/products/f_products_bloc.dart';
import '../data/firestore/bloc/products/f_products_event.dart';
import '../data/firestore/bloc/products/f_products_state.dart';
import '../data/firestore/f_cart_model.dart';
import '../data/firestore/f_products_model.dart';
import '../data/firestore/services/f_cart_repository.dart';
import '../data/firestore/services/f_product_repository.dart';
import '../resources/colors.dart';
import '../resources/styles.dart';
import '../utility/checkbox.dart';
import '../utility/counter.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Map<int, bool> _checkedItems = {};
  double _totalPrice = 0.0;

  void _onItemChecked(
      int productId, bool isChecked, double productPrice, int quantity) {
    setState(() {
      _checkedItems[productId] = isChecked;
      if (isChecked) {
        _totalPrice += productPrice * quantity;
      } else {
        _totalPrice -= productPrice * quantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FirestoreCartBloc>(
          create: (context) =>
              FirestoreCartBloc(FirestoreRepository())..add(LoadCartEvent()),
        ),
        BlocProvider<FirestoreProductsBloc>(
          create: (context) => FirestoreProductsBloc(
              FirestoreProductRepository(FirebaseFirestore.instance))
            ..add(LoadFirestoreProductsEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          backgroundColor: secondaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Cart',
            style: Styles.appbarText.copyWith(color: primaryText),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: MultiBlocListener(
                listeners: [
                  BlocListener<FirestoreCartBloc, FirestoreState>(
                    listener: (context, state) {
                      if (state is FirestoreError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Failed to load cart: ${state.error}')),
                        );
                      }
                    },
                  ),
                  BlocListener<FirestoreProductsBloc, FirestoreProductsState>(
                    listener: (context, state) {
                      if (state is FirestoreProductsErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Failed to load products: ${state.error}')),
                        );
                      }
                    },
                  ),
                ],
                child: BlocBuilder<FirestoreCartBloc, FirestoreState>(
                  builder: (context, cartState) {
                    if (cartState is FirestoreLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (cartState is FirestoreError) {
                      return const Center(child: Text("Error"));
                    }
                    if (cartState is FirestoreLoaded) {
                      final cart = cartState.carts.isNotEmpty
                          ? cartState.carts.first
                          : FirestoreCartModel(
                              id: '',
                              userId: '',
                              createdAt: DateTime.now(),
                              products: [],
                            );

                      print('Cart ID: ${cart.id}');

                      if (cart.id.isEmpty) {
                        return const Center(child: Text("Cart not found"));
                      }

                      return BlocBuilder<FirestoreProductsBloc,
                          FirestoreProductsState>(
                        builder: (context, productState) {
                          if (productState is FirestoreProductsLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (productState is FirestoreProductsErrorState) {
                            return const Center(
                                child: Text("Error loading products"));
                          }
                          if (productState is FirestoreProductsLoadedState) {
                            final products = productState.products;
                            List<FirestoreProductQuantity> quantity =
                                cart.products;

                            // Create a map for quick lookup
                            final productMap = {
                              for (var product in products) product.id: product
                            };

                            return Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: quantity.length,
                                    itemBuilder: (context, index) {
                                      final cartProduct = quantity[index];
                                      final product =
                                          productMap[cartProduct.productId] ??
                                              FirestoreProductModel(
                                                documentId: '',
                                                id: '0',
                                                title: 'Unknown',
                                                image: '',
                                                description: '',
                                                price: 0.0,
                                                rating:
                                                    Rating(rate: 0.0, count: 0),
                                                category: '',
                                              );

                                      print('Product ID: ${product.id}');
                                      print('Product Title: ${product.title}');
                                      print('Product Price: ${product.price}');
                                      print(
                                          'Product Category: ${product.category}');
                                      print('Product Image: ${product.image}');
                                      print(
                                          'Product Description: ${product.description}');

                                      return ListTile(
                                        title: DefaultTextStyle(
                                          style: Styles.title
                                              .copyWith(color: primaryText),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CheckboxApp(
                                                onChanged: (isChecked) {
                                                  _onItemChecked(
                                                    cartProduct.productId,
                                                    isChecked,
                                                    product.price,
                                                    cartProduct.quantity,
                                                  );
                                                },
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: product
                                                          .image.isNotEmpty
                                                      ? Image.network(
                                                          product.image,
                                                          fit: BoxFit.contain,
                                                        )
                                                      : Image.asset(
                                                          "assets/images/shirt.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(product.title,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    const SizedBox(height: 8),
                                                    Text(product.category,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                    const SizedBox(height: 16),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            '\$${product.price}',
                                                            style: const TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        const Spacer(),
                                                        CounterWidget(
                                                            initialQuantity:
                                                                cartProduct
                                                                    .quantity),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Total Price',
                                            style: Styles.title.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: secondaryText,
                                            ),
                                          ),
                                          Text(
                                            '\$${_totalPrice.toStringAsFixed(2)}',
                                            style: Styles.title.copyWith(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context.push('/checkout',
                                                extra: _totalPrice);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            minimumSize:
                                                const Size(double.infinity, 45),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            'Checkout',
                                            style: Styles.title
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return const Center(
                              child: Text("Failed to load products"));
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
