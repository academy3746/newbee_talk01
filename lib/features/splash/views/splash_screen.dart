import 'package:flutter/material.dart';
import 'package:newbee_talk/common/constants/sizes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(
          Sizes.size20,
        ),
        child: Center(
          child: Image.asset(
            'assets/images/splash.jpeg',
            width: Sizes.size200,
            height: Sizes.size200,
          ),
        ),
      ),
    );
  }
}
