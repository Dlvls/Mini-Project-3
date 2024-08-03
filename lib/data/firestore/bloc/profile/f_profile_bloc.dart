import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/f_profile_repository.dart';
import 'f_profile_event.dart';
import 'f_profile_state.dart';

class FirestoreProfileBloc
    extends Bloc<FirestoreProfileEvent, FirestoreProfileState> {
  final FirestoreProfileRepository _firestoreRepository;

  FirestoreProfileBloc(this._firestoreRepository)
      : super(FirestoreProfileInitial()) {
    on<SaveProfileEvent>((event, emit) async {
      emit(FirestoreProfileSaving());
      try {
        await _firestoreRepository.saveProfile(event.profile);
        emit(FirestoreProfileSaved());
      } catch (e) {
        emit(FirestoreProfileError(e.toString()));
      }
    });

    on<LoadProfileEvent>((event, emit) async {
      emit(FirestoreProfileLoading());
      try {
        final profile = await _firestoreRepository.fetchProfile(event.userId);
        emit(FirestoreProfileLoaded(profile));
      } catch (e) {
        emit(FirestoreProfileError(e.toString()));
      }
    });
  }
}
