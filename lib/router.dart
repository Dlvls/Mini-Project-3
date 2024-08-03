import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miniproject3/products/detail/detail_page.dart';
import 'package:miniproject3/products/home_page.dart';
import 'package:miniproject3/profile/profile_page.dart';

import 'auth/login_page.dart';
import 'auth/register_page.dart';
import 'cart/cart_page.dart';
import 'cart/check_out_page.dart';
import 'cart/confirm_order.dart';
import 'cart/shipping_page.dart';
import 'cart/transfer.dart';
import 'try.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/detail/:id',
        builder: (context, state) {
          final idString = state.pathParameters['id'];
          if (idString == null) {
            return const Scaffold(
              body: Center(child: Text('Invalid product ID')),
            );
          }

          return DetailPage(productId: idString);
        },
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) {
          final totalPrice = state.extra as double? ?? 0.0;
          return CheckOutPage(totalPrice: totalPrice);
        },
      ),
      GoRoute(
        path: '/transfer',
        builder: (context, state) {
          final double totalPrice = (state.extra
                  as Map<String, dynamic>?)?['totalPrice'] as double? ??
              0.0;
          return TransferPage(totalPrice: totalPrice);
        },
      ),
      GoRoute(
        path: '/shipping',
        builder: (context, state) {
          final totalPrice = state.extra as double? ?? 0.0;
          return ShippingPage(totalPrice: totalPrice);
        },
      ),
      GoRoute(
        path: '/confirm_order',
        builder: (context, state) => const ConfirmOrder(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/try',
        builder: (context, state) => TryPage(),
      ),
    ],
  );
}
