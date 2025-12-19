class ApiConstants {
  static const String baseUrl = 'https://api.littlehearts.com/v1';
  
  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-otp';
  static const String refreshToken = '/auth/refresh';
  
  // User Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';
  static const String uploadAvatar = '/user/avatar';
  
  // Friend Zone
  static const String friends = '/friends';
  static const String friendRequests = '/friends/requests';
  
  // Date Zone
  static const String matches = '/dating/matches';
  static const String swipe = '/dating/swipe';
  
  // Hangout Zone
  static const String rooms = '/hangout/rooms';
  static const String joinRoom = '/hangout/join';
  
  // Credits
  static const String credits = '/credits';
  static const String recharge = '/credits/recharge';
  
  // Leaderboard
  static const String leaderboard = '/leaderboard';
}




