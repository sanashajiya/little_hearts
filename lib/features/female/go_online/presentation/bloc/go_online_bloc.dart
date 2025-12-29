import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/bonus_reward.dart';
import 'go_online_event.dart';
import 'go_online_state.dart';

class GoOnlineBloc extends Bloc<GoOnlineEvent, GoOnlineState> {
  GoOnlineBloc() : super(const GoOnlineState()) {
    on<GoOnlineInitialized>(_onInitialized);
    on<AudioCallToggled>(_onAudioCallToggled);
    on<VideoCallToggled>(_onVideoCallToggled);
  }

  void _onInitialized(
    GoOnlineInitialized event,
    Emitter<GoOnlineState> emit,
  ) {
    // Get current month dates for bonus period
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);
    
    final period = '${firstDay.day}${_getMonthName(firstDay.month)} – ${lastDay.day}${_getMonthName(lastDay.month)}';
    
    // Initialize bonus rewards
    final rewards = const [
      BonusReward(stars: '10k Stars', reward: 'Swaggy Voucher'),
      BonusReward(stars: '50k Stars', reward: 'Silver Coin'),
      BonusReward(stars: '100k Stars', reward: 'Gold Coin'),
      BonusReward(stars: '300k Stars', reward: '100 Grams'),
    ];

    emit(state.copyWith(
      monthlyBonusPeriod: period,
      bonusRewards: rewards,
    ));
  }

  void _onAudioCallToggled(
    AudioCallToggled event,
    Emitter<GoOnlineState> emit,
  ) {
    emit(state.copyWith(isAudioCallEnabled: event.isEnabled));
  }

  void _onVideoCallToggled(
    VideoCallToggled event,
    Emitter<GoOnlineState> emit,
  ) {
    emit(state.copyWith(isVideoCallEnabled: event.isEnabled));
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}



