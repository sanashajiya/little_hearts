class CallHistoryItem {
  final String callType; // 'Audio' or 'Video'
  final String userName;
  final DateTime dateTime;
  final int starsEarned;

  const CallHistoryItem({
    required this.callType,
    required this.userName,
    required this.dateTime,
    required this.starsEarned,
  });
}

