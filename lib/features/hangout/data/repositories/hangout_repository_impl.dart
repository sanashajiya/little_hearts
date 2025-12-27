import '../../domain/entities/hangout_user.dart';
import '../../domain/repositories/hangout_repository.dart';
import '../datasources/hangout_datasource.dart';
import '../datasources/hangout_mock_datasource.dart';

/// Hangout Repository Implementation
class HangoutRepositoryImpl implements HangoutRepository {
  final HangoutDataSource _dataSource;

  HangoutRepositoryImpl({HangoutDataSource? dataSource})
      : _dataSource = dataSource ?? HangoutMockDataSource();

  @override
  Future<List<HangoutUser>> getHangoutUsers({bool isAudio = false}) {
    return _dataSource.getHangoutUsers(isAudio: isAudio);
  }

  @override
  Future<List<HangoutUser>> searchHangoutUsers(String query, {bool isAudio = false}) {
    return _dataSource.searchHangoutUsers(query, isAudio: isAudio);
  }
}

