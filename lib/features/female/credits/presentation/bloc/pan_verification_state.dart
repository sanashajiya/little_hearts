import 'package:equatable/equatable.dart';

class PanVerificationState extends Equatable {
  final String panNumber;
  final String? frontSideImagePath;
  final String? backSideImagePath;
  final String? panNumberError;
  final bool isLoading;

  const PanVerificationState({
    this.panNumber = '',
    this.frontSideImagePath,
    this.backSideImagePath,
    this.panNumberError,
    this.isLoading = false,
  });

  bool get isPanNumberValid => panNumberError == null && panNumber.isNotEmpty;
  bool get isFrontSideUploaded => frontSideImagePath != null;
  bool get isBackSideUploaded => backSideImagePath != null;
  bool get canContinue => isPanNumberValid && isFrontSideUploaded && isBackSideUploaded;

  PanVerificationState copyWith({
    String? panNumber,
    String? frontSideImagePath,
    String? backSideImagePath,
    String? panNumberError,
    bool? isLoading,
  }) {
    return PanVerificationState(
      panNumber: panNumber ?? this.panNumber,
      frontSideImagePath: frontSideImagePath ?? this.frontSideImagePath,
      backSideImagePath: backSideImagePath ?? this.backSideImagePath,
      panNumberError: panNumberError ?? this.panNumberError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        panNumber,
        frontSideImagePath,
        backSideImagePath,
        panNumberError,
        isLoading,
      ];
}

