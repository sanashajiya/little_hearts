import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../../go_online/presentation/widgets/female_app_bar.dart';
import '../bloc/bank_details_bloc.dart';
import '../bloc/bank_details_event.dart';
import '../bloc/bank_details_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/section_header.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);

    return BlocProvider(
      create: (_) => BankDetailsBloc()..add(const BankDetailsInitialized()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Material(
                elevation: 2,
                color: Colors.white,
                child: FemaleAppBar(title: 'Bank Details'),
              ),
              Expanded(
                child: Container(
                   color: Colors.white.withOpacity(0.8),
                  child: BlocBuilder<BankDetailsBloc, BankDetailsState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(title: 'Enter Bank Details'),
                            CustomTextField(
                              label: 'Account Holder Name*',
                              hintText: 'Enter Account Holder Name',
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                context.read<BankDetailsBloc>().add(
                                  AccountHolderNameChanged(value),
                                );
                              },
                            ),
                            CustomTextField(
                              label: 'Account Number*',
                              hintText: 'Enter Account Number',
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                context.read<BankDetailsBloc>().add(
                                  AccountNumberChanged(value),
                                );
                              },
                            ),
                            CustomTextField(
                              label: 'Bank Name*',
                              hintText: 'Enter Bank Name',
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                context.read<BankDetailsBloc>().add(
                                  BankNameChanged(value),
                                );
                              },
                            ),
                            CustomTextField(
                              label: 'IFSC Code*',
                              hintText: 'Enter IFSC Code',
                              maxLength: 11,
                              inputFormatters: [
                                TextInputFormatter.withFunction(
                                  (oldValue, newValue) => TextEditingValue(
                                    text: newValue.text.toUpperCase(),
                                    selection: newValue.selection,
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                context.read<BankDetailsBloc>().add(
                                  IfscCodeChanged(value),
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.borderLight,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: CustomText(
                                      text: 'OR',
                                      fontSize: 14,
                                      fontWeight: FontWeightType.medium,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColors.borderLight,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              label: 'UPI ID',
                              hintText: 'UPI ID',
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                context.read<BankDetailsBloc>().add(
                                  UpiIdChanged(value),
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            PrimaryButton(
                              label: 'Continue',
                              onPressed: state.canContinue
                                  ? () {
                                      context.read<BankDetailsBloc>().add(
                                        const BankDetailsSubmitted(),
                                      );
                                      // TODO: Navigate to success or back to credits
                                      context.pop();
                                    }
                                  : null,
                              isLoading: state.isLoading,
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
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
