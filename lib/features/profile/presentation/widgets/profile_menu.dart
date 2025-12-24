import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import 'profile_menu_item.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
        color: AppColors.white,
        size: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'share',
          child: ProfileMenuItem(
            icon: Icons.share,
            label: 'Share Profile',
          ),
        ),
        const PopupMenuItem(
          value: 'edit',
          child: ProfileMenuItem(
            icon: Icons.edit,
            label: 'Edit Profile',
          ),
        ),
        const PopupMenuItem(
          value: 'blocked',
          child: ProfileMenuItem(
            icon: Icons.block,
            label: 'Blocked Users',
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: ProfileMenuItem(
            icon: Icons.delete_outline,
            label: 'Delete Account',
          ),
        ),
        const PopupMenuItem(
          value: 'help',
          child: ProfileMenuItem(
            icon: Icons.help_outline,
            label: 'Help & Support',
          ),
        ),
        const PopupMenuItem(
          value: 'terms',
          child: ProfileMenuItem(
            icon: Icons.description_outlined,
            label: 'Terms & Conditions',
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'edit':
            context.push('/edit-profile');
            break;
          case 'blocked':
            context.push('/blocked-users');
            break;
          case 'terms':
            context.push('/terms-conditions');
            break;
          default:
            break;
        }
      },
    );
  }
}

