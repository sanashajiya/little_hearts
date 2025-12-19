import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class OnboardingPageChanged extends OnboardingEvent {
  final int pageIndex;
  const OnboardingPageChanged(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

class OnboardingLetsGoPressed extends OnboardingEvent {}

class OnboardingPhoneChanged extends OnboardingEvent {
  final String phone;
  const OnboardingPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class OnboardingGetOtpPressed extends OnboardingEvent {}

class OnboardingOtpChanged extends OnboardingEvent {
  final String otp;
  const OnboardingOtpChanged(this.otp);

  @override
  List<Object?> get props => [otp];
}

class OnboardingVerifyOtpPressed extends OnboardingEvent {}

class OnboardingResendOtp extends OnboardingEvent {}

class OnboardingTermsAccepted extends OnboardingEvent {}

class OnboardingTermsCheckboxChanged extends OnboardingEvent {
  final bool checked;
  const OnboardingTermsCheckboxChanged(this.checked);

  @override
  List<Object?> get props => [checked];
}

class OnboardingShowTermsDialog extends OnboardingEvent {}
