import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_image_state.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit() : super(const ProfileImageState());

  Future<void> uploadProfileImage({required String path}) async {
    final imageRef = FirebaseStorage.instance.ref().child('profile_images');

    try {
      emit(const ProfileImageState(isLoading: true));

      final randomID = "${Random().nextInt(99) * 256}";
      final uploadTask = imageRef.child(randomID).putFile(File(path));

      uploadTask.snapshotEvents.listen((event) {
        switch (event.state) {
          case TaskState.running:
            final progress = event.bytesTransferred / event.totalBytes;
            emit(
              ProfileImageState(
                isLoading: true,
                uploadProgress: progress,
              ),
            );
            break;
          case TaskState.success:
            event.ref.getDownloadURL().then((value) => emit(
                  ProfileImageState(
                    isLoading: false,
                    profileImageUrl: value,
                  ),
                ));
            break;
          case TaskState.error:
            emit(ProfileImageState(errorMessage: event.toString()));
            break;
          case TaskState.canceled:
          case TaskState.paused:
            break;
        }
      });
    } catch (e) {
      emit(ProfileImageState(errorMessage: e.toString()));
    }
  }
}
