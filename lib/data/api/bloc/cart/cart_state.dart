import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/cart/cart_model.dart';

@immutable
abstract class CartState extends Equatable {}

class CartLoadingState extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoadedState extends CartState {
  final List<Cart> carts;

  CartLoadedState(this.carts);

  @override
  List<Object?> get props => [carts];
}

class CartErrorState extends CartState {
  final String error;

  CartErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
