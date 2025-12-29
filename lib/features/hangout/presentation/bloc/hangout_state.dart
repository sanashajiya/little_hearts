import 'package:equatable/equatable.dart';
import '../../domain/entities/hangout_user.dart';

/// Hangout States
abstract class HangoutState extends Equatable {
  const HangoutState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class HangoutInitial extends HangoutState {
  const HangoutInitial();
}

/// Loading state
class HangoutLoading extends HangoutState {
  const HangoutLoading();
}

/// Loaded state with users
class HangoutLoaded extends HangoutState {
  final List<HangoutUser> users;
  final bool isAudio;
  final String searchQuery;

  const HangoutLoaded({
    required this.users,
    this.isAudio = false,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [users, isAudio, searchQuery];
}

/// Error state
class HangoutError extends HangoutState {
  final String message;

  const HangoutError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Create Hangout State
class CreateHangoutState extends HangoutState {
  final bool? selectedZone; // null = not selected, true = audio, false = video
  final String topic;

  const CreateHangoutState({
    this.selectedZone,
    this.topic = '',
  });

  bool get isZoneSelected => selectedZone != null;
  bool get canCreate => isZoneSelected && topic.isNotEmpty;

  @override
  List<Object?> get props => [selectedZone, topic];
}


