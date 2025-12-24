import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/blocked_users_cubit.dart';
import '../widgets/blocked_user_tile.dart';

class BlockedUsersScreen extends StatelessWidget {
  const BlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlockedUsersCubit(),
      child: const _BlockedUsersView(),
    );
  }
}

class _BlockedUsersView extends StatelessWidget {
  const _BlockedUsersView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5, 
        shadowColor: Colors.white.withOpacity(0.8),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: const CustomText(
          text: 'Blocked Users',
          fontSize: 18,
          fontWeight: FontWeightType.bold,
          color: AppColors.textPrimary,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<BlockedUsersCubit, BlockedUsersState>(
        builder: (context, state) {
          if (state is BlockedUsersLoaded) {
            if (state.users.isEmpty) {
              return Center(
                child: CustomText(
                  text: 'No blocked users',
                  fontSize: 16,
                  fontWeight: FontWeightType.medium,
                  color: AppColors.textSecondary,
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return BlockedUserTile(
                  name: user.name,
                  avatar: user.avatar,
                  onUnblock: () {
                    context.read<BlockedUsersCubit>().unblockUser(user.name);
                  },
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

