import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_mediaquery.dart';
import '../../../profile/presentation/widgets/profile_completion_dialog.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final String? gender;
  final bool showCompletionDialog;

  const HomeScreen({
    super.key,
    required this.userName,
    this.gender,
    this.showCompletionDialog = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _bannerController;

  int _currentBanner = 0;

  @override
  void initState() {
    super.initState();
    _bannerController = PageController(
      viewportFraction: 0.88, // ⭐ KEY LINE (controls side spacing)
    );

    // Show completion dialog after the first frame is rendered
    if (widget.showCompletionDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ProfileCompletionDialog.show(
            context,
            onContinue: () {
              // Dialog will close automatically, no action needed
            },
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  bool get _isFemale => (widget.gender ?? '').toLowerCase() == 'female';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content card
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: height * 0.14, // space for bottom nav button
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(),
                    const SizedBox(height: 16),
                    _buildGreetingSection(),
                    const SizedBox(height: 16),
                    _buildStoriesSection(),
                    // const SizedBox(height: 8),
                    _buildZonesSection(),
                    const SizedBox(height: 16),
                    _buildBannerCarousel(height),
                    const SizedBox(height: 16),
                    _buildSocialSection(),
                  ],
                ),
              ),
            ),

            // Bottom circular home button
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: Center(
                child: Container(
                  width: 64,
                  height: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryLight, AppColors.primaryLight],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 55,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/home.png',
                            width: 24,
                            height: 24,
                          ),
                          // const SizedBox(height: 2),
                          const CustomText(
                            text: 'Home',
                            fontSize: 7,
                            fontWeight: FontWeightType.bold,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            children: [
              Image.asset(
                _isFemale ? 'assets/icons/star.png' : 'assets/icons/coin.png',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 8),
              const CustomText(
                text: '40',
                fontSize: 14,
                fontWeight: FontWeightType.bold,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),
        Row(
          children: [
            _circleIcon('assets/icons/leaderboard.png'),
            const SizedBox(width: 10),
            _circleIcon('assets/icons/chat.png'),
            const SizedBox(width: 10),
            _circleIcon('assets/icons/notification.png'),
          ],
        ),
      ],
    );
  }

  Widget _buildGreetingSection() {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // border: Border.all(
            //   color: AppColors.primaryLight,
            //   width: 2,
            // ),
          ),
          padding: const EdgeInsets.all(3),
          child: ClipOval(
            child: Image.asset('assets/icons/profile.png', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Good Morning, ${widget.userName}',
              fontSize: 16,
              fontWeight: FontWeightType.bold,
              color: AppColors.primary,
            ),
            const SizedBox(height: 2),
            const CustomText(
              text: "Let's Make Friends",
              fontSize: 16,
              fontWeight: FontWeightType.medium,
              color: AppColors.black,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStoriesSection() {
    final stories = [
      {'name': 'You', 'asset': 'assets/icons/My Story.png', 'isAdd': true},
      {'name': 'Little Hearts', 'asset': 'assets/icons/story1.png'},
      {'name': 'Selena', 'asset': 'assets/icons/story2.png'},
      {'name': 'Clara', 'asset': 'assets/icons/story3.png'},
      {'name': 'Diana', 'asset': 'assets/icons/story1.png'},
      {'name': 'Eva', 'asset': 'assets/icons/story2.png'},
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final story = stories[index];
          final isAdd = story['isAdd'] == true;
          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: ClipOval(
                        child: Image.asset(
                          story['asset'] as String,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (isAdd)
                    Positioned(
                      bottom: 0,
                      right: 2,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 14,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 70,
                child: CustomText(
                  text: story['name'] as String,
                  fontSize: 12,
                  fontWeight: FontWeightType.medium,
                  color: AppColors.primary,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: stories.length,
      ),
    );
  }

  Widget _buildZonesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _zoneCard(
            title: 'Friend Zone',
            asset: 'assets/images/friend_zone.png',
            onTap: () {
              // Only male users can access Friend Zone Explore
              if (!_isFemale) {
                context.go('/explore');
              }
            },
          ),
          _zoneCard(
            title: 'Date Zone',
            asset: 'assets/images/date_zone.png',
            onTap: () {
              // TODO: Dispatch Date Zone navigation event via Bloc
            },
          ),
          _zoneCard(
            title: 'HangOut Zone',
            asset: 'assets/images/hangout_zone.png',
            onTap: () {
              // TODO: Dispatch HangOut Zone navigation event via Bloc
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel(double height) {
    final banners = [
      'assets/images/banner1.png',
      'assets/images/banner2.png',
      'assets/images/banner3.png',
    ];

    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(120),
          child: PageView.builder(
            controller: _bannerController,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentBanner = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(banners[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentBanner == index
                    ? AppColors.dateMode.withOpacity(0.5)
                    : AppColors.grey.withOpacity(0.4),
                border: Border.all(color: AppColors.borderLight, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/join_us.png', width: 26, height: 26),
            const SizedBox(width: 8),
            const CustomText(
              text: 'Join Us On',
              fontSize: 12,
              fontWeight: FontWeightType.bold,
              color: AppColors.primary,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialItem(icon: 'assets/icons/instagram.png', label: 'Instagram'),
            const SizedBox(width: 24),
            _socialItem(icon: 'assets/icons/facebook.png', label: 'Facebook'),
            const SizedBox(width: 24),
            _socialItem(icon: 'assets/icons/whatsapp.png', label: 'WhatsApp'),
          ],
        ),
      ],
    );
  }

  Widget _circleIcon(String asset) {
    return Center(child: Image.asset(asset, width: 28, height: 28));
  }

  Widget _zoneCard({
    required String title,
    required String asset,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 152,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.9),
            border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  // color: background,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(asset, fit: BoxFit.contain),
              ),
              const SizedBox(height: 12),
              CustomText(
                text: title,
                fontSize: 12,
                fontWeight: FontWeightType.bold,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialItem({required String icon, required String label}) {
    return Column(
      children: [
        Center(child: Image.asset(icon, width: 26, height: 26)),
        const SizedBox(height: 6),
        CustomText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeightType.medium,
          color: AppColors.textSecondary,
        ),
      ],
    );
  }
}
