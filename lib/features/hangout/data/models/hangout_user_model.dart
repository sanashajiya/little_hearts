import '../../domain/entities/hangout_user.dart';

/// Hangout User Model (Data Layer)
class HangoutUserModel extends HangoutUser {
  const HangoutUserModel({
    required super.id,
    required super.name,
    required super.profileImage,
    required super.language,
    required super.rating,
    required super.topic,
    required super.isAudio,
  });

  factory HangoutUserModel.fromEntity(HangoutUser user) {
    return HangoutUserModel(
      id: user.id,
      name: user.name,
      profileImage: user.profileImage,
      language: user.language,
      rating: user.rating,
      topic: user.topic,
      isAudio: user.isAudio,
    );
  }
}

