import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:little_hearts/core/theme/app_colors.dart';
import '../../domain/entities/onboarding_content.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../widgets/onboarding_image_slider.dart';
import '../widgets/bottom_sheet_initial.dart';
import '../widgets/bottom_sheet_phone.dart';
import '../widgets/bottom_sheet_otp.dart';
import '../widgets/terms_dialog.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static final List<OnboardingContent> _contents = [
    const OnboardingContent(
      image: 'assets/images/onboard1.png',
      title: 'Date Zone',
      subtitle: 'WHERE REAL CONNECTIONS BEGIN\nWITH A SPARK',
    ),
    const OnboardingContent(
      image: 'assets/images/onboard2.png',
      title: 'Friend Zone',
      subtitle: 'FOR GOOD VIBES & GREAT FRIENDS',
    ),
    const OnboardingContent(
      image: 'assets/images/onboard3.png',
      title: 'Hang Out Zone',
      subtitle: 'GROUP CALLS THAT FEELS LIKE\nA MINI HANGOUT',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state.showTermsDialog) {
            _showTermsDialog(context);
          }
          if (state.step == OnboardingStep.completed) {
            context.go('/profile');
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primaryLight.withOpacity(1),
            body: Column(
              children: [
                // Auto-scrolling image slider (top section)
                Expanded(
                  flex: 6,
                  child: OnboardingImageSlider(
                    contents: _contents,
                    onPageChanged: (index) {
                      context.read<OnboardingBloc>().add(OnboardingPageChanged(index));
                    },
                  ),
                ),
                // Static bottom sheet
                _buildBottomSheet(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context, OnboardingState state) {
    switch (state.step) {
      case OnboardingStep.initial:
        return BottomSheetInitial(
          termsAccepted: state.termsAccepted,
          onLetsGo: () {
            context.read<OnboardingBloc>().add(OnboardingLetsGoPressed());
          },
          onTermsChanged: (value) {
            context.read<OnboardingBloc>().add(OnboardingTermsCheckboxChanged(value ?? false));
          },
        );
      case OnboardingStep.enterPhone:
        return BottomSheetPhone(
          phoneNumber: state.phoneNumber,
          termsAccepted: state.termsAccepted,
          onPhoneChanged: (phone) {
            context.read<OnboardingBloc>().add(OnboardingPhoneChanged(phone));
          },
          onGetOtp: () {
            context.read<OnboardingBloc>().add(OnboardingGetOtpPressed());
          },
          onTermsChanged: (value) {
            context.read<OnboardingBloc>().add(OnboardingTermsCheckboxChanged(value ?? false));
          },
        );
      case OnboardingStep.verifyOtp:
        return BottomSheetOtp(
          phoneNumber: state.phoneNumber,
          otp: state.otp,
          termsAccepted: state.termsAccepted,
          onOtpChanged: (otp) {
            context.read<OnboardingBloc>().add(OnboardingOtpChanged(otp));
          },
          onContinue: () {
            context.read<OnboardingBloc>().add(OnboardingVerifyOtpPressed());
          },
          onResend: () {
            context.read<OnboardingBloc>().add(OnboardingResendOtp());
          },
        );
      case OnboardingStep.completed:
        return const SizedBox.shrink();
    }
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => TermsDialog(
        onAccept: () {
          Navigator.of(context).pop();
          context.read<OnboardingBloc>().add(OnboardingTermsAccepted());
        },
      ),
    );
  }
}
