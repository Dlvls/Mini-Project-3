import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject3/data/api/bloc/auth/auth_bloc.dart';
import 'package:miniproject3/data/api/bloc/cart/cart_bloc.dart';
import 'package:miniproject3/data/api/bloc/product/products_bloc.dart';
import 'package:miniproject3/data/api/services/product/product_repository.dart';
import 'package:miniproject3/data/storage/profile_image_cubit.dart';
import 'package:miniproject3/firebase_options.dart';
import 'package:miniproject3/router.dart';
import 'package:miniproject3/utility/helper/fcm_helper.dart';
import 'package:miniproject3/utility/helper/notification_helper.dart';
import 'package:miniproject3/utility/helper/push_notification_helper.dart';

import 'data/api/bloc/cart/cart_event.dart';
import 'data/api/bloc/product/products_event.dart';
import 'data/api/services/cart/cart_repository.dart';
import 'data/firestore/bloc/cart/f_cart_bloc.dart';
import 'data/firestore/bloc/products/f_products_bloc.dart';
import 'data/firestore/bloc/profile/f_profile_bloc.dart';
import 'data/firestore/services/f_cart_repository.dart';
import 'data/firestore/services/f_product_repository.dart';
import 'data/firestore/services/f_profile_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationHelper.initLocalNotification();
  await PushNotificationHelper().initLocalNotifications();
  await FcmHelper().init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CartRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(),
        ),
        RepositoryProvider(
          create: (context) => FirestoreProductRepository(firestore),
        ),
        RepositoryProvider(
          create: (context) => FirestoreRepository(),
        ),
        RepositoryProvider(
          create: (context) => FirestoreProfileRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<CartBloc>(
            create: (context) =>
                CartBloc(RepositoryProvider.of<CartRepository>(context))
                  ..add(LoadCartEvent()),
          ),
          BlocProvider(
            create: (context) =>
                ProductsBloc(RepositoryProvider.of<ProductRepository>(context))
                  ..add(LoadProductsEvent()),
          ),
          BlocProvider(
            create: (context) => FirestoreProductsBloc(
                RepositoryProvider.of<FirestoreProductRepository>(context)),
          ),
          BlocProvider(
            create: (context) => FirestoreCartBloc(
                RepositoryProvider.of<FirestoreRepository>(context)),
          ),
          BlocProvider(
            create: (context) => FirestoreProfileBloc(
                RepositoryProvider.of<FirestoreProfileRepository>(context)),
          ),
          BlocProvider(
            create: (context) => ProfileImageCubit(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: createRouter(),
        ),
      ),
    );
  }
}
