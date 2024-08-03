import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniproject3/data/firestore/bloc/profile/f_profile_event.dart';

import '../data/firestore/bloc/profile/f_profile_bloc.dart';
import '../data/firestore/bloc/profile/f_profile_state.dart';
import '../data/storage/profile_image_cubit.dart';
import '../data/storage/profile_image_state.dart';
import '../resources/colors.dart';
import '../resources/styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Assuming you have the user ID
    const userId = "3";
    context.read<FirestoreProfileBloc>().add(LoadProfileEvent(userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: primaryText,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Profile',
          style: Styles.appbarText,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await pickImage();
            },
            icon: const Icon(Icons.edit),
            color: primaryText,
          ),
        ],
      ),
      body: BlocBuilder<FirestoreProfileBloc, FirestoreProfileState>(
        builder: (context, profileState) {
          if (profileState is FirestoreProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (profileState is FirestoreProfileLoaded) {
            final profile = profileState.profile;

            return SingleChildScrollView(
              child: Container(
                color: secondaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey.shade200,
                            child: BlocBuilder<ProfileImageCubit,
                                ProfileImageState>(
                              builder: (context, imageState) {
                                if (imageState.isLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (imageState.profileImageUrl == null) {
                                  return Image.asset(
                                    "assets/images/profile_image.jpg",
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Image.network(
                                    imageState.profileImageUrl!,
                                    fit: BoxFit.cover,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${profile.name.firstname} ${profile.name.lastname}",
                                style: Styles.title,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                profile.username,
                                style: Styles.subtitle
                                    .copyWith(color: secondaryText),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    profile.address.city,
                                    style: Styles.title.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    Row(
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(width: 8.0),
                        Text(profile.email, style: Styles.subtitle),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.phone),
                        const SizedBox(width: 8.0),
                        Text(
                          profile.phone,
                          style: Styles.subtitle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(Icons.home),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            '${profile.address.street} ${profile.address.number}, ${profile.address.zipcode}',
                            style: Styles.subtitle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add functionality if needed
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: Styles.title.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (profileState is FirestoreProfileError) {
            return Center(child: Text(profileState.error));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      context.read<ProfileImageCubit>().uploadProfileImage(path: image!.path);
    }
  }
}
