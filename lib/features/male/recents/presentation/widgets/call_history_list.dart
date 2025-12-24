import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../domain/entities/call_record.dart';

class CallHistoryList extends StatelessWidget {
  final List<CallRecord> calls;

  const CallHistoryList({
    super.key,
    required this.calls,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: calls.length, 
      itemBuilder: (context, index) {
        final call = calls[index];
        return Container(
          margin: const EdgeInsets.only(left: 12,right: 12 ,bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CustomText(
                        text: call.userName,
                        fontSize: 14,
                        fontWeight: FontWeightType.bold,
                        color: AppColors.white,
                      ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Duration",
                    fontSize: 14,
                    fontWeight: FontWeightType.regular,
                    color: AppColors.white,
                  ),
                  CustomText(
                    text: '${_formatDuration(call.duration)} mins',
                    fontSize: 14,
                    fontWeight: FontWeightType.medium,
                    color: AppColors.white,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Coins Gifted',
                    fontSize: 12,
                    fontWeight: FontWeightType.medium,
                    color: AppColors.white,
                  ),
                  CustomText(
                    text: call.coins.toString(),
                    fontSize: 13,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.white,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomText(
                  text:
                      '${_formatTime(call.dateTime)}  ${_formatDate(call.dateTime)}',
                  fontSize: 10,
                  fontWeight: FontWeightType.medium,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDuration(Duration d) {
    return d.inMinutes.toString();
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }
}


