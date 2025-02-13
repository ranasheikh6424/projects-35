import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ResetPasswordController.dart';
import '../utils/AppColors.dart';
import '../widgets/ScreenBackGround.dart';
import 'SignInScreen.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  static const String name = '/reset-password';

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ResetPasswordController _controller =
      Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    final String email =
        "rana6424sheikh@gmail.com"; // Replace with dynamic email
    final String otp = "802970"; // Replace with the OTP saved in your app

    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text('Reset Password',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text('Enter your new password below.',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 24),

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 12),

              // Confirm Password Field
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              Obx(() => ElevatedButton(
                    onPressed: _controller.inProgress.value
                        ? null
                        : () async {
                            String password = _passwordController.text.trim();
                            String confirmPassword =
                                _confirmPasswordController.text.trim();

                            bool success = await _controller.resetPassword(
                              email,
                              password,
                              otp,
                              confirmPassword,
                            );

                            if (success) {
                              Get.offAll(() => SignInScreen());
                              Get.snackbar(
                                  "Success", "Password reset successfully!",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white);
                            } else {
                              Get.snackbar(
                                  "Error", _controller.errorMessage.value,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            }
                          },
                    child: _controller.inProgress.value
                        ? const CircularProgressIndicator()
                        : const Text("Reset Password"),
                  )),

              const SizedBox(height: 12),

              // Error Message
              Obx(() => _controller.errorMessage.value.isNotEmpty
                  ? Text(
                      _controller.errorMessage.value,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  : const SizedBox()),

              const SizedBox(height: 48),

              // Sign In Redirect
              Center(
                child: TextButton(
                  onPressed: () => Get.offAll(() => SignInScreen()),
                  child: const Text("Back to Sign In",
                      style: TextStyle(color: AppColors.themeColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
