import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../constants/custom_text.dart';
import '../cubit/zone_cubit.dart';
import '../theme/app_colors.dart';
import '../theme/zone_theme.dart';

enum BottomNavItem { home, explore, makeAFriend, recents, profile }

class AppBottomNavigationBar extends StatelessWidget {
  final BottomNavItem selectedItem;

  const AppBottomNavigationBar({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);

    return Container(
      height: 95,
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              _navItem(
                icon: Icons.home_outlined,
                label: 'Home',
                isSelected: selectedItem == BottomNavItem.home,
                onTap: () => context.go('/home'),
              ),
              const SizedBox(width: 42),
              _navItem(
                icon: Icons.explore_outlined,
                label: 'Explore',
                isSelected: selectedItem == BottomNavItem.explore,
                onTap: () => context.go('/explore'),
              ),
              const SizedBox(width: 105),
              _navItem(
                icon: Icons.history,
                label: 'Recents',
                isSelected: selectedItem == BottomNavItem.recents,
                onTap: () => context.go('/recents'),
              ),
              const SizedBox(width: 35),
              _navItem(
                icon: Icons.person_outline,
                label: 'Profile',
                isSelected: selectedItem == BottomNavItem.profile,
                onTap: () {
                  // TODO: Navigate to profile
                },
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            child: GestureDetector(
              onTap: () {
                if (selectedItem == BottomNavItem.makeAFriend) {
                  return; // already on this screen, do nothing
                }

                context.push('/make-a-friend', extra: mode);
              },
              child: Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: selectedItem == BottomNavItem.makeAFriend
                      ? zoneTheme.primary
                      : zoneTheme.light,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: selectedItem == BottomNavItem.makeAFriend
                          ? zoneTheme.dark
                          : zoneTheme.light,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        mode == ZoneMode.date
                            ? 'assets/icons/plan_a_date.png'
                            : 'assets/icons/make_a_frnd.png',
                      ),
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(height: 2),
                    CustomText(
                      text: mode == ZoneMode.date
                          ? 'Plan a Date'
                          : 'Make a Frd',
                      fontSize: 9,
                      fontWeight: FontWeightType.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Builder(
      builder: (context) {
        final mode = context.watch<ZoneCubit>().state;
        final zoneTheme = ZoneTheme.fromMode(mode);
        final color = isSelected ? zoneTheme.primary : AppColors.textSecondary;
        return GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 2),
              CustomText(
                text: label,
                fontSize: 10,
                fontWeight: FontWeightType.medium,
                color: color,
              ),
            ],
          ),
        );
      },
    );
  }
}
