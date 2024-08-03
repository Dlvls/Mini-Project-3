import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../f_profile_model.dart';

@immutable
abstract class FirestoreProfileEvent extends Equatable {
  const FirestoreProfileEvent();

  @override
  List<Object> get props => [];
}

class SaveProfileEvent extends FirestoreProfileEvent {
  final FirestoreProfileModel profile;

  SaveProfileEvent(this.profile);

  @override
  List<Object> get props => [profile];
}

class LoadProfileEvent extends FirestoreProfileEvent {
  final String userId;

  LoadProfileEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
