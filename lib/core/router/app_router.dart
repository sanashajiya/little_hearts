import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:little_hearts/features/female/profile/presentation/screens/female_blocked_users_screen.dart';
import 'package:little_hearts/features/female/profile/presentation/screens/female_edit_profile_screen.dart';
import 'package:little_hearts/features/female/profile/presentation/screens/female_followers_screen.dart';
import '../theme/zone_theme.dart';
import '../cubit/zone_cubit.dart';
import '../cubit/user_cubit.dart' show UserCubit, Gender;
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
import '../../features/female/explore/presentation/screens/female_explore_screen.dart';
import '../../features/female/go_online/presentation/screens/go_online_screen.dart';
import '../../features/female/credits/presentation/screens/credits_screen.dart';
import '../../features/female/credits/presentation/screens/pan_verification_screen.dart';
import '../../features/female/credits/presentation/screens/bank_details_screen.dart';
import '../../features/female/profile/presentation/screens/female_profile_screen.dart';
import '../../features/female/profile/presentation/screens/female_view_profile_screen.dart';
import '../../features/hangout/presentation/screens/hangout_zone_screen.dart';
import '../../features/hangout/presentation/screens/create_hangout_screen.dart';
import '../../features/hangout/presentation/screens/audio_live_room_screen.dart';
import '../../features/hangout/presentation/screens/hangout_view_profile_screen.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
    GoRoute(
      path: '/male/profile_screen',
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
        
        // Try to get gender from route parameters first (for first-time navigation)
        if (extra is Map) {
          final untypedMap = extra.cast<dynamic, dynamic>();
          final fromExtra = (untypedMap['username'] as String?)?.trim();
          if (fromExtra != null && fromExtra.isNotEmpty) {
            userName = fromExtra;
          }
          gender = untypedMap['gender'] as String?;
          showCompletionDialog =
              untypedMap['showCompletionDialog'] as bool? ?? false;
        }
        
        // Fallback to UserCubit if gender not in route params
        // This ensures gender persists across navigation
        final userCubit = context.read<UserCubit>();
        if (gender == null && userCubit.state.gender != null) {
          gender = userCubit.state.gender == Gender.female ? 'female' : 'male';
        }
        
        // Use username from UserCubit if available and route param is default
        if (userName == 'User' && userCubit.state.username != null) {
          userName = userCubit.state.username!;
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
    // Female Explore Routes
    GoRoute(
      path: '/female/explore',
      builder: (context, state) => const FemaleExploreScreen(),
    ),
    GoRoute(
      path: '/female/go-online',
      builder: (context, state) => const GoOnlineScreen(),
    ),
    GoRoute(
      path: '/female/credits',
      builder: (context, state) => const CreditsScreen(),
    ),
    GoRoute(
      path: '/female/pan-verification',
      builder: (context, state) => const PanVerificationScreen(),
    ),
    GoRoute(
      path: '/female/bank-details',
      builder: (context, state) => const BankDetailsScreen(),
    ),
    GoRoute(
      path: '/female/profile-screen',
      builder: (context, state) => const FemaleProfileScreen(),
    ),
    GoRoute(
      path: '/female/edit-profile',
      builder: (context, state) => const FemaleEditProfileScreen(),
    ),
    GoRoute(
      path: '/female/blocked-users',
      builder: (context, state) => const FemaleBlockedUsersScreen(),
    ),
    GoRoute(
      path: '/female/followers',
      builder: (context, state) {
        final extra = state.extra;
        final type = extra is Map
            ? (extra['type'] as String? ?? 'followers')
            : 'followers';
        return FemaleFollowersScreen(type: type);
      },
    ),
    GoRoute(
      path: '/female/view-profile',
      builder: (context, state) {
        final extra = state.extra;
        final userId = extra is String ? extra : null;
        return FemaleViewProfileScreen(userId: userId);
      },
    ),
    // Hangout Routes
    GoRoute(
      path: '/hangout/zone',
      builder: (context, state) => const HangoutZoneScreen(),
    ),
    GoRoute(
      path: '/hangout/create',
      builder: (context, state) => const CreateHangoutScreen(),
    ),
    GoRoute(
      path: '/hangout/live-room',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is Map) {
          final roomId = extra['roomId'] as String? ?? '';
          final topic = extra['topic'] as String? ?? 'Love';
          return AudioLiveRoomScreen(roomId: roomId, topic: topic);
        }
        return AudioLiveRoomScreen(roomId: '', topic: 'Love');
      },
    ),
    GoRoute(
      path: '/hangout/view-profile',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is Map) {
          final name = extra['name'] as String? ?? 'User';
          final profileImage = extra['profileImage'] as String? ?? 'assets/images/female1.png';
          final isMale = extra['isMale'] as bool? ?? false;
          return HangoutViewProfileScreen(
            name: name,
            profileImage: profileImage,
            isMale: isMale,
          );
        }
        return const HangoutViewProfileScreen(
          name: 'User',
          profileImage: 'assets/images/female1.png',
          isMale: false,
        );
      },
    ),
    
  ],
);
