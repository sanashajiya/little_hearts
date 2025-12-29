import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/user_repository.dart';

enum Gender { male, female }

class UserState extends Equatable {
  final String? username;
  final Gender? gender;
  final bool isLoading;

  const UserState({
    this.username,
    this.gender,
    this.isLoading = false,
  });

  bool get isFemale => gender == Gender.female;
  bool get isMale => gender == Gender.male;

  UserState copyWith({
    String? username,
    Gender? gender,
    bool? isLoading,
  }) {
    return UserState(
      username: username ?? this.username,
      gender: gender ?? this.gender,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [username, gender, isLoading];
}

class UserCubit extends Cubit<UserState> {
  final UserRepository _repository;

  UserCubit(this._repository) : super(const UserState()) {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final savedGender = await _repository.getGender();
      final savedUsername = await _repository.getUsername();
      
      Gender? gender;
      if (savedGender != null) {
        gender = savedGender.toLowerCase() == 'female' 
            ? Gender.female 
            : Gender.male;
      }

      emit(state.copyWith(
        gender: gender,
        username: savedUsername,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> setGender(String gender) async {
    try {
      await _repository.saveGender(gender);
      
      final genderEnum = gender.toLowerCase() == 'female' 
          ? Gender.female 
          : Gender.male;
      
      emit(state.copyWith(gender: genderEnum));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> setUsername(String username) async {
    try {
      await _repository.saveUsername(username);
      emit(state.copyWith(username: username));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> setUserProfile({
    required String username,
    required String gender,
  }) async {
    try {
      await _repository.saveUsername(username);
      await _repository.saveGender(gender);
      
      final genderEnum = gender.toLowerCase() == 'female' 
          ? Gender.female 
          : Gender.male;
      
      emit(state.copyWith(
        username: username,
        gender: genderEnum,
      ));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> clearUserData() async {
    try {
      await _repository.clearUserData();
      emit(const UserState());
    } catch (e) {
      // Handle error if needed
    }
  }
}



