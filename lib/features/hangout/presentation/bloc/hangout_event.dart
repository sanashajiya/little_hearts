import 'package:equatable/equatable.dart';

/// Hangout Events
abstract class HangoutEvent extends Equatable {
  const HangoutEvent();

  @override
  List<Object?> get props => [];
}

/// Load hangout users
class LoadHangoutUsers extends HangoutEvent {
  final bool isAudio;

  const LoadHangoutUsers({this.isAudio = false});

  @override
  List<Object?> get props => [isAudio];
}

/// Switch between Video and Audio zones
class SwitchHangoutTab extends HangoutEvent {
  final bool isAudio;

  const SwitchHangoutTab({required this.isAudio});

  @override
  List<Object?> get props => [isAudio];
}

/// Search hangout users
class SearchHangoutUser extends HangoutEvent {
  final String query;
  final bool isAudio;

  const SearchHangoutUser({required this.query, this.isAudio = false});

  @override
  List<Object?> get props => [query, isAudio];
}

/// Select zone type (Audio/Video) for creating hangout
class SelectHangoutZone extends HangoutEvent {
  final bool isAudio;

  const SelectHangoutZone({required this.isAudio});

  @override
  List<Object?> get props => [isAudio];
}

/// Update topic in create hangout screen
class UpdateHangoutTopic extends HangoutEvent {
  final String topic;

  const UpdateHangoutTopic({required this.topic});

  @override
  List<Object?> get props => [topic];
}

/// Create a new hangout
class CreateHangout extends HangoutEvent {
  final bool isAudio;
  final String topic;

  const CreateHangout({required this.isAudio, required this.topic});

  @override
  List<Object?> get props => [isAudio, topic];
}

