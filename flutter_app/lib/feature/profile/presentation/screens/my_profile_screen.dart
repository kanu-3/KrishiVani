import 'package:Krishivani/core/constants/assets_paths.dart';
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

class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                child: AppNetworkImage(
                    imageUrl: '',
                  height: 80,
                  width: 80,
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