import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/constants/core_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/common/app_header.dart';
import 'package:Krishivani/core/widgets/common/app_network_image.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/address_edit_overlay.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/profile_details_tile.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/profiles_edit_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../providers/proflie_provider.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends ConsumerStatefulWidget {
  const MyProfileScreen({super.key});

  @override
  ConsumerState<MyProfileScreen> createState() => MyProfileScreenState();
}

class MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProfileImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile == null) {
        return;
      }

      final imageBytes = await pickedFile.readAsBytes();

      final success = await ref
          .read(profileProvider.notifier)
          .uploadProfilePicture(imageBytes);

      if (!mounted) {
        return;
      }

      if (!success) {
        final error = ref.read(profileProvider).error;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error ?? 'Failed to upload profile picture.',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to upload image: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final profile = state.profile;

    if (profile == null) {
      return Scaffold(
        backgroundColor: AppColors.main,
        appBar: const AppHeader(
          title: 'My Profile',
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.main,
      appBar: const AppHeader(
        title: 'My Profile',
      ),
      body: Padding(
        padding: context.bodypad,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: state.isUpdating
                      ? null
                      : _pickProfileImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child: profile.avatarUrl != null &&
                            profile.avatarUrl!.isNotEmpty
                            ? AppNetworkImage(
                          imageUrl: profile.avatarUrl!,
                          height: 80,
                          width: 80,
                        )
                            : Container(
                          height: 80,
                          width: 80,
                          color: CoreColors.grey200,
                          alignment: Alignment.center,
                          child: Icon(
                            AssetPaths.person,
                            size: 36,
                            color: CoreColors.grey500,
                          ),
                        ),
                      ),

                      if (state.isUpdating)
                        Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              context.gapL,

              ProfileDetailTile(
                label: 'Username',
                value: profile.username,
                leadingIcon: Icon(
                  AssetPaths.person,
                ),
                onTap: () {
                  ProfileEditOverlay.show(
                    context,
                    title: 'Username',
                    initialValue: profile.username,
                    column: 'username',
                    onSave: ({
                      required String column,
                      required dynamic value,
                    }) {
                      return ref
                          .read(profileProvider.notifier)
                          .updateProfile(
                        column: column,
                        value: value,
                      );
                    },
                  );
                },
              ),

              ProfileDetailTile(
                label: 'Name',
                value: profile.name,
                leadingIcon: Icon(
                  AssetPaths.person,
                ),
                onTap: () {
                  ProfileEditOverlay.show(
                    context,
                    title: 'Name',
                    initialValue: profile.name,
                    column: 'name',
                    onSave: ({
                      required String column,
                      required dynamic value,
                    }) {
                      return ref
                          .read(profileProvider.notifier)
                          .updateProfile(
                        column: column,
                        value: value,
                      );
                    },
                  );
                },
              ),

              ProfileDetailTile(
                label: 'Email',
                value: profile.email,
                leadingIcon: Icon(
                  AssetPaths.mail,
                ),
                onTap: () {
                  // Email is managed through Supabase Auth.
                },
              ),

              ProfileDetailTile(
                label: 'Phone',
                value: profile.phone?.isNotEmpty == true
                    ? profile.phone!
                    : 'Add phone number',
                leadingIcon: Icon(
                  AssetPaths.mobile,
                ),
                onTap: () {
                  ProfileEditOverlay.show(
                    context,
                    title: 'Phone',
                    initialValue: profile.phone ?? '',
                    column: 'phone',
                    onSave: ({
                      required String column,
                      required dynamic value,
                    }) {
                      return ref
                          .read(profileProvider.notifier)
                          .updateProfile(
                        column: column,
                        value: value,
                      );
                    },
                  );
                },
              ),

              ProfileDetailTile(
                label: 'Address',
                value: profile.address?.isNotEmpty == true
                    ? profile.address!
                    : 'Add your address',
                leadingIcon: Icon(
                  AssetPaths.lock,
                ),
                onTap: () {
                  AddressEditOverlay.show(
                    context,
                    initialAddress: profile.address ?? '',
                    onSave: ({
                      required String column,
                      required dynamic value,
                    }) {
                      return ref
                          .read(profileProvider.notifier)
                          .updateProfile(
                        column: column,
                        value: value,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}