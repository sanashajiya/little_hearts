import 'package:equatable/equatable.dart';

abstract class ProfileSetupEvent extends Equatable {
  const ProfileSetupEvent();

  @override
  List<Object?> get props => [];
}

class ProfileSetupInitiated extends ProfileSetupEvent {
  const ProfileSetupInitiated();
}

class GenderSelected extends ProfileSetupEvent {
  final String gender; // 'male' or 'female'

  const GenderSelected(this.gender);

  @override
  List<Object?> get props => [gender];
}

class NameChanged extends ProfileSetupEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class AvatarSelected extends ProfileSetupEvent {
  final String avatarPath;

  const AvatarSelected(this.avatarPath);

  @override
  List<Object?> get props => [avatarPath];
}

class DateOfBirthChanged extends ProfileSetupEvent {
  final DateTime dateOfBirth;

  const DateOfBirthChanged(this.dateOfBirth);

  @override
  List<Object?> get props => [dateOfBirth];
}

class LanguageSelected extends ProfileSetupEvent {
  final String language;

  const LanguageSelected(this.language);

  @override
  List<Object?> get props => [language];
}

class LanguageDeselected extends ProfileSetupEvent {
  final String language;

  const LanguageDeselected(this.language);

  @override
  List<Object?> get props => [language];
}

class ProfileScreenProgressed extends ProfileSetupEvent {
  final int currentScreen; // 0, 1, 2, 3

  const ProfileScreenProgressed(this.currentScreen);

  @override
  List<Object?> get props => [currentScreen];
}

class ProfileSetupCompleted extends ProfileSetupEvent {
  const ProfileSetupCompleted();
}

class ValidateProfileScreen extends ProfileSetupEvent {
  const ValidateProfileScreen();
}
