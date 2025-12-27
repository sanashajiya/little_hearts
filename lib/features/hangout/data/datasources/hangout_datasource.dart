import '../../domain/entities/hangout_user.dart';

/// Hangout Data Source Interface
abstract class HangoutDataSource {
  Future<List<HangoutUser>> getHangoutUsers({bool isAudio = false});
  Future<List<HangoutUser>> searchHangoutUsers(String query, {bool isAudio = false});
}

