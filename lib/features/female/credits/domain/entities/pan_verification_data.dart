class PanVerificationData {
  final String panNumber;
  final String? frontSideImagePath;
  final String? backSideImagePath;

  const PanVerificationData({
    required this.panNumber,
    this.frontSideImagePath,
    this.backSideImagePath,
  });

  bool get isValid => panNumber.isNotEmpty && frontSideImagePath != null && backSideImagePath != null;
}



