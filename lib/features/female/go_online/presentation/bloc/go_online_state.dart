import 'package:equatable/equatable.dart';
import '../../domain/entities/bonus_reward.dart';

class GoOnlineState extends Equatable {
  final bool isAudioCallEnabled;
  final bool isVideoCallEnabled;
  final String monthlyBonusPeriod;
  final List<BonusReward> bonusRewards;

  const GoOnlineState({
    this.isAudioCallEnabled = false,
    this.isVideoCallEnabled = false,
    this.monthlyBonusPeriod = '',
    this.bonusRewards = const [],
  });

  GoOnlineState copyWith({
    bool? isAudioCallEnabled,
    bool? isVideoCallEnabled,
    String? monthlyBonusPeriod,
    List<BonusReward>? bonusRewards,
  }) {
    return GoOnlineState(
      isAudioCallEnabled: isAudioCallEnabled ?? this.isAudioCallEnabled,
      isVideoCallEnabled: isVideoCallEnabled ?? this.isVideoCallEnabled,
      monthlyBonusPeriod: monthlyBonusPeriod ?? this.monthlyBonusPeriod,
      bonusRewards: bonusRewards ?? this.bonusRewards,
    );
  }

  @override
  List<Object?> get props => [
        isAudioCallEnabled,
        isVideoCallEnabled,
        monthlyBonusPeriod,
        bonusRewards,
      ];
}


