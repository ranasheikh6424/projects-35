import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ForgetPasswordVerifyEmail.dart';
import '../utils/AppColors.dart';
import '../widgets/ScreenBackGround.dart';
import 'ForgetPasswordVerifyOtp.dart';

class ForgotPasswordVerifyEmailScreen extends StatelessWidget {
  ForgotPasswordVerifyEmailScreen({super.key});

  static const String name = '/forgot-password/verify-email';

  final TextEditingController _emailController = TextEditingController();
  final _controller = Get.put(ForgetPasswordVerifyEmailController());

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
              Text('Your Email Address',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                'A 6-digit OTP will be sent to your email address',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(height: 24),
              Obx(() => ElevatedButton(
                    onPressed: _controller.inProgress.value
                        ? null
                        : () async {
                            bool success = await _controller
                                .recoverVerifyEmail(_emailController.text);
                            if (success) {
                              Get.to(() => ForgotPasswordVerifyOtpScreen());
                            }
                          },
                    child: _controller.inProgress.value
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.arrow_circle_right_outlined),
                  )),
              const SizedBox(height: 48),
              Center(child: _buildSignInSection()),
            ],
          ),
        ),
      ),
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
            recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
          ),
        ],
      ),
    );
  }
}
