import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../theme/zone_theme.dart';
import '../cubit/zone_cubit.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/male/profile/presentation/pages/profile_page.dart';
import '../../features/male/profile/presentation/screens/profile_screen.dart';
import '../../features/male/profile/presentation/screens/followers_screen.dart';
import '../../features/male/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/male/profile/presentation/screens/blocked_users_screen.dart';
import '../../features/male/profile/presentation/screens/terms_conditions_screen.dart';
import '../../features/male/profile/presentation/screens/view_profile_screen.dart';
import '../../features/male/home/presentation/screens/home_screen.dart';
import '../../features/male/explore/presentation/screens/explore_screen.dart';
import '../../features/male/make_a_friend/presentation/screens/make_a_friend_screen.dart';
import '../../features/male/recents/presentation/screens/recents_screen.dart';
import '../../features/male/recents/presentation/screens/recharge_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/profile_screen',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/followers',
      builder: (context, state) {
        final extra = state.extra;
        final type = extra is Map
            ? (extra['type'] as String? ?? 'followers')
            : 'followers';
        return FollowersScreen(type: type);
      },
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/blocked-users',
      builder: (context, state) => const BlockedUsersScreen(),
    ),
    GoRoute(
      path: '/terms-conditions',
      builder: (context, state) => const TermsConditionsScreen(),
    ),
    GoRoute(
      path: '/view-profile',
      builder: (context, state) {
        final extra = state.extra;
        final userId = extra is String ? extra : null;
        return ViewProfileScreen(userId: userId);
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final extra = state.extra;
        var userName = 'User';
        String? gender;
        bool showCompletionDialog = false;
        if (extra is Map) {
          final untypedMap = extra.cast<dynamic, dynamic>();
          final fromExtra = (untypedMap['username'] as String?)?.trim();
          if (fromExtra != null && fromExtra.isNotEmpty) {
            userName = fromExtra;
          }
          gender = untypedMap['gender'] as String?;
          showCompletionDialog = untypedMap['showCompletionDialog'] as bool? ?? false;
        }
        return HomeScreen(
          userName: userName,
          gender: gender,
          showCompletionDialog: showCompletionDialog,
        );
      },
    ),
    GoRoute(
      path: '/explore',
      builder: (context, state) => const ExploreScreen(),
    ),
    GoRoute(
      path: '/make-a-friend',
      builder: (context, state) {
        final extra = state.extra;
        final current = context.read<ZoneCubit>().state;
        final mode = extra is ZoneMode ? extra : current;
        return MakeAFriendScreen(mode: mode);
      },
    ),
    GoRoute(
      path: '/zone',
      builder: (context, state) {
        final extra = state.extra;
        final current = context.read<ZoneCubit>().state;
        final mode = extra is ZoneMode ? extra : current;
        context.read<ZoneCubit>().setMode(mode);
        return const ExploreScreen();
      },
    ),
    GoRoute(
      path: '/recents',
      builder: (context, state) => const RecentsScreen(),
    ),
    GoRoute(
      path: '/recharge',
      builder: (context, state) => const RechargeScreen(),
    ),
  ],
);
