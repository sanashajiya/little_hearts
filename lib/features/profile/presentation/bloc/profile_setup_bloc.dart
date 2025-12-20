import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_setup_event.dart';
import 'profile_setup_state.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  ProfileSetupBloc() : super(const ProfileSetupState()) {
    on<ProfileSetupInitiated>(_onInitiated);
    on<GenderSelected>(_onGenderSelected);
    on<NameChanged>(_onNameChanged);
    on<AvatarSelected>(_onAvatarSelected);
    on<DateOfBirthChanged>(_onDateOfBirthChanged);
    on<LanguageSelected>(_onLanguageSelected);
    on<LanguageDeselected>(_onLanguageDeselected);
    on<ProfileScreenProgressed>(_onScreenProgressed);
    on<ProfileSetupCompleted>(_onProfileSetupCompleted);
    on<ValidateProfileScreen>(_onValidateProfileScreen);
  }

  Future<void> _onInitiated(
    ProfileSetupInitiated event,
    Emitter<ProfileSetupState> emit,
  ) async {
    emit(state.copyWith(currentScreen: 0));
  }

  Future<void> _onGenderSelected(
    GenderSelected event,
    Emitter<ProfileSetupState> emit,
  ) async {
    emit(
      state.copyWith(
        gender: event.gender,
        genderSelected: true,
        selectedAvatar: null, // Reset avatar when gender changes
        avatarSelected: false,
      ),
    );
  }

  Future<void> _onNameChanged(
    NameChanged event,
    Emitter<ProfileSetupState> emit,
  ) async {
    final isValid = _validateUsername(event.name);
    emit(state.copyWith(username: event.name, usernameValid: isValid));
  }

  Future<void> _onAvatarSelected(
    AvatarSelected event,
    Emitter<ProfileSetupState> emit,
  ) async {
    emit(
      state.copyWith(selectedAvatar: event.avatarPath, avatarSelected: true),
    );
  }

  Future<void> _onDateOfBirthChanged(
    DateOfBirthChanged event,
    Emitter<ProfileSetupState> emit,
  ) async {
    emit(
      state.copyWith(dateOfBirth: event.dateOfBirth, dateOfBirthSelected: true),
    );
  }

  Future<void> _onLanguageSelected(
    LanguageSelected event,
    Emitter<ProfileSetupState> emit,
  ) async {
    if (state.selectedLanguages.length < 2) {
      final updatedLanguages = List<String>.from(state.selectedLanguages);
      updatedLanguages.add(event.language);
      emit(
        state.copyWith(
          selectedLanguages: updatedLanguages,
          languagesSelected: updatedLanguages.isNotEmpty,
        ),
      );
    }
  }

  Future<void> _onLanguageDeselected(
    LanguageDeselected event,
    Emitter<ProfileSetupState> emit,
  ) async {
    final updatedLanguages = List<String>.from(state.selectedLanguages);
    updatedLanguages.remove(event.language);
    emit(
      state.copyWith(
        selectedLanguages: updatedLanguages,
        languagesSelected: updatedLanguages.isNotEmpty,
      ),
    );
  }

  Future<void> _onScreenProgressed(
    ProfileScreenProgressed event,
    Emitter<ProfileSetupState> emit,
  ) async {
    emit(state.copyWith(currentScreen: event.currentScreen));
  }

  Future<void> _onProfileSetupCompleted(
    ProfileSetupCompleted event,
    Emitter<ProfileSetupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      // Simulate API call to save profile
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to save profile',
        ),
      );
    }
  }

  Future<void> _onValidateProfileScreen(
    ValidateProfileScreen event,
    Emitter<ProfileSetupState> emit,
  ) async {
    // Validation is handled in each screen widget
  }

  bool _validateUsername(String username) {
    return username.isNotEmpty && username.length >= 3 && username.length <= 20;
  }
}
