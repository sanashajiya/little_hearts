import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/hangout_bloc.dart';
import '../bloc/hangout_event.dart';
import '../bloc/hangout_state.dart';
import '../widgets/zone_selection_card.dart';
import '../../data/repositories/hangout_repository_impl.dart';

/// Create Hangout Screen
class CreateHangoutScreen extends StatelessWidget {
  const CreateHangoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HangoutBloc(
        repository: HangoutRepositoryImpl(),
      )..add(const SelectHangoutZone(isAudio: true)), // Initialize with Audio Zone selected
      child: const _CreateHangoutView(),
    );
  }
}

class _CreateHangoutView extends StatefulWidget {
  const _CreateHangoutView();

  @override
  State<_CreateHangoutView> createState() => _CreateHangoutViewState();
}

class _CreateHangoutViewState extends State<_CreateHangoutView> {
  final TextEditingController _topicController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  void _onZoneSelected(bool isAudio) {
    context.read<HangoutBloc>().add(SelectHangoutZone(isAudio: isAudio));
  }

  void _onCreate() {
    final state = context.read<HangoutBloc>().state;
    if (state is CreateHangoutState && state.canCreate) {
      context.read<HangoutBloc>().add(
            CreateHangout(
              isAudio: state.selectedZone!,
              topic: state.topic.trim(),
            ),
          );
      // Navigate back after creation
      context.pop();
    }
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 18,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    const CustomText(
                      text: 'Create',
                      fontSize: 20,
                      fontWeight: FontWeightType.semiBold,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 48), // Balance spacing
                  ],
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<HangoutBloc, HangoutState>(
                    builder: (context, state) {
                      final createState = state is CreateHangoutState
                          ? state
                          : const CreateHangoutState();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Select Zone Section
                          Row(
                            children: [
                              const CustomText(
                                text: '*',
                                fontSize: 18,
                                fontWeight: FontWeightType.bold,
                                color: Colors.red,
                              ),
                              const CustomText(
                                text: 'Select Zone:',
                                fontSize: 16,
                                fontWeight: FontWeightType.bold,
                                color: AppColors.textPrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ZoneSelectionCard(
                                    isAudio: true,
                                    isSelected: createState.selectedZone == true,
                                    onTap: () => _onZoneSelected(true),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ZoneSelectionCard(
                                    isAudio: false,
                                    isSelected: createState.selectedZone == false,
                                    onTap: () => _onZoneSelected(false),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Topic Section
                          Row(
                            children: [
                              const CustomText(
                                text: '*',
                                fontSize: 18,
                                fontWeight: FontWeightType.bold,
                                color: Colors.red,
                              ),
                              const CustomText(
                                text: 'Topic :',
                                fontSize: 16,
                                fontWeight: FontWeightType.bold,
                                color: AppColors.textPrimary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.borderLight,
                              ),
                            ),
                            child: TextField(
                              controller: _topicController,
                              decoration: const InputDecoration(
                                hintText: 'Ex: Movies',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textHint,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                              ),
                              onChanged: (value) {
                                final currentState = context.read<HangoutBloc>().state;
                                if (currentState is CreateHangoutState) {
                                  context.read<HangoutBloc>().add(
                                        UpdateHangoutTopic(topic: value),
                                      );
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 240),
                          // Create Button
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: CustomButton(
                              text: 'Create',
                              backgroundColor: AppColors.hangoutMode,
                              onPressed: createState.canCreate ? _onCreate : null,
                              borderRadius: 12,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

