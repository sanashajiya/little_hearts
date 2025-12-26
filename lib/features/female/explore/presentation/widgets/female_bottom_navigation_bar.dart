import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';

enum FemaleBottomNavItem { home, explore, goOnline, credits, profile }

class FemaleBottomNavigationBar extends StatelessWidget {
  final FemaleBottomNavItem selectedItem;

  const FemaleBottomNavigationBar({
    super.key,
    required this.selectedItem,
  });

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
                isSelected: selectedItem == FemaleBottomNavItem.home,
                onTap: () => context.go('/home'),
                zoneTheme: zoneTheme,
              ),
              const SizedBox(width: 42),
              _navItem(
                icon: Icons.explore_outlined,
                label: 'Explore',
                isSelected: selectedItem == FemaleBottomNavItem.explore,
                onTap: () => context.go('/female/explore'),
                zoneTheme: zoneTheme,
              ),
              const SizedBox(width: 105),
              _navItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Credits',
                isSelected: selectedItem == FemaleBottomNavItem.credits,
                onTap: () {
                  // TODO: Navigate to credits screen when implemented
                  // context.go('/credits');
                },
                zoneTheme: zoneTheme,
              ),
              const SizedBox(width: 35),
              _navItem(
                icon: Icons.person_outline,
                label: 'Profile',
                isSelected: selectedItem == FemaleBottomNavItem.profile,
                onTap: () {
                  // TODO: Navigate to profile screen when implemented
                  // context.go('/profile_screen');
                },
                // onTap: () => context.go('/profile_screen'),
                zoneTheme: zoneTheme,
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            child: GestureDetector(
              onTap: () {
                if (selectedItem == FemaleBottomNavItem.goOnline) {
                  return; // already on this screen, do nothing
                }
                // TODO: Navigate to Go Online screen when implemented
                // context.push('/go-online', extra: mode);
              },
              child: Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: selectedItem == FemaleBottomNavItem.goOnline
                      ? zoneTheme.primary
                      : zoneTheme.light,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: selectedItem == FemaleBottomNavItem.goOnline
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
                    Icon(
                      Icons.favorite,
                      size: 36,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 2),
                    CustomText(
                      text: 'Go Online',
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
    required ZoneTheme zoneTheme,
  }) {
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
  }
}


