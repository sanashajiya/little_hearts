import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../domain/entities/call_history_item.dart';

class CallHistoryCard extends StatelessWidget {
  final CallHistoryItem item;

  const CallHistoryCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);

    final isToday = _isToday(item.dateTime);
    final dateTimeStr = isToday
        ? 'Today, ${DateFormat('h:mm a').format(item.dateTime)}'
        : DateFormat('dd/MM/yyyy, h:mm a').format(item.dateTime);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: zoneTheme.primary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: zoneTheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: '${item.callType} call with ${item.userName}',
                  fontSize: 14,
                  fontWeight: FontWeightType.semiBold,
                  color: AppColors.white,
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: dateTimeStr,
                  fontSize: 10,
                  fontWeight: FontWeightType.regular,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/star.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 2),
                CustomText(
                  text: '+${item.starsEarned}',
                  fontSize: 14,
                  fontWeight: FontWeightType.bold,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}

