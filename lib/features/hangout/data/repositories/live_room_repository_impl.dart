import '../../domain/entities/live_room.dart';
import '../../domain/repositories/live_room_repository.dart';
import '../datasources/live_room_datasource.dart';
import '../datasources/live_room_mock_datasource.dart';

/// Live Room Repository Implementation
class LiveRoomRepositoryImpl implements LiveRoomRepository {
  final LiveRoomDataSource _dataSource;

  LiveRoomRepositoryImpl({LiveRoomDataSource? dataSource})
      : _dataSource = dataSource ?? LiveRoomMockDataSource();

  @override
  Future<LiveRoom> getLiveRoom(String roomId) {
    return _dataSource.getLiveRoom(roomId);
  }

  @override
  Future<LiveRoom> joinLiveRoom(String roomId) {
    return _dataSource.joinLiveRoom(roomId);
  }

  @override
  Future<void> sendMessage(String roomId, String message) {
    return _dataSource.sendMessage(roomId, message);
  }

  @override
  Future<void> submitReport(String roomId, String reason, {String? otherReason}) {
    return _dataSource.submitReport(roomId, reason, otherReason: otherReason);
  }
}

