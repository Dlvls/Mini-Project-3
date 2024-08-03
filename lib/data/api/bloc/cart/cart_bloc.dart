import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/cart/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc(this._cartRepository) : super(CartLoadingState()) {
    on<LoadCartEvent>((event, emit) async {
      emit(CartLoadingState());
      try {
        final cart = await _cartRepository.getCarts();
        emit(CartLoadedState(cart));
      } catch (e) {
        emit(CartErrorState(e.toString()));
      }
    });
  }
}
