import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../features/female/credits/presentation/widgets/custom_text_field.dart';
import '../bloc/audio_live_room_bloc.dart';
import '../bloc/audio_live_room_event.dart';
import 'reason_radio_tile.dart';

/// Report Bottom Sheet Widget
class ReportBottomSheet extends StatefulWidget {
  const ReportBottomSheet({super.key});

  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  String? _selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();

  final List<String> _reasons = [
    'Bad Behaviour',
    'Scam Or Fraud',
    'Not Adding',
    'Off Topic',
    'False Information',
  ];

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  void _onReasonSelected(String reason) {
    setState(() {
      _selectedReason = reason;
    });
  }

  void _onSubmit() {
    if (_selectedReason != null) {
      context.read<AudioLiveRoomBloc>().add(
            SubmitReport(
              reason: _selectedReason!,
              otherReason: _otherReasonController.text.trim().isEmpty
                  ? null
                  : _otherReasonController.text.trim(),
            ),
          );
      // Close bottom sheet after submitting
      Navigator.of(context).pop();
    }
  }

  void _onCancel() {
    context.read<AudioLiveRoomBloc>().add(const CancelReport());
    // Close bottom sheet when canceling
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Center(
            child: CustomText(
              text: 'Report',
              fontSize: 20,
              fontWeight: FontWeightType.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          // Reason Section
          Row(
            children: [
              const CustomText(
                text: '*',
                fontSize: 16,
                fontWeight: FontWeightType.bold,
                color: Colors.red,
              ),
              const CustomText(
                text: ' Reason',
                fontSize: 16,
                fontWeight: FontWeightType.bold,
                color: AppColors.textPrimary,
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Radio Options
          ..._reasons.map((reason) {
            return ReasonRadioTile(
              reason: reason,
              isSelected: _selectedReason == reason,
              onTap: () => _onReasonSelected(reason),
            );
          }),
          const SizedBox(height: 4),
          // Other Reasons Section
          const CustomText(
            text: 'Other Reasons (Optional)',
            fontSize: 14,
            fontWeight: FontWeightType.medium,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 4),
          CustomTextField(
            hintText: 'Ex: Bullying or Harassment',
            controller: _otherReasonController,
          ),
          const SizedBox(height: 24),
          // Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancel',
                  backgroundColor: AppColors.grey,
                  onPressed: _onCancel,
                  borderRadius: 12,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  text: 'Report',
                  backgroundColor: AppColors.hangoutMode,
                  onPressed: _selectedReason != null ? _onSubmit : null,
                  borderRadius: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

