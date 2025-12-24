import 'package:flutter_bloc/flutter_bloc.dart';

class RechargeState {
  final int selectedTopPackIndex;

  const RechargeState({this.selectedTopPackIndex = 0});

  RechargeState copyWith({int? selectedTopPackIndex}) {
    return RechargeState(
      selectedTopPackIndex: selectedTopPackIndex ?? this.selectedTopPackIndex,
    );
  }
}

class RechargeCubit extends Cubit<RechargeState> {
  RechargeCubit() : super(const RechargeState());

  void selectTopPack(int index) {
    emit(state.copyWith(selectedTopPackIndex: index));
  }
}


