import 'package:flutter_bloc/flutter_bloc.dart';

class BlockedUsersCubit extends Cubit<BlockedUsersState> {
  BlockedUsersCubit() : super(BlockedUsersInitial()) {
    _loadBlockedUsers();
  }

  void _loadBlockedUsers() {
    // Dummy data
    final users = [
      BlockedUser(name: 'David Wayne', avatar: 'assets/images/female1.png'),
      BlockedUser(name: 'Edward Davidson', avatar: 'assets/images/female2.png'),
      BlockedUser(name: 'Angela Kelly', avatar: 'assets/images/female3.png'),
      BlockedUser(name: 'Jean Dare', avatar: 'assets/images/female4.png'),
      BlockedUser(name: 'Dennis Borer', avatar: 'assets/images/female1.png'),
      BlockedUser(name: 'Cayla Rath', avatar: 'assets/images/female2.png'),
    ];

    emit(BlockedUsersLoaded(users));
  }

  void unblockUser(String userName) {
    final currentState = state;
    if (currentState is BlockedUsersLoaded) {
      final updatedUsers = currentState.users
          .where((user) => user.name != userName)
          .toList();
      emit(BlockedUsersLoaded(updatedUsers));
    }
  }
}

abstract class BlockedUsersState {}

class BlockedUsersInitial extends BlockedUsersState {}

class BlockedUsersLoaded extends BlockedUsersState {
  final List<BlockedUser> users;

  BlockedUsersLoaded(this.users);
}

class BlockedUser {
  final String name;
  final String avatar;

  BlockedUser({
    required this.name,
    required this.avatar,
  });
}




