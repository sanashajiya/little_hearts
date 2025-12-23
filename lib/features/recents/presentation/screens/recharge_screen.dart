import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.friendModeDark, AppColors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    const SizedBox(width: 8),
                    const CustomText(
                      text: 'Recharge',
                      fontSize: 20,
                      fontWeight: FontWeightType.bold,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 130,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _topPackCard('100 Coins', '₹199', 'Mini Pack'),
                    _topPackCard('300 Coins', '₹300', 'Mega Pack'),
                    _topPackCard(
                      '500 Coins',
                      '₹1000',
                      'VIP Pack',
                      isPopular: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CustomText(
                  text: 'More Packs',
                  fontSize: 24,
                  fontWeight: FontWeightType.semiBold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  children: [
                    _morePackCard('1000', '₹1800', '₹1200'),
                    _morePackCard('1200', '₹2000', '₹1500'),
                    _morePackCard('5000', '₹3000', '₹2200'),
                    _morePackCard('7000', '₹4000', '₹3000'),
                    _morePackCard('10000', '₹6000', '₹5000'),
                    _morePackCard('12000', '₹7000', '₹6500'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.friendModeDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {},
                    child: const CustomText(
                      text: 'Recharge',
                      fontSize: 16,
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

  Widget _topPackCard(
    String coins,
    String price,
    String label, {
    bool isPopular = false,
  }) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Center(
            child: Column(
              children: [
                const Icon(
                  Icons.monetization_on,
                  color: AppColors.friendModeDark,
                  size: 32,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: coins,
                  fontSize: 14,
                  fontWeight: FontWeightType.bold,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(height: 2),
                CustomText(
                  text: price,
                  fontSize: 12,
                  fontWeight: FontWeightType.bold,
                  color: AppColors.friendModeDark,
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: label,
                fontSize: 11,
                fontWeight: FontWeightType.medium,
                color: AppColors.textSecondary,
              ),
              if (isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.dateMode,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const CustomText(
                    text: 'Popular',
                    fontSize: 9,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.white,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _morePackCard(String coins, String oldPrice, String newPrice) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        children: [
          Image.asset('assets/icons/coin.png', width: 39, height: 39),
          const SizedBox(height: 2),
          CustomText(
            text: '$coins Coins',
            fontSize: 12,
            fontWeight: FontWeightType.bold,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.friendModeDark,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const CustomText(
              text: 'Save 20%Off',
              fontSize: 9,
              fontWeight: FontWeightType.bold,
              color: AppColors.white,
            ),
          ),
          const Spacer(),
          CustomText(
            text: oldPrice,
            fontSize: 10,
            fontWeight: FontWeightType.medium,
            color: AppColors.textSecondary,
          ),
          CustomText(
            text: newPrice,
            fontSize: 12,
            fontWeight: FontWeightType.bold,
            color: AppColors.friendModeDark,
          ),
        ],
      ),
    );
  }
}
