import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/utils/app_mediaquery.dart';

class BottomSheetOtp extends StatefulWidget {
  final String phoneNumber;
  final String otp;
  final bool termsAccepted;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onContinue;
  final VoidCallback onResend;

  const BottomSheetOtp({
    super.key,
    required this.phoneNumber,
    required this.otp,
    required this.termsAccepted,
    required this.onOtpChanged,
    required this.onContinue,
    required this.onResend,
  });

  @override
  State<BottomSheetOtp> createState() => _BottomSheetOtpState();
}

class _BottomSheetOtpState extends State<BottomSheetOtp> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _resendTimer = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    final otp = _controllers.map((c) => c.text).join();
    widget.onOtpChanged(otp);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Auto Detecting OTP',
            fontSize: 20,
            fontWeight: FontWeightType.semiBold,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 8),
          CustomText(
            text: 'We have sent the OTP  Sent  to +91 ${widget.phoneNumber}',
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(4, (index) {
              return Container(
                width: 50,
                margin: const EdgeInsets.only(right: 16),
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (value) => _onOtpDigitChanged(index, value),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.borderLight,
                        width: 2,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  style: GoogleFonts.nunito(
                    fontSize: getProportionateScreenHeight(24),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.otp.length == 4 ? widget.onContinue : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonPrimary,
                disabledBackgroundColor: AppColors.buttonDisabled,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const CustomText(
                text: 'Continue',
                fontSize: 16,
                fontWeight: FontWeightType.semiBold,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: "Didn't receive? ",
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                GestureDetector(
                  onTap: _resendTimer == 0
                      ? () {
                          setState(() => _resendTimer = 30);
                          _startTimer();
                          widget.onResend();
                        }
                      : null,
                  child: CustomText(
                    text: 'Resend Code',
                    fontSize: 14,
                    fontWeight: FontWeightType.semiBold,
                    color: _resendTimer == 0
                        ? AppColors.textLink
                        : AppColors.textSecondary,
                    decoration: TextDecoration.underline,
                  ),
                ),
                if (_resendTimer > 0)
                  CustomText(
                    text: ' (${_resendTimer}s)',
                    fontSize: 14,
                    color: AppColors.textLink,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
