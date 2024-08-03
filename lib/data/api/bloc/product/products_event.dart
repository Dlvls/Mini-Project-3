import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class LoadProductsEvent extends ProductsEvent {
  @override
  List<Object?> get props => [];
}
