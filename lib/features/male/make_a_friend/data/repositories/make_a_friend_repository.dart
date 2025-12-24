import '../../domain/entities/friend_avatar.dart';

abstract class MakeAFriendRepository {
  Future<List<FriendAvatar>> getGIconsAvatars();
  Future<List<FriendAvatar>> getGStarsAvatars();
}

class MakeAFriendRepositoryImpl implements MakeAFriendRepository {
  @override
  Future<List<FriendAvatar>> getGIconsAvatars() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    return List.generate(6, (index) {
      return FriendAvatar(
        imageAsset: 'assets/images/gicon${index + 1}.png',
        isOnline: true,
      );
    });
  }

  @override
  Future<List<FriendAvatar>> getGStarsAvatars() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    return List.generate(6, (index) {
      return FriendAvatar(
        imageAsset: 'assets/images/gstar${index + 1}.png',
        isOnline: true,
      );
    });
  }
}

