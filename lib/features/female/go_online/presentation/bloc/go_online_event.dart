import 'package:equatable/equatable.dart';

abstract class GoOnlineEvent extends Equatable {
  const GoOnlineEvent();

  @override
  List<Object?> get props => [];
}

class GoOnlineInitialized extends GoOnlineEvent {
  const GoOnlineInitialized();
}

class AudioCallToggled extends GoOnlineEvent {
  final bool isEnabled;

  const AudioCallToggled(this.isEnabled);

  @override
  List<Object?> get props => [isEnabled];
}

class VideoCallToggled extends GoOnlineEvent {
  final bool isEnabled;

  const VideoCallToggled(this.isEnabled);

  @override
  List<Object?> get props => [isEnabled];
}

