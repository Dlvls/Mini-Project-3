import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/profile/profile_model.dart';

@immutable
abstract class ProfileState extends Equatable {}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadedState extends ProfileState {
  final ProfileModel user;

  ProfileLoadedState(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
