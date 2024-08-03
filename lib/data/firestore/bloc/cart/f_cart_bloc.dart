// lib/data/firestore/bloc/cart/f_cart_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/f_cart_repository.dart';
import 'f_cart_event.dart';
import 'f_cart_state.dart';

class FirestoreCartBloc extends Bloc<FirestoreEvent, FirestoreState> {
  final FirestoreRepository _firestoreRepository;

  FirestoreCartBloc(this._firestoreRepository) : super(FirestoreInitial()) {
    on<SaveCartEvent>((event, emit) async {
      emit(FirestoreSaving());
      try {
        await _firestoreRepository.saveCart(event.cart);
        emit(FirestoreSaved());
      } catch (e) {
        emit(FirestoreError(e.toString()));
      }
    });

    on<LoadCartEvent>((event, emit) async {
      emit(FirestoreLoading());
      try {
        final carts = await _firestoreRepository.fetchCarts();
        emit(FirestoreLoaded(carts));
      } catch (e) {
        emit(FirestoreError(e.toString()));
      }
    });
  }
}
