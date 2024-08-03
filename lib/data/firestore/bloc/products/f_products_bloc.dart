import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/f_product_repository.dart';
import 'f_products_event.dart';
import 'f_products_state.dart';

class FirestoreProductsBloc
    extends Bloc<FirestoreProductsEvent, FirestoreProductsState> {
  final FirestoreProductRepository firestoreProductRepository;

  FirestoreProductsBloc(this.firestoreProductRepository)
      : super(FirestoreProductsLoadingState()) {
    on<LoadFirestoreProductsEvent>((event, emit) async {
      emit(FirestoreProductsLoadingState());
      try {
        final products = await firestoreProductRepository.fetchProducts();
        emit(FirestoreProductsLoadedState(products));
      } catch (e) {
        emit(FirestoreProductsErrorState(e.toString()));
      }
    });

    on<MigrateProductsEvent>((event, emit) async {
      emit(FirestoreProductsUploadingState());
      try {
        await firestoreProductRepository.uploadProducts(event.products);
        emit(FirestoreProductsUploadedState());
      } catch (e) {
        emit(FirestoreProductsErrorState(e.toString()));
      }
    });
  }
}
