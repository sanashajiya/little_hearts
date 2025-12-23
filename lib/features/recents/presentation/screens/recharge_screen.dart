import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/zone_theme.dart';
import '../../../../core/cubit/zone_cubit.dart';
import '../bloc/recharge_cubit.dart';

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RechargeCubit(),
      child: const _RechargeView(),
    );
  }
}

class _RechargeView extends StatelessWidget {
  const _RechargeView();

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.dark, AppColors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(width: 8),
                    const CustomText(
                      text: 'Recharge',
                      fontSize: 22,
                      fontWeight: FontWeightType.bold,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                // width: 80,
                height: 180,
                child: BlocBuilder<RechargeCubit, RechargeState>(
                  builder: (context, state) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final pack = _topPacks[index];
                        final isSelected = state.selectedTopPackIndex == index;
                        return GestureDetector(
                          onTap: () => context
                              .read<RechargeCubit>()
                              .selectTopPack(index),
                          child: _TopPackCard(
                            coinsLabel: pack.coinsLabel,
                            priceLabel: pack.priceLabel,
                            nameLabel: pack.nameLabel,
                            isPopular: pack.isPopular,
                            isSelected: isSelected,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  text: 'More Packs',
                  fontSize: 22,
                  fontWeight: FontWeightType.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.56,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: _MorePackCard(
                        coins: '1000',
                        oldPrice: '₹1800',
                        newPrice: '₹1200',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: _MorePackCard(
                        coins: '1200',
                        oldPrice: '₹2000',
                        newPrice: '₹1500',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: _MorePackCard(
                        coins: '5000',
                        oldPrice: '₹3000',
                        newPrice: '₹2200',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: _MorePackCard(
                        coins: '7000',
                        oldPrice: '₹4000',
                        newPrice: '₹3000',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: _MorePackCard(
                        coins: '10000',
                        oldPrice: '₹6000',
                        newPrice: '₹5000',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: _MorePackCard(
                        coins: '12000',
                        oldPrice: '₹7000',
                        newPrice: '₹6500',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {},
                    child: const CustomText(
                      text: 'Recharge',
                      fontSize: 18,
                      fontWeight: FontWeightType.bold,
                      color: AppColors.white,
                    ),
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

class _TopPackConfig {
  final String coinsLabel;
  final String priceLabel;
  final String nameLabel;
  final bool isPopular;

  const _TopPackConfig({
    required this.coinsLabel,
    required this.priceLabel,
    required this.nameLabel,
    this.isPopular = false,
  });
}

const List<_TopPackConfig> _topPacks = [
  _TopPackConfig(
    coinsLabel: '100 Coins',
    priceLabel: '₹199',
    nameLabel: 'Mini Pack',
  ),
  _TopPackConfig(
    coinsLabel: '300 Coins',
    priceLabel: '₹300',
    nameLabel: 'Mega Pack',
  ),
  _TopPackConfig(
    coinsLabel: '500 Coins',
    priceLabel: '₹1000',
    nameLabel: 'VIP Pack',
    isPopular: true,
  ),
];

class _TopPackCard extends StatelessWidget {
  final String coinsLabel;
  final String priceLabel;
  final String nameLabel;
  final bool isPopular;
  final bool isSelected;

  const _TopPackCard({
    required this.coinsLabel,
    required this.priceLabel,
    required this.nameLabel,
    required this.isPopular,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/recharge_bg.png',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.black.withOpacity(0.25),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/coin.png',
                            width: 28,
                            height: 28,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAB308),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: CustomText(
                              text: coinsLabel,
                              fontSize: 12,
                              fontWeight: FontWeightType.bold,
                              color: const Color(0xFF8A5B00),
                            ),
                          ),
                          const SizedBox(height: 6),
                          CustomText(
                            text: priceLabel,
                            fontSize: 16,
                            fontWeight: FontWeightType.bold,
                            color: const Color(0xFFECC617),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isPopular)
                Positioned(
                  top: 6,
                  right: -10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE53935),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const CustomText(
                      text: 'Popular',
                      fontSize: 10,
                      fontWeight: FontWeightType.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          CustomText(
            text: nameLabel,
            fontSize: 15,
            fontWeight: FontWeightType.semiBold,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }
}

class _MorePackCard extends StatelessWidget {
  final String coins;
  final String oldPrice;
  final String newPrice;

  const _MorePackCard({
    required this.coins,
    required this.oldPrice,
    required this.newPrice,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);
    return Column(
      children: [
        // CARD + SAVE BADGE
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset('assets/icons/coin.png', width: 32, height: 32),
                  const SizedBox(height: 10),
                  CustomText(
                    text: coins,
                    fontSize: 16,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.black,
                  ),
                  const SizedBox(height: 2),
                  CustomText(
                    text: 'Coins',
                    fontSize: 14,
                    fontWeight: FontWeightType.medium,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),

            // SAVE 20% OFF BADGE (ON BORDER)
            Positioned(
              bottom: -12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.dark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const CustomText(
                    text: 'Save 20%Off',
                    fontSize: 10,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        // OLD PRICE (STRIKE)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: oldPrice,
              fontSize: 10,
              fontWeight: FontWeightType.medium,
              color: AppColors.textSecondary,
              decoration: TextDecoration.lineThrough,
            ),
            const SizedBox(width: 6),
            // NEW PRICE
            CustomText(
              text: newPrice,
              fontSize: 13,
              fontWeight: FontWeightType.bold,
              color: AppColors.black,
            ),
          ],
        ),

        const SizedBox(height: 4),
      ],
    );
  }
}
