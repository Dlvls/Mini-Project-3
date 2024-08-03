import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../data/api/bloc/cart/cart_bloc.dart';
import '../data/api/bloc/cart/cart_event.dart';
import '../data/api/services/cart/cart_repository.dart';
import '../resources/colors.dart';
import '../resources/styles.dart';

class ShippingPage extends StatelessWidget {
  final double totalPrice;

  const ShippingPage({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (BuildContext context) =>
              CartBloc(CartRepository())..add(LoadCartEvent()),
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
            'Shipping',
            style: Styles.appbarText.copyWith(color: primaryText),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Card(
                        elevation: 0,
                        color: cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 30,
                                    child: Image.asset('assets/images/jne.png'),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'JNE Express',
                                    style: Styles.title
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Shipped in 2-4 days',
                                    style: Styles.title.copyWith(
                                        fontSize: 12, color: secondaryText),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  '\$${(totalPrice).toStringAsFixed(2)}',
                                  style: Styles.title.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Card(
                        elevation: 0,
                        color: cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 30,
                                    child: Image.asset('assets/images/jnt.png'),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'JNT Express',
                                    style: Styles.title
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Shipped in 4-5 days',
                                    style: Styles.title.copyWith(
                                        fontSize: 12, color: secondaryText),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  '\$${(totalPrice).toStringAsFixed(2)}',
                                  style: Styles.title.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: () {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('Select Shipping pressed')),
                  // );
                  context.push('/checkout');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: Styles.title.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
