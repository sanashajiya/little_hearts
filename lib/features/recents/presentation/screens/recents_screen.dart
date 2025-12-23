import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/bottom_navigation_bar.dart';
import '../../data/repositories/recents_repository.dart';
import '../bloc/recents_bloc.dart';
import '../bloc/recents_event.dart';
import '../bloc/recents_state.dart';
import '../widgets/call_history_list.dart';
import '../widgets/recents_calendar_sheet.dart';
import '../widgets/recents_header.dart';
import '../widgets/recents_tabs.dart';
import '../widgets/transaction_list.dart';

class RecentsScreen extends StatelessWidget {
  const RecentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RecentsBloc(repository: RecentsRepositoryImpl())
            ..add(const RecentsInitialized()),
      child: const _RecentsView(),
    );
  }
}

class _RecentsView extends StatelessWidget {
  const _RecentsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.friendMode, AppColors.white],
          ),
        ),
        child: SafeArea(
          child: BlocListener<RecentsBloc, RecentsState>(
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
                      value: context.read<RecentsBloc>(),
                      child: BlocBuilder<RecentsBloc, RecentsState>(
                        builder: (ctx, sheetState) {
                          final highlightedDates = sheetState.calls
                              .map(
                                (e) => DateTime(
                                  e.dateTime.year,
                                  e.dateTime.month,
                                  e.dateTime.day,
                                ),
                              )
                              .toSet();

                          return RecentsCalendarSheet(
                            month: sheetState.currentMonth,
                            selectedDate: sheetState.selectedDate,
                            highlightedDates: highlightedDates,
                            onDateSelected: (date) {
                              ctx.read<RecentsBloc>().add(
                                RecentsDateSelected(date),
                              );
                            },
                            onPreviousMonth: () {
                              ctx.read<RecentsBloc>().add(
                                const RecentsMonthChanged(isNext: false),
                              );
                            },
                            onNextMonth: () {
                              ctx.read<RecentsBloc>().add(
                                const RecentsMonthChanged(isNext: true),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
                if (context.mounted) {
                  context.read<RecentsBloc>().add(
                    const RecentsCalendarClosed(),
                  );
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Simple back arrow and title
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => context.go('/home'),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Recents',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                RecentsHeader(
                  balance: 8300,
                  onRechargeTap: () => context.push('/recharge'),
                ),
                BlocBuilder<RecentsBloc, RecentsState>(
                  builder: (context, state) {
                    return RecentsTabs(
                      selectedTab: state.selectedTab,
                      onTransactionsTap: () => context.read<RecentsBloc>().add(
                        const RecentsTabChanged(RecentsTab.transactions),
                      ),
                      onCallsTap: () => context.read<RecentsBloc>().add(
                        const RecentsTabChanged(RecentsTab.calls),
                      ),
                      onCalendarTap: () => context.read<RecentsBloc>().add(
                        const RecentsCalendarOpened(),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: BlocBuilder<RecentsBloc, RecentsState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.friendMode,
                          ),
                        );
                      }

                      if (state.selectedTab == RecentsTab.transactions) {
                        return TransactionList(
                          transactions: state.transactions,
                        );
                      } else {
                        return CallHistoryList(calls: state.calls);
                      }
                    },
                  ),
                ),
                const AppBottomNavigationBar(
                  selectedItem: BottomNavItem.recents,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
