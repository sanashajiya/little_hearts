import 'package:equatable/equatable.dart';
import '../../domain/entities/friend_avatar.dart';

class MakeAFriendState extends Equatable {
  final FriendCategory selectedCategory;
  final List<FriendAvatar> gIconsAvatars;
  final List<FriendAvatar> gStarsAvatars;
  final bool isLoading;
  final String? errorMessage;

  const MakeAFriendState({
    this.selectedCategory = FriendCategory.gicons,
    this.gIconsAvatars = const [],
    this.gStarsAvatars = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  MakeAFriendState copyWith({
    FriendCategory? selectedCategory,
    List<FriendAvatar>? gIconsAvatars,
    List<FriendAvatar>? gStarsAvatars,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MakeAFriendState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      gIconsAvatars: gIconsAvatars ?? this.gIconsAvatars,
      gStarsAvatars: gStarsAvatars ?? this.gStarsAvatars,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<FriendAvatar> get currentAvatars {
    return selectedCategory == FriendCategory.gicons
        ? gIconsAvatars
        : gStarsAvatars;
  }

  @override
  List<Object?> get props => [
        selectedCategory,
        gIconsAvatars,
        gStarsAvatars,
        isLoading,
        errorMessage,
      ];
}

