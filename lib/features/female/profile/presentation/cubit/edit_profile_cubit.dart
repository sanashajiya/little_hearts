import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial()) {
    _loadProfile();
  }

  void _loadProfile() {
    // Dummy data
    emit(EditProfileLoaded(
      name: 'Meghana..',
      dateOfBirth: '1998-01-15',
      country: 'India',
      age: 26,
      about: 'Fun and adventurous. I\'m not afraid to try new things and I love to be spontaneous.',
    ));
  }

  void updateName(String name) {
    final currentState = state;
    if (currentState is EditProfileLoaded) {
      emit(currentState.copyWith(name: name));
    }
  }

  void updateDateOfBirth(String dateOfBirth) {
    final currentState = state;
    if (currentState is EditProfileLoaded) {
      emit(currentState.copyWith(dateOfBirth: dateOfBirth));
    }
  }

  void updateCountry(String country) {
    final currentState = state;
    if (currentState is EditProfileLoaded) {
      emit(currentState.copyWith(country: country));
    }
  }

  void updateAge(int age) {
    final currentState = state;
    if (currentState is EditProfileLoaded) {
      emit(currentState.copyWith(age: age));
    }
  }

  void updateAbout(String about) {
    final currentState = state;
    if (currentState is EditProfileLoaded) {
      emit(currentState.copyWith(about: about));
    }
  }
}

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final String name;
  final String dateOfBirth;
  final String country;
  final int age;
  final String about;

  EditProfileLoaded({
    required this.name,
    required this.dateOfBirth,
    required this.country,
    required this.age,
    required this.about,
  });

  EditProfileLoaded copyWith({
    String? name,
    String? dateOfBirth,
    String? country,
    int? age,
    String? about,
  }) {
    return EditProfileLoaded(
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      country: country ?? this.country,
      age: age ?? this.age,
      about: about ?? this.about,
    );
  }
}



