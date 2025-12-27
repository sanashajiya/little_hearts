import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/profile_data.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    _loadProfile();
  }

  void _loadProfile() {
    // Dummy data for now
    final profile = ProfileData(
      name: 'Meghana',
      age: 26,
      // lastSeen: 'Last Seen on sat, 29th 2025',
      location: 'Hyderabad',
      bio: 'Fun and adventurous. I\'m not afraid to try new things and I love to be spontaneous. I want someone who is always up for an adventure, whether it\'s trying a new restaurant, going on a hike, or traveling to a new country.',
      followersCount: 5,
      followingCount: 5,
      rating: 4.0,
      ratingCount: 123,
      profileCreatedDate: 'sat, 29th 2025',
      stories: [
        'assets/images/story1.png',
        'assets/images/story2.png',
        'assets/images/story3.png',
        'assets/images/story4.png',
      ],
    );

    emit(ProfileLoaded(profile));
  }
}

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileData profile;

  ProfileLoaded(this.profile);
}



