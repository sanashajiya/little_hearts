import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/home/presentation/screens/home_screen.dart';

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
      path: '/home',
      builder: (context, state) {
        final extra = state.extra;
        var userName = 'User';
        String? gender;
        if (extra is Map) {
          final untypedMap = extra.cast<dynamic, dynamic>();
          final fromExtra = (untypedMap['username'] as String?)?.trim();
          if (fromExtra != null && fromExtra.isNotEmpty) {
            userName = fromExtra;
          }
          gender = untypedMap['gender'] as String?;
        }
        return HomeScreen(
          userName: userName,
          gender: gender,
        );
      },
    ),
  ],
);
