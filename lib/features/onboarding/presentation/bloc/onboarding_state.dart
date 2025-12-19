import 'package:equatable/equatable.dart';

enum OnboardingStep { initial, enterPhone, verifyOtp, completed }

class OnboardingState extends Equatable {
  final int currentPage;
  final OnboardingStep step;
  final String phoneNumber;
  final String otp;
  final bool termsAccepted;
  final bool showTermsDialog;
  final bool getOtpAttempted;
  final int resendTimer;
  final bool isLoading;

  const OnboardingState({
    this.currentPage = 0,
    this.step = OnboardingStep.initial,
    this.phoneNumber = '',
    this.otp = '',
    this.termsAccepted = false,
    this.showTermsDialog = false,
    this.getOtpAttempted = false,
    this.resendTimer = 30,
    this.isLoading = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    OnboardingStep? step,
    String? phoneNumber,
    String? otp,
    bool? termsAccepted,
    bool? showTermsDialog,
    bool? getOtpAttempted,
    int? resendTimer,
    bool? isLoading,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      step: step ?? this.step,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      showTermsDialog: showTermsDialog ?? this.showTermsDialog,
      getOtpAttempted: getOtpAttempted ?? this.getOtpAttempted,
      resendTimer: resendTimer ?? this.resendTimer,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    currentPage,
    step,
    phoneNumber,
    otp,
    termsAccepted,
    showTermsDialog,
    getOtpAttempted,
    resendTimer,
    isLoading,
  ];
}
