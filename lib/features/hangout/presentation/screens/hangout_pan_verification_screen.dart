import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../../female/credits/presentation/bloc/pan_verification_bloc.dart';
import '../../../female/credits/presentation/bloc/pan_verification_event.dart';
import '../../../female/credits/presentation/bloc/pan_verification_state.dart';
import '../../../female/credits/presentation/widgets/custom_text_field.dart';
import '../../../female/credits/presentation/widgets/pan_upload_card.dart';
import '../../../female/credits/presentation/widgets/primary_button.dart';
import '../../../female/credits/presentation/widgets/section_header.dart';

class HangoutPanVerificationScreen extends StatelessWidget {
  const HangoutPanVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Set zone mode to hangout for this screen
    context.read<ZoneCubit>().setMode(ZoneMode.hangout);

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
                child: SizedBox(
                  height: kToolbarHeight,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () => context.pop(),
                      ),
                      Expanded(
                        child: Center(
                          child: CustomText(
                            text: 'PAN Verification',
                            fontSize: 18,
                            fontWeight: FontWeightType.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
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
                              hintText: 'Enter PAN Number',
                              errorText: state.panNumberError,
                              maxLength: 10,
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
                            PrimaryButton(
                              label: 'Continue',
                              onPressed: () {
                                context.push('/hangout/bank-details');
                              },
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

