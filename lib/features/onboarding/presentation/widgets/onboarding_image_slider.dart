import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/onboarding_content.dart';
import 'page_indicator.dart';
import '../../../../core/constants/custom_text.dart';

class OnboardingImageSlider extends StatefulWidget {
  final List<OnboardingContent> contents;
  final Function(int) onPageChanged;

  const OnboardingImageSlider({
    super.key,
    required this.contents,
    required this.onPageChanged,
  });

  @override
  State<OnboardingImageSlider> createState() => _OnboardingImageSliderState();
}

class _OnboardingImageSliderState extends State<OnboardingImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < widget.contents.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      color: AppColors.primaryLight.withOpacity(0.95),

      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.contents.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              widget.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              final content = widget.contents[index];
              return Column(
                children: [
                  const SizedBox(height: 120),
                  // Title
                  CustomText(
                    text: content.title,
                    fontFamily: FontFamily.mogra, // 👈 Mogra font
                    fontSize: 32,
                    fontWeight: FontWeightType.medium,
                    color: AppColors.textWhite,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CustomText(
                      text: content.subtitle,
                      fontFamily: FontFamily.mogra, // 👈 Mogra font
                      fontSize: 14,
                      fontWeight: FontWeightType.semiBold,
                      color: AppColors.textWhite.withValues(alpha: 0.9),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Image
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Image.asset(content.image, fit: BoxFit.cover),
                    ),
                  ),
                ],
              );
            },
          ),
          // Page indicator at bottom left
          Positioned(
            left: 24,
            bottom: 24,
            child: PageIndicator(
              currentPage: _currentPage,
              totalPages: widget.contents.length,
            ),
          ),
        ],
      ),
    );
  }
}
