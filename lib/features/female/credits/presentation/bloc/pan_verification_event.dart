import 'package:equatable/equatable.dart';

abstract class PanVerificationEvent extends Equatable {
  const PanVerificationEvent();

  @override
  List<Object?> get props => [];
}

class PanVerificationInitialized extends PanVerificationEvent {
  const PanVerificationInitialized();
}

class PanNumberChanged extends PanVerificationEvent {
  final String panNumber;

  const PanNumberChanged(this.panNumber);

  @override
  List<Object?> get props => [panNumber];
}

class FrontSideImageSelected extends PanVerificationEvent {
  final String imagePath;

  const FrontSideImageSelected(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class BackSideImageSelected extends PanVerificationEvent {
  final String imagePath;

  const BackSideImageSelected(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class PanVerificationSubmitted extends PanVerificationEvent {
  const PanVerificationSubmitted();
}



