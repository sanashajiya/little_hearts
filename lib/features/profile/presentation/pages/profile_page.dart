import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/profile_setup_bloc.dart';
import '../bloc/profile_setup_event.dart';
import '../bloc/profile_setup_state.dart';
import '../screens/date_of_birth_screen.dart';
import '../screens/languages_selection_screen.dart';
import '../screens/set_profile_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onContinueFromScreen1(BuildContext blocContext) {
    blocContext.read<ProfileSetupBloc>().add(const ProfileScreenProgressed(1));
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onContinueFromScreen2(BuildContext blocContext) {
    blocContext.read<ProfileSetupBloc>().add(const ProfileScreenProgressed(2));
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onBackFromScreen2(BuildContext blocContext) {
    blocContext.read<ProfileSetupBloc>().add(const ProfileScreenProgressed(0));
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onBackFromScreen3(BuildContext blocContext) {
    blocContext.read<ProfileSetupBloc>().add(const ProfileScreenProgressed(1));
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onFinishProfileSetup(BuildContext blocContext) {
    // Complete the profile setup
    final bloc = blocContext.read<ProfileSetupBloc>();
    bloc.add(const ProfileSetupCompleted());

    // Navigate directly to Home and clear the navigation stack
    // Pass showCompletionDialog flag to show the dialog on home screen
    if (mounted) {
      final state = bloc.state;
      blocContext.go(
        '/home',
        extra: {
          'username': state.username,
          'gender': state.gender,
          'showCompletionDialog': true,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileSetupBloc()..add(const ProfileSetupInitiated()),
      child: BlocListener<ProfileSetupBloc, ProfileSetupState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomText(
                  text: state.errorMessage!,
                  color: Colors.white,
                ),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: Builder(
          builder: (blocContext) {
            return Scaffold(
              backgroundColor: AppColors.white,
              body: SafeArea(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Screen 1: Set Profile (Name, Gender, Avatar)
                    SetProfileScreen(
                      onContinue: () => _onContinueFromScreen1(blocContext),
                    ),
                    // Screen 2: Date of Birth
                    DateOfBirthScreen(
                      onContinue: () => _onContinueFromScreen2(blocContext),
                      onBack: () => _onBackFromScreen2(blocContext),
                    ),
                    // Screen 3: Languages Selection
                    LanguagesSelectionScreen(
                      onFinish: () => _onFinishProfileSetup(blocContext),
                      onBack: () => _onBackFromScreen3(blocContext),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
