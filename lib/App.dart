import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/Add_New_Task_Screen.dart';
import 'package:task_manager/screens/ForgetPasswordVerifyEmail.dart';
import 'package:task_manager/screens/ForgetPasswordVerifyOtp.dart';
import 'package:task_manager/screens/MainBottomNavScreen.dart';
import 'package:task_manager/screens/ResetPasswordScreen.dart';
import 'package:task_manager/screens/SignInScreen.dart';
import 'package:task_manager/screens/SignUpScreen.dart';
import 'package:task_manager/screens/SplashScreen.dart';
import 'package:task_manager/screens/UpdateProfileScreen.dart';
import 'package:task_manager/utils/AppColors.dart';

import 'ControllerBinder.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      navigatorKey: navigatorKey,
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          fillColor: Colors.white,
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == SplashScreen.name) {
          widget = const SplashScreen();
        } else if (settings.name == SignInScreen.name) {
          widget = const SignInScreen();
        } else if (settings.name == SignUpScreen.name) {
          widget = const SignUpScreen();
        } else if (settings.name == ForgotPasswordVerifyEmailScreen.name) {
          widget = ForgotPasswordVerifyEmailScreen();
        } else if (settings.name == ForgotPasswordVerifyOtpScreen.name) {
          widget = ForgotPasswordVerifyOtpScreen();
        } else if (settings.name == ResetPasswordScreen.name) {
          widget = ResetPasswordScreen();
        } else if (settings.name == MainBottomNavScreen.name) {
          widget = const MainBottomNavScreen();
        } else if (settings.name == AddNewTaskScreen.name) {
          widget = AddNewTaskScreen();
        } else if (settings.name == UpdateProfileScreen.name) {
          widget = const UpdateProfileScreen();
        }
        return MaterialPageRoute(builder: (ctx) => widget);
      },
    );
  }
}
