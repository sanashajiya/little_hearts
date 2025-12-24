import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/zone_theme.dart';
import '../../../../core/cubit/zone_cubit.dart';
import '../bloc/make_a_friend_bloc.dart';
import '../bloc/make_a_friend_event.dart';
import '../bloc/make_a_friend_state.dart';
import '../../domain/entities/friend_avatar.dart';
import 'package:go_router/go_router.dart';


class MakeAFriendAppBar extends StatelessWidget {
  final VoidCallback? onBack;

  const MakeAFriendAppBar({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final title =
        mode == ZoneMode.date ? 'Plan a Date' : 'Make a Friend';

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: onBack ??
                    () {
                      // 🔑 Clear stack and go to Explore
                      context.go('/explore', extra: mode);
                    },
              ),
              Expanded(
                child: Center(
                  child: CustomText(
                    text: title,
                    fontSize: 18,
                    fontWeight: FontWeightType.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 40), // Balance the back button
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<MakeAFriendBloc, MakeAFriendState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab(
                    context: context,
                    label: 'GIcons',
                    isSelected: state.selectedCategory == FriendCategory.gicons,
                    onTap: () {
                      context.read<MakeAFriendBloc>().add(
                            const TabSwitched(FriendCategory.gicons),
                          );
                    },
                  ),
                  const SizedBox(width: 24),
                  _buildTab(
                    context: context,
                    label: 'GStars',
                    isSelected: state.selectedCategory == FriendCategory.gstars,
                    onTap: () {
                      context.read<MakeAFriendBloc>().add(
                            const TabSwitched(FriendCategory.gstars),
                          );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: label,
            fontSize: 16,
            fontWeight: isSelected
                ? FontWeightType.bold
                : FontWeightType.medium,
            color: Colors.white,
          ),
          const SizedBox(height: 4),
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

