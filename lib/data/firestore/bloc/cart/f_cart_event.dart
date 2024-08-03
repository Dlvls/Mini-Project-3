// lib/data/firestore/bloc/cart/f_cart_event.dart

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../f_cart_model.dart';

@immutable
abstract class FirestoreEvent extends Equatable {
  const FirestoreEvent();

  @override
  List<Object> get props => [];
}

class SaveCartEvent extends FirestoreEvent {
  final FirestoreCartModel cart;

  SaveCartEvent(this.cart);

  @override
  List<Object> get props => [cart];
}

class LoadCartEvent extends FirestoreEvent {}
