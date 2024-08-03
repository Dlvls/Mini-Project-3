import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/product/product_model.dart';

@immutable
abstract class ProductsState extends Equatable {}

class ProductsLoadingState extends ProductsState {
  @override
  List<Object?> get props => [];
}

class ProductsLoadedState extends ProductsState {
  final List<ProductModel> products;

  ProductsLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductsErrorState extends ProductsState {
  final String error;

  ProductsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
