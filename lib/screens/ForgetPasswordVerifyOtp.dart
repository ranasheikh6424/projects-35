import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../controllers/ForgerPasswordVerifyOTP.dart';
import '../utils/AppColors.dart';
import '../widgets/ScreenBackGround.dart';
import 'ResetPasswordScreen.dart';
import 'SignInScreen.dart';

class ForgotPasswordVerifyOtpScreen extends StatelessWidget {
  ForgotPasswordVerifyOtpScreen({super.key});

  static const String name = '/forgot-password/verify-otp';

  final TextEditingController _otpController = TextEditingController();
  final ForgetPasswordVerifyOTPController _controller =
      Get.put(ForgetPasswordVerifyOTPController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text('PIN Verification',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                'A 6-digit OTP has been sent to your email address',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 24),
              _buildPinCodeTextField(context),
              const SizedBox(height: 24),
              Obx(() => ElevatedButton(
                    onPressed: _controller.inProgress.value
                        ? null
                        : () async {
                            String enteredOtp = _otpController.text.trim();
                            if (enteredOtp.length != 6) {
                              Get.snackbar("Error", "OTP must be 6 digits",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                              return;
                            }

                            bool success = await _controller.recoverVerifyOTP(
                                "rana6424sheikh@gmail.com", enteredOtp);

                            if (success) {
                              Get.to(() => ResetPasswordScreen());
                            }
                          },
                    child: _controller.inProgress.value
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.arrow_circle_right_outlined),
                  )),
              const SizedBox(height: 12),
              Obx(() => _controller.errorMessage.value.isNotEmpty
                  ? Text(
                      _controller.errorMessage.value,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  : const SizedBox()),
              const SizedBox(height: 48),
              Center(child: _buildSignInSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: _otpController,
      appContext: context,
    );
  }

  Widget _buildSignInSection() {
    return RichText(
      text: TextSpan(
        text: "Have an account? ",
        style:
            const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text: 'Sign in',
            style: const TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.offAll(() => const SignInScreen()),
          ),
        ],
      ),
    );
  }
}
