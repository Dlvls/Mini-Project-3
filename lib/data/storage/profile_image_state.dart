import 'package:equatable/equatable.dart';

class ProfileImageState extends Equatable {
  final String? profileImageUrl;
  final bool isLoading;
  final double uploadProgress;
  final String errorMessage;

  const ProfileImageState({
    this.profileImageUrl,
    this.isLoading = false,
    this.uploadProgress = 0,
    this.errorMessage = "",
  });

  @override
  List<Object?> get props =>
      [profileImageUrl, isLoading, uploadProgress, errorMessage];
}
