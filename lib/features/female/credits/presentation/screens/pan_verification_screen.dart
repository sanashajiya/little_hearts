import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../../go_online/presentation/widgets/female_app_bar.dart';
import '../bloc/pan_verification_bloc.dart';
import '../bloc/pan_verification_event.dart';
import '../bloc/pan_verification_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/pan_upload_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/section_header.dart';

class PanVerificationScreen extends StatelessWidget {
  const PanVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);

    return BlocProvider(
      create: (_) =>
          PanVerificationBloc()..add(const PanVerificationInitialized()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Material(
                elevation: 2,
                color: Colors.white,
                child: FemaleAppBar(title: 'PAN Verification'),
              ),
              Expanded(
                child: Container(
                  color: Colors.white.withOpacity(0.8),

                  child: BlocBuilder<PanVerificationBloc, PanVerificationState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(title: 'PAN Details'),
                            CustomTextField(
                              // label: 'PAN Number*',
                              hintText: 'Enter PAN Number',
                              errorText: state.panNumberError,
                              maxLength: 10,
                              // inputFormatters: [
                              //   TextInputFormatter.withFunction(
                              //     (oldValue, newValue) => TextEditingValue(
                              //       text: newValue.text.toUpperCase(),
                              //       selection: newValue.selection,
                              //     ),
                              //   ),
                              // ],
                              // onChanged: (value) {
                              //   context.read<PanVerificationBloc>().add(
                              //         PanNumberChanged(value),
                              //       );
                              // },
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: CustomText(
                                text: 'Please Upload PAN Card for Verification',
                                fontSize: 14,
                                fontWeight: FontWeightType.medium,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Row(
                                children: [
                                  PanUploadCard(
                                    label: 'Front side Uploaded*',
                                    imagePath: state.frontSideImagePath,
                                    onImageSelected: (path) {
                                      context.read<PanVerificationBloc>().add(
                                        FrontSideImageSelected(path),
                                      );
                                    },
                                  ),
                                  PanUploadCard(
                                    label: 'Back side Uploaded*',
                                    imagePath: state.backSideImagePath,
                                    onImageSelected: (path) {
                                      context.read<PanVerificationBloc>().add(
                                        BackSideImageSelected(path),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 260),
                            // const Spacer(),
                            PrimaryButton(
                              label: 'Continue',
                              onPressed:
                                  // state.canContinue
                                  // ?
                                  () {
                                    // context.read<PanVerificationBloc>().add(
                                    //       const PanVerificationSubmitted(),
                                    //     );
                                    // Navigate to bank details
                                    context.push('/female/bank-details');
                                  },
                              // : null,
                              // isLoading: state.isLoading,
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
