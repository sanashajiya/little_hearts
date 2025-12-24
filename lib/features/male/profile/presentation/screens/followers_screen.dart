import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../../../../core/widgets/bottom_navigation_bar.dart';

class FollowersScreen extends StatelessWidget {
  final String type; // 'followers' or 'following'

  const FollowersScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);
    final isFollowers = type == 'followers';

    // Dummy data
    final users = [
      {'name': 'Revanth', 'avatar': 'assets/images/story1.png'},
      {'name': 'David Wayne', 'avatar': 'assets/images/story2.png'},
      {'name': 'Edward Davidson', 'avatar': 'assets/images/story3.png'},
      {'name': 'Sarah Johnson', 'avatar': 'assets/images/story4.png'},
      {'name': 'Michael Brown', 'avatar': 'assets/images/story5.png'},
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.dark.withOpacity(0.9), theme.light.withOpacity(0.01)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.black,
                        size: 20,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    Expanded(
                      child: Center(
                        child: CustomText(
                          text: 'Revanth, 26',
                          fontSize: 18,
                          fontWeight: FontWeightType.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // Balance
                  ],
                ),
              ),
              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!isFollowers) {
                            context.replace(
                              '/followers',
                              extra: {'type': 'followers'},
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isFollowers
                                    ? theme.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: CustomText(
                              text: '${users.length} Followers',
                              fontSize: 14,
                              fontWeight: FontWeightType.bold,
                              color: isFollowers
                                  ? AppColors.black
                                  : AppColors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (isFollowers) {
                            context.replace(
                              '/followers',
                              extra: {'type': 'following'},
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: !isFollowers
                                    ? theme.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: CustomText(
                              text: '100 Following',
                              fontSize: 14,
                              fontWeight: FontWeightType.bold,
                              color: !isFollowers
                                  ? AppColors.black
                                  : AppColors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // List
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [theme.light, AppColors.backgroundLight],
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // border: Border.all(
                                //   color: theme.primary.withOpacity(0.3),
                                //   width: 2,
                                // ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  user['avatar'] as String,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomText(
                                text: user['name'] as String,
                                fontSize: 16,
                                fontWeight: FontWeightType.medium,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: theme.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CustomText(
                                text: isFollowers ? 'Remove' : 'Follow Back',
                                fontSize: 14,
                                fontWeight: FontWeightType.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const AppBottomNavigationBar(selectedItem: BottomNavItem.profile),
            ],
          ),
        ),
      ),
    );
  }
}
