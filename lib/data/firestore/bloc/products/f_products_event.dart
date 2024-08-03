import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:miniproject3/data/firestore/f_products_model.dart';

@immutable
abstract class FirestoreProductsEvent extends Equatable {
  const FirestoreProductsEvent();
}

class MigrateProductsEvent extends FirestoreProductsEvent {
  final List<FirestoreProductModel> products;

  const MigrateProductsEvent(this.products);

  @override
  List<Object?> get props => [products];
}

class LoadFirestoreProductsEvent extends FirestoreProductsEvent {
  @override
  List<Object?> get props => [];
}
