import 'package:flutter_bloc/flutter_bloc.dart';

class HangoutViewProfileCubit extends Cubit<HangoutViewProfileState> {
  HangoutViewProfileCubit({
    required String name,
    required String profileImage,
    required bool isMale,
  }) : super(HangoutViewProfileInitial()) {
    _loadProfile(name: name, profileImage: profileImage, isMale: isMale);
  }

  void _loadProfile({
    required String name,
    required String profileImage,
    required bool isMale,
  }) {
    // Mock data - in real app, this would come from API
    final profile = HangoutViewProfileData(
      name: name,
      profileImage: profileImage,
      age: isMale ? 28 : 26,
      lastSeen: 'Last seen on sat, 29th 2025',
      birthday: isMale ? 'Birthday – 15th June 1996' : 'Birthday – 27th March 2003',
      location: 'Hyderabad',
      followersCount: isMale ? 150 : 200,
      followingCount: isMale ? 180 : 285,
      bio: isMale
          ? 'Tech enthusiast and music lover. Always up for a good conversation about technology, movies, or just hanging out with friends.'
          : 'Fun and adventurous. I\'m not afraid to try new things and I love to be spontaneous. I want someone who is always up for an adventure, whether it\'s trying a new restaurant, going on a hike, or traveling to a new country.',
      languages: isMale ? ['Hindi', 'English'] : ['Telugu', 'English'],
      stories: [
        'assets/images/story1.png',
        'assets/images/story2.png',
        'assets/images/story3.png',
        'assets/images/story4.png',
      ],
      rating: 4.0,
      ratingCount: isMale ? 98 : 123,
      conversationMinutes: isMale ? 250 : 300,
      starsGifted: isMale ? 18 : 26,
      followingSince: '25th April',
      audioPricePerMin: isMale ? 15 : 20,
      videoPricePerMin: isMale ? 8 : 10,
      chatPricePerMin: isMale ? 10 : 12,
    );

    emit(HangoutViewProfileLoaded(profile));
  }
}

abstract class HangoutViewProfileState {}

class HangoutViewProfileInitial extends HangoutViewProfileState {}

class HangoutViewProfileLoaded extends HangoutViewProfileState {
  final HangoutViewProfileData profile;

  HangoutViewProfileLoaded(this.profile);
}

class HangoutViewProfileData {
  final String name;
  final String profileImage;
  final int age;
  final String lastSeen;
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

  HangoutViewProfileData({
    required this.name,
    required this.profileImage,
    required this.age,
    required this.lastSeen,
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

