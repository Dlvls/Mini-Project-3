import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/profile/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileLoadingState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final profile = await _profileRepository.getProfile(event.userId);
        emit(ProfileLoadedState(profile));
      } catch (e) {
        emit(ProfileErrorState(e.toString()));
      }
    });
  }
}
