import 'package:flutter_bloc/flutter_bloc.dart';
import 'pan_verification_event.dart';
import 'pan_verification_state.dart';

class PanVerificationBloc extends Bloc<PanVerificationEvent, PanVerificationState> {
  PanVerificationBloc() : super(const PanVerificationState()) {
    on<PanVerificationInitialized>(_onInitialized);
    // on<PanNumberChanged>(_onPanNumberChanged);
    on<FrontSideImageSelected>(_onFrontSideImageSelected);
    on<BackSideImageSelected>(_onBackSideImageSelected);
    on<PanVerificationSubmitted>(_onSubmitted);
  }

  void _onInitialized(
    PanVerificationInitialized event,
    Emitter<PanVerificationState> emit,
  ) {
    // Initialize state
  }

  // void _onPanNumberChanged(
  //   PanNumberChanged event,
  //   Emitter<PanVerificationState> emit,
  // ) {
  //   final panNumber = event.panNumber.toUpperCase();
  //   String? error;

  //   if (panNumber.isEmpty) {
  //     error = null; // Don't show error until user starts typing
  //   } else if (panNumber.length != 10) {
  //     error = 'PAN number must be 10 characters';
  //   } else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(panNumber)) {
  //     error = 'Invalid PAN format';
  //   }

  //   emit(state.copyWith(panNumber: panNumber, panNumberError: error));
  // }

  void _onFrontSideImageSelected(
    FrontSideImageSelected event,
    Emitter<PanVerificationState> emit,
  ) {
    emit(state.copyWith(frontSideImagePath: event.imagePath));
  }

  void _onBackSideImageSelected(
    BackSideImageSelected event,
    Emitter<PanVerificationState> emit,
  ) {
    emit(state.copyWith(backSideImagePath: event.imagePath));
  }

  void _onSubmitted(
    PanVerificationSubmitted event,
    Emitter<PanVerificationState> emit,
  ) {
    if (state.canContinue) {
      emit(state.copyWith(isLoading: true));
      // TODO: Submit to API
      // After success, navigate to bank details
    }
  }
}

