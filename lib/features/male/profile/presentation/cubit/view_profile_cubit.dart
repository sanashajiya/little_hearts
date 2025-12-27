import 'package:flutter_bloc/flutter_bloc.dart';

class ViewProfileCubit extends Cubit<ViewProfileState> {
  ViewProfileCubit() : super(ViewProfileInitial()) {
    _loadProfile();
  }

  void _loadProfile() {
    // Dummy data
    final profile = ViewProfileData(
      name: 'Meghana',
      age: 26,
      // lastSeen: 'Last seen on sat, 29th 2025',
      birthday: 'Birthday – 27th March 2003',
      location: 'Hyderabad',
      followersCount: 200,
      followingCount: 285,
      bio: 'Fun and adventurous. I\'m not afraid to try new things and I love to be spontaneous. I want someone who is always up for an adventure, whether it\'s trying a new restaurant, going on a hike, or traveling to a new country.',
      languages: ['Telugu', 'English'],
      stories: [
        'assets/images/story1.png',
        'assets/images/story2.png',
        'assets/images/story3.png',
        'assets/images/story4.png',
      ],
      rating: 4.0,
      ratingCount: 123,
      conversationMinutes: 300,
      starsGifted: 26,
      followingSince: '25th April',
      audioPricePerMin: 20,
      videoPricePerMin: 10,
      chatPricePerMin: 12,
    );

    emit(ViewProfileLoaded(profile));
  }
}

abstract class ViewProfileState {}

class ViewProfileInitial extends ViewProfileState {}

class ViewProfileLoaded extends ViewProfileState {
  final ViewProfileData profile;

  ViewProfileLoaded(this.profile);
}

class ViewProfileData {
  final String name;
  final int age;
  // final String lastSeen;
  final String birthday;
  final String location;
  final int followersCount;
  final int followingCount;
  final String bio;
  final List<String> languages;
  final List<String> stories;
  final double rating;
  final int ratingCount;
  final int conversationMinutes;
  final int starsGifted;
  final String followingSince;
  final int audioPricePerMin;
  final int videoPricePerMin;
  final int chatPricePerMin;

  ViewProfileData({
    required this.name,
    required this.age,
    // required this.lastSeen,
    required this.birthday,
    required this.location,
    required this.followersCount,
    required this.followingCount,
    required this.bio,
    required this.languages,
    required this.stories,
    required this.rating,
    required this.ratingCount,
    required this.conversationMinutes,
    required this.starsGifted,
    required this.followingSince,
    required this.audioPricePerMin,
    required this.videoPricePerMin,
    required this.chatPricePerMin,
  });
}

