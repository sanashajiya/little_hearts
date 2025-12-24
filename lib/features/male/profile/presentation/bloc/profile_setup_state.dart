import 'package:equatable/equatable.dart';

class ProfileSetupState extends Equatable {
  final int currentScreen; // 0: set profile, 1: date of birth, 2: languages
  final String? gender; // 'male' or 'female'
  final String username;
  final String? selectedAvatar;
  final DateTime? dateOfBirth;
  final List<String> selectedLanguages;
  final bool usernameValid;
  final bool genderSelected;
  final bool avatarSelected;
  final bool dateOfBirthSelected;
  final bool languagesSelected;
  final bool isLoading;
  final String? errorMessage;

  const ProfileSetupState({
    this.currentScreen = 0,
    this.gender,
    this.username = '',
    this.selectedAvatar,
    this.dateOfBirth,
    this.selectedLanguages = const [],
    this.usernameValid = false,
    this.genderSelected = false,
    this.avatarSelected = false,
    this.dateOfBirthSelected = false,
    this.languagesSelected = false,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get canProgressFromScreen1 =>
      genderSelected && usernameValid && avatarSelected;

  bool get canProgressFromScreen2 => dateOfBirthSelected;

  bool get canFinish =>
      selectedLanguages.length <= 2 && selectedLanguages.isNotEmpty;

  ProfileSetupState copyWith({
    int? currentScreen,
    String? gender,
    String? username,
    String? selectedAvatar,
    DateTime? dateOfBirth,
    List<String>? selectedLanguages,
    bool? usernameValid,
    bool? genderSelected,
    bool? avatarSelected,
    bool? dateOfBirthSelected,
    bool? languagesSelected,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProfileSetupState(
      currentScreen: currentScreen ?? this.currentScreen,
      gender: gender ?? this.gender,
      username: username ?? this.username,
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      usernameValid: usernameValid ?? this.usernameValid,
      genderSelected: genderSelected ?? this.genderSelected,
      avatarSelected: avatarSelected ?? this.avatarSelected,
      dateOfBirthSelected: dateOfBirthSelected ?? this.dateOfBirthSelected,
      languagesSelected: languagesSelected ?? this.languagesSelected,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    currentScreen,
    gender,
    username,
    selectedAvatar,
    dateOfBirth,
    selectedLanguages,
    usernameValid,
    genderSelected,
    avatarSelected,
    dateOfBirthSelected,
    languagesSelected,
    isLoading,
    errorMessage,
  ];
}
