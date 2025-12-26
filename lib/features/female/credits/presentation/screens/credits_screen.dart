import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../../explore/presentation/widgets/female_bottom_navigation_bar.dart';
import '../../../go_online/presentation/widgets/female_app_bar.dart';
import '../bloc/credits_bloc.dart';
import '../bloc/credits_event.dart';
import '../bloc/credits_state.dart';
import '../widgets/call_history_card.dart';
import '../widgets/credits_summary_card.dart';
import '../widgets/credits_calendar_sheet.dart';
import '../widgets/withdrawal_history_card.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);

    return BlocProvider(
      create: (_) => CreditsBloc()..add(const CreditsInitialized()),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                zoneTheme.dark.withOpacity(0.99),
                zoneTheme.light.withOpacity(0.5),
              ],
            ),
          ),
          child: SafeArea(
            child: BlocListener<CreditsBloc, CreditsState>(
              listenWhen: (prev, current) =>
                  prev.isCalendarVisible != current.isCalendarVisible,
              listener: (context, state) async {
                if (state.isCalendarVisible) {
                  await showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) {
                      // Use BlocBuilder so the sheet rebuilds when month changes
                      return BlocProvider.value(
                        value: context.read<CreditsBloc>(),
                        child: BlocBuilder<CreditsBloc, CreditsState>(
                          builder: (ctx, sheetState) {
                            // Get highlighted dates from call history and withdrawal history
                            final highlightedDates = <DateTime>{};
                            
                            // Add call history dates
                            for (final item in sheetState.callHistory) {
                              highlightedDates.add(DateTime(
                                item.dateTime.year,
                                item.dateTime.month,
                                item.dateTime.day,
                              ));
                            }
                            
                            // Add withdrawal history dates
                            for (final item in sheetState.withdrawalHistory) {
                              highlightedDates.add(DateTime(
                                item.dateTime.year,
                                item.dateTime.month,
                                item.dateTime.day,
                              ));
                            }

                            return CreditsCalendarSheet(
                              month: sheetState.currentMonth,
                              selectedDate: sheetState.selectedDate,
                              highlightedDates: highlightedDates,
                              onDateSelected: (date) {
                                ctx.read<CreditsBloc>().add(
                                  CreditsDateSelected(date),
                                );
                                // Filter by selected date
                                ctx.read<CreditsBloc>().add(
                                  DateFilterChanged(
                                    startDate: date,
                                    endDate: date,
                                  ),
                                );
                              },
                              onPreviousMonth: () {
                                ctx.read<CreditsBloc>().add(
                                  const CreditsMonthChanged(isNext: false),
                                );
                              },
                              onNextMonth: () {
                                ctx.read<CreditsBloc>().add(
                                  const CreditsMonthChanged(isNext: true),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                  if (context.mounted) {
                    context.read<CreditsBloc>().add(
                      const CreditsCalendarClosed(),
                    );
                  }
                }
              },
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 16, 0),
                    child: FemaleAppBar(title: 'Credits'),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: BlocBuilder<CreditsBloc, CreditsState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              CreditsSummaryCard(
                                totalStars: state.totalStars,
                                convertedAmount: state.convertedAmount,
                              ),
                              _buildWithdrawButton(context, zoneTheme),
                              _buildTabsSection(context, state, zoneTheme),
                              const SizedBox(height: 8),
                              Expanded(child: _buildHistoryList(context, state)),
                              const SizedBox(height: 50), // Space for bottom nav
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const FemaleBottomNavigationBar(
                    selectedItem: FemaleBottomNavItem.credits,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWithdrawButton(BuildContext context, ZoneTheme zoneTheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          context.push('/female/pan-verification');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: zoneTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.white),
          ),

          elevation: 4,
        ),
        child: const CustomText(
          text: 'With Draw',
          fontSize: 16,
          fontWeight: FontWeightType.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTabsSection(
    BuildContext context,
    CreditsState state,
    ZoneTheme zoneTheme,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTab(
                  context,
                  'Call History',
                  CreditsTab.callHistory,
                  state.selectedTab == CreditsTab.callHistory,
                  zoneTheme,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTab(
                  context,
                  'Withdrawl History',
                  CreditsTab.withdrawalHistory,
                  state.selectedTab == CreditsTab.withdrawalHistory,
                  zoneTheme,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              context.read<CreditsBloc>().add(const CreditsCalendarOpened());
            },
            child: Image.asset(
              'assets/icons/calendar.png',
              width: 26,
              height: 26,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    String label,
    CreditsTab tab,
    bool isSelected,
    ZoneTheme zoneTheme,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<CreditsBloc>().add(TabChanged(tab));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? zoneTheme.dark : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: CustomText(
          text: label,
          fontSize: 14,
          fontWeight: isSelected ? FontWeightType.bold : FontWeightType.regular,
          color: isSelected ? AppColors.black : AppColors.black,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context, CreditsState state) {
    if (state.selectedTab == CreditsTab.callHistory) {
      final history = state.filteredCallHistory;
      if (history.isEmpty) {
        return const Center(
          child: CustomText(
            text: 'No call history found',
            fontSize: 14,
            color: AppColors.black,
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          return CallHistoryCard(item: history[index]);
        },
      );
    } else {
      final history = state.filteredWithdrawalHistory;
      if (history.isEmpty) {
        return const Center(
          child: CustomText(
            text: 'No withdrawal history found',
            fontSize: 14,
            color: AppColors.black,
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          return WithdrawalHistoryCard(item: history[index]);
        },
      );
    }
  }

}
