import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  final int userId;

  LoadProfileEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
