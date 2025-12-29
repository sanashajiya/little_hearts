import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/hangout_bloc.dart';
import '../bloc/hangout_event.dart';
import '../bloc/hangout_state.dart';
import '../widgets/hangout_app_bar.dart';
import '../widgets/hangout_search_bar.dart';
import '../widgets/hangout_user_card.dart';
import '../widgets/hangout_bottom_navigation.dart';
import '../../data/repositories/hangout_repository_impl.dart';

/// Hangout Zone Screen (Main Screen)
class HangoutZoneScreen extends StatelessWidget {
  const HangoutZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HangoutBloc(
        repository: HangoutRepositoryImpl(),
      )..add(const LoadHangoutUsers(isAudio: false)), // Default to Video Zone
      child: const _HangoutZoneView(),
    );
  }
}

class _HangoutZoneView extends StatefulWidget {
  const _HangoutZoneView();

  @override
  State<_HangoutZoneView> createState() => _HangoutZoneViewState();
}

class _HangoutZoneViewState extends State<_HangoutZoneView> {
  bool _isAudio = false; // Default to Video Zone
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onTabChanged(bool isAudio) {
    setState(() {
      _isAudio = isAudio;
    });
    context.read<HangoutBloc>().add(SwitchHangoutTab(isAudio: isAudio));
  }

  void _onSearchChanged(String query) {
    context.read<HangoutBloc>().add(
          SearchHangoutUser(query: query, isAudio: _isAudio),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.hangoutModeLight,
              AppColors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                child: HangoutAppBar(
                  onCreateTap: () {
                    context.push('/hangout/create');
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Search Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: HangoutSearchBar(
                  onChanged: _onSearchChanged,
                ),
              ),
              const SizedBox(height: 16),
              // Content
              Expanded(
                child: BlocBuilder<HangoutBloc, HangoutState>(
                  builder: (context, state) {
                    if (state is HangoutLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.hangoutMode,
                        ),
                      );
                    }

                    if (state is HangoutError) {
                      return Center(
                        child: CustomText(
                          text: 'Error: ${state.message}',
                          fontSize: 14,
                          color: AppColors.error,
                        ),
                      );
                    }

                    if (state is HangoutLoaded) {
                      if (state.users.isEmpty) {
                        return Center(
                          child: CustomText(
                            text: 'No users found',
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        );
                      }

                      return Padding( 
                        padding: const EdgeInsets.all(16),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return HangoutUserCard(user: user);
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              // Bottom Navigation
              HangoutBottomNavigation(
                isAudio: _isAudio,
                onTabChanged: _onTabChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


