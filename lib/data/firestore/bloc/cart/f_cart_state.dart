// lib/data/firestore/bloc/cart/f_cart_state.dart

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../f_cart_model.dart';

@immutable
abstract class FirestoreState extends Equatable {
  const FirestoreState();

  @override
  List<Object> get props => [];
}

class FirestoreInitial extends FirestoreState {}

class FirestoreSaving extends FirestoreState {}

class FirestoreSaved extends FirestoreState {}

class FirestoreLoading extends FirestoreState {}

class FirestoreLoaded extends FirestoreState {
  final List<FirestoreCartModel> carts;

  FirestoreLoaded(this.carts);

  @override
  List<Object> get props => [carts];
}

class FirestoreError extends FirestoreState {
  final String error;

  FirestoreError(this.error);

  @override
  List<Object> get props => [error];
}
