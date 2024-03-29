import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/features/auth/views/login_screen.dart';
import 'package:newbee_talk/features/auth/views/sign_up_screen.dart';
import 'package:newbee_talk/features/main/views/main_screen.dart';
import 'package:newbee_talk/features/splash/splash_screen.dart';

class GetRouter {
  late String page;

  GetRouter(this.page);

  static Duration transitionDuration = const Duration(milliseconds: 100);

  static Transition transition = Transition.fadeIn;

  static Map<String, Widget> get pages => {
        SplashScreen.routeName: const SplashScreen(),
        MainScreen.routeName: const MainScreen(),
        LoginScreen.routeName: const LoginScreen(),
        SignUpScreen.routeName: const SignUpScreen(),
      };

  static List<GetPage> get pagesList => pages.entries
      .map(
        (page) => GetPage(
          name: page.key,
          page: () => page.value,
          transitionDuration: transitionDuration,
          transition: transition,
        ),
      )
      .toList();

  factory GetRouter.splash() => GetRouter(SplashScreen.routeName);

  factory GetRouter.main() => GetRouter(MainScreen.routeName);

  factory GetRouter.login() => GetRouter(LoginScreen.routeName);

  factory GetRouter.signUp() => GetRouter(SignUpScreen.routeName);

  /// Navigate to PushNamed
  void to({required dynamic args}) {
    Get.toNamed(
      page,
      arguments: args,
    );
  }

  /// Pop & PushNamed
  void off({required dynamic args}) {
    Get.offNamed(
      page,
      arguments: args,
    );
  }

  /// Replace & PushNamed
  void offAll({required dynamic args}) {
    Get.offAllNamed(
      page,
      arguments: args,
    );
  }
}
