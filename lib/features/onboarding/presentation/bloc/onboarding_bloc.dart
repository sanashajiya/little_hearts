import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState()) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingLetsGoPressed>(_onLetsGoPressed);
    on<OnboardingPhoneChanged>(_onPhoneChanged);
    on<OnboardingGetOtpPressed>(_onGetOtpPressed);
    on<OnboardingOtpChanged>(_onOtpChanged);
    on<OnboardingVerifyOtpPressed>(_onVerifyOtpPressed);
    on<OnboardingResendOtp>(_onResendOtp);
    on<OnboardingTermsAccepted>(_onTermsAccepted);
    on<OnboardingTermsCheckboxChanged>(_onTermsCheckboxChanged);
  }

  void _onPageChanged(OnboardingPageChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }

  void _onLetsGoPressed(OnboardingLetsGoPressed event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(step: OnboardingStep.enterPhone));
  }

  void _onPhoneChanged(OnboardingPhoneChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(phoneNumber: event.phone));
  }

  void _onGetOtpPressed(OnboardingGetOtpPressed event, Emitter<OnboardingState> emit) {
    if (state.phoneNumber.length >= 10) {
      emit(state.copyWith(
        step: OnboardingStep.verifyOtp,
        resendTimer: 30,
        showTermsDialog: true,
      ));
    }
  }

  void _onOtpChanged(OnboardingOtpChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  void _onVerifyOtpPressed(OnboardingVerifyOtpPressed event, Emitter<OnboardingState> emit) {
    if (state.otp.length == 4) {
      emit(state.copyWith(step: OnboardingStep.completed));
    }
  }

  void _onResendOtp(OnboardingResendOtp event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(resendTimer: 30));
  }

  void _onTermsAccepted(OnboardingTermsAccepted event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(
      termsAccepted: true,
      showTermsDialog: false,
    ));
  }

  void _onTermsCheckboxChanged(OnboardingTermsCheckboxChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(termsAccepted: event.checked));
  }
}
