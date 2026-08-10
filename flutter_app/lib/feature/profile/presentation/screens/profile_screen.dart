import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/buttons/app_elevated_button.dart';
import 'package:Krishivani/core/widgets/common/app_header.dart';
import 'package:Krishivani/core/widgets/dialogs/confirm_dialog.dart';
import 'package:Krishivani/feature/profile/data/models/profile_model.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/account_tile.dart';
import 'package:Krishivani/feature/profile/presentation/widgets/profile_header.dart';
import 'package:Krishivani/feature/profile/providers/profile_state.dart';
import 'package:Krishivani/feature/profile/providers/proflie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(profileProvider.notifier).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final profile = state.profile;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(
        title: 'Profile',
        showBackButton: true,
      ),
      body: buildBody(context, state, profile),
      // body: const Center(
      //   child: Text('Profile'),
      // ),
    );
  }

  Widget buildBody(
      BuildContext context,
      ProfileState state,
      ProfileModel? profile,
      ) {
    if (state.isLoading && profile == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (profile == null) {
      return Center(
        child: AppElevatedButton(
          text: 'Retry',
          onPressed: () {
            ref.read(profileProvider.notifier).loadProfile();
          },
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () {
        return ref.read(profileProvider.notifier).loadProfile();
      },
      child: Padding(
        padding: context.bodypad,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                profile: profile,
                onEdit: () {
                  context.push(RoutePaths.myProfile);
                },
              ),

              SizedBox(height: context.spacingL),

              Text(
                'Account',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.blacktext,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: context.spacingXS),

              AccountTile(
                title: 'My Profile',
                leading: Icon(
                  AssetPaths.person,
                  color: AppColors.blacktext,
                ),
                onTap: () {
                  context.push(RoutePaths.myProfile);
                },
              ),

              AccountTile(
                title: 'Model Settings',
                leading: Icon(
                  AssetPaths.filter,
                  color: AppColors.blacktext,
                ),
                onTap: () {
                  context.push(RoutePaths.modelSettings);
                },
              ),

              AccountTile(
                title: 'Location',
                leading: Icon(
                  AssetPaths.address,
                  color: AppColors.blacktext,
                ),
                onTap: () {},
              ),

              AccountTile(
                title: 'Language',
                leading: Icon(
                  AssetPaths.language,
                  color: AppColors.blacktext,
                ),
                onTap: () {},

              ),

              SizedBox(height: context.spacingM),

              Text(
                'Your Activity',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.blacktext,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: context.spacingS),

              AccountTile(
                title: 'Diagnosis History',
                leading: Icon(
                  AssetPaths.bio,
                  color: AppColors.blacktext,
                ),
                onTap: () {
                  context.push(RoutePaths.history);
                },
              ),

              AccountTile(
                title: 'Saved Market Analysis',
                leading: Icon(
                  AssetPaths.bookmark_outline,
                  color: AppColors.blacktext,
                ),
                onTap: () {},
              ),

              SizedBox(height: context.spacingM),

              Text(
                'Support',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.blacktext,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: context.spacingS),

              AccountTile(
                title: 'Privacy Policy',
                leading: Icon(
                  AssetPaths.lock,
                  color: AppColors.blacktext,
                ),
                onTap: () {},
              ),

              AccountTile(
                title: 'Terms & Conditions',
                leading: Icon(
                  AssetPaths.wallet,
                  color: AppColors.blacktext,
                ),
                onTap: () {},
              ),

              AccountTile(
                title: 'Settings',
                leading: Icon(
                  AssetPaths.settings,
                  color: AppColors.blacktext,
                ),
                onTap: () {},
              ),

              AccountTile(
                title: 'Help Center',
                leading: Icon(
                  AssetPaths.help,
                  color: AppColors.blacktext,
                ),
                onTap: () {},
              ),

              // SizedBox(height: context.spacingM),

              AccountTile(
                title: 'Logout',
                leading: Icon(
                  AssetPaths.logout,
                  color: AppColors.blacktext,
                ),
                onTap: logout,
              ),

              SizedBox(height: context.spacingL),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout() async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      cancelText: 'Cancel',
      confirmText: 'Logout',
    );

    if (confirmed != true || !mounted) {
      return;
    }

    await Supabase.instance.client.auth.signOut();

    if (!mounted) {
      return;
    }

    context.go(RoutePaths.login);
  }
}