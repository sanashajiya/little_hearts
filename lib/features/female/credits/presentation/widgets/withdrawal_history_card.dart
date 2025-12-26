import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../domain/entities/withdrawal_history_item.dart';

class WithdrawalHistoryCard extends StatelessWidget {
  final WithdrawalHistoryItem item;

  const WithdrawalHistoryCard({super.key, required this.item});

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
        border: Border.all(color: zoneTheme.primary.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  text: 'Transaction on ',
                  fontSize: 14,
                  fontWeight: FontWeightType.semiBold,
                  color: AppColors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white, // background color
                  borderRadius: BorderRadius.circular(8),
                ),

                child: CustomText(
                  text: '-${item.amount}',
                  fontSize: 16,
                  fontWeight: FontWeightType.bold,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),

          // const SizedBox(height: 4),
          CustomText(
            text: dateTimeStr,
            fontSize: 12,
            fontWeight: FontWeightType.bold,
            color: AppColors.white,
          ),

          CustomText(
            text: 'ID: ${item.transactionId}',
            fontSize: 12,
            fontWeight: FontWeightType.regular,
            color: AppColors.white,
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
