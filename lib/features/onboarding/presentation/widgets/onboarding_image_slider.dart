import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/onboarding_content.dart';
import 'page_indicator.dart';

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
      color: AppColors.onboardingBg,
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
                  const SizedBox(height: 80),
                  // Title
                  Text(
                    content.title,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'serif',
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      content.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite.withValues(alpha: 0.9),
                        letterSpacing: 1.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Image
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        content.image,
                        fit: BoxFit.contain,
                      ),
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

