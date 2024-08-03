import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../f_profile_model.dart';

@immutable
abstract class FirestoreProfileState extends Equatable {
  const FirestoreProfileState();

  @override
  List<Object> get props => [];
}

class FirestoreProfileInitial extends FirestoreProfileState {}

class FirestoreProfileSaving extends FirestoreProfileState {}

class FirestoreProfileSaved extends FirestoreProfileState {}

class FirestoreProfileLoading extends FirestoreProfileState {}

class FirestoreProfileLoaded extends FirestoreProfileState {
  final FirestoreProfileModel profile;

  FirestoreProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class FirestoreProfileError extends FirestoreProfileState {
  final String error;

  FirestoreProfileError(this.error);

  @override
  List<Object> get props => [error];
}
