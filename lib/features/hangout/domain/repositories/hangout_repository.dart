import '../entities/hangout_user.dart';

/// Hangout Repository Interface
abstract class HangoutRepository {
  /// Get all hangout users
  Future<List<HangoutUser>> getHangoutUsers({bool isAudio = false});

  /// Search hangout users by name
  Future<List<HangoutUser>> searchHangoutUsers(String query, {bool isAudio = false});
}

