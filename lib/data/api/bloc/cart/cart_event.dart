import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class LoadCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}
