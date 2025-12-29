/// Hangout User Entity
class HangoutUser {
  final String id;
  final String name;
  final String profileImage;
  final String language;
  final double rating;
  final String topic;
  final bool isAudio;

  const HangoutUser({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.language,
    required this.rating,
    required this.topic,
    required this.isAudio,
  });
}


