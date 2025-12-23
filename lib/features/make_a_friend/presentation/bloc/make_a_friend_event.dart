import 'package:equatable/equatable.dart';
import '../../domain/entities/friend_avatar.dart';

abstract class MakeAFriendEvent extends Equatable {
  const MakeAFriendEvent();

  @override
  List<Object?> get props => [];
}

class MakeAFriendInitialized extends MakeAFriendEvent {
  const MakeAFriendInitialized();
}

class TabSwitched extends MakeAFriendEvent {
  final FriendCategory category;

  const TabSwitched(this.category);

  @override
  List<Object?> get props => [category];
}

class RandomCallRequested extends MakeAFriendEvent {
  final bool isVideoCall;

  const RandomCallRequested({required this.isVideoCall});

  @override
  List<Object?> get props => [isVideoCall];
}

