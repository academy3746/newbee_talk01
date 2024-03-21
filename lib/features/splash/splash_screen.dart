import 'package:flutter/material.dart';
import 'package:newbee_talk/common/constants/sizes.dart';
import 'package:newbee_talk/features/auth/views/login_screen.dart';
import 'package:newbee_talk/features/main/views/main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Initialize Supabase
  final _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();

    _navigateProcess();
  }

  Future<void> _navigateProcess() async {
    var login = _supabase.auth.currentUser;

    if (login == null) {
      Future.delayed(const Duration(seconds: 3), () async {
        await Navigator.pushReplacementNamed(
          context,
          LoginScreen.routeName,
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () async {
        await Navigator.pushReplacementNamed(
          context,
          MainScreen.routeName,
        );
      });
    }
  }

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
