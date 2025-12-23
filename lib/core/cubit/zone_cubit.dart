import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/zone_theme.dart';

class ZoneCubit extends Cubit<ZoneMode> {
  ZoneCubit() : super(ZoneMode.friend);

  void setMode(ZoneMode mode) => emit(mode);
}


