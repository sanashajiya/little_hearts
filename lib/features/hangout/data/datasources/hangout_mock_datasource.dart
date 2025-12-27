import 'hangout_datasource.dart';
import '../../domain/entities/hangout_user.dart';

/// Mock Data Source for Hangout Users
class HangoutMockDataSource implements HangoutDataSource {
  // Mock data with 6-7 users using local assets
  static final List<HangoutUser> _mockUsers = [
    const HangoutUser(
      id: '1',
      name: 'Meghana',
      profileImage: 'assets/images/gstar1.png',
      language: 'Telugu',
      rating: 3.0,
      topic: 'Love',
      isAudio: false,
    ),
    const HangoutUser(
      id: '2',
      name: 'Daniel',
      profileImage: 'assets/images/most_engaged1.png',
      language: 'Hindi',
      rating: 3.0,
      topic: 'Music',
      isAudio: false,
    ),
    const HangoutUser(
      id: '3',
      name: 'Sanjana',
      profileImage: 'assets/images/gstar2.png',
      language: 'Tamil',
      rating: 3.0,
      topic: 'Movie',
      isAudio: false,
    ),
    const HangoutUser(
      id: '4',
      name: 'Ganesh',
      profileImage: 'assets/images/most_engaged2.png',
      language: 'Kannada',
      rating: 3.0,
      topic: 'Serial',
      isAudio: false,
    ),
    const HangoutUser(
      id: '5',
      name: 'Nandini',
      profileImage: 'assets/images/gstar3.png',
      language: 'Telugu',
      rating: 3.0,
      topic: 'Love',
      isAudio: true,
    ),
    const HangoutUser(
      id: '6',
      name: 'Kishore',
      profileImage: 'assets/images/most_engaged3.png',
      language: 'Telugu',
      rating: 3.0,
      topic: 'Music',
      isAudio: true,
    ),
    const HangoutUser(
      id: '7',
      name: 'Fathima',
      profileImage: 'assets/images/gstar4.png',
      language: 'Kannada',
      rating: 3.0,
      topic: 'Movie',
      isAudio: true,
    ),
    const HangoutUser(
      id: '8',
      name: 'Hanok',
      profileImage: 'assets/images/most_engaged4.png',
      language: 'Kannada',
      rating: 3.0,
      topic: 'Serial',
      isAudio: true,
    ),
  ];

  @override
  Future<List<HangoutUser>> getHangoutUsers({bool isAudio = false}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockUsers.where((user) => user.isAudio == isAudio).toList();
  }

  @override
  Future<List<HangoutUser>> searchHangoutUsers(String query, {bool isAudio = false}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    final filtered = _mockUsers.where((user) => user.isAudio == isAudio).toList();
    if (query.isEmpty) return filtered;
    return filtered
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

