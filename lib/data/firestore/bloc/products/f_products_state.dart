import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:miniproject3/data/firestore/f_products_model.dart';

@immutable
abstract class FirestoreProductsState extends Equatable {
  const FirestoreProductsState();
}

class FirestoreProductsLoadingState extends FirestoreProductsState {
  @override
  List<Object?> get props => [];
}

class FirestoreProductsLoadedState extends FirestoreProductsState {
  final List<FirestoreProductModel> products;

  const FirestoreProductsLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}

class FirestoreProductsErrorState extends FirestoreProductsState {
  final String error;

  const FirestoreProductsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class FirestoreProductsUploadingState extends FirestoreProductsState {
  @override
  List<Object?> get props => [];
}

class FirestoreProductsUploadedState extends FirestoreProductsState {
  @override
  List<Object?> get props => [];
}
