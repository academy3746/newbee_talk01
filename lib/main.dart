import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newbee_talk/features/auth/views/login_screen.dart';
import 'package:newbee_talk/features/auth/views/sign_up_screen.dart';
import 'package:newbee_talk/features/main/views/main_screen.dart';
import 'package:newbee_talk/features/splash/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String supabaseUrl = 'https://bvfrgnkyxgtdfrgxmrol.supabase.co';

  const String supabaseApiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ2ZnJnbmt5eGd0ZGZyZ3htcm9sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDkzNjg0NzMsImV4cCI6MjAyNDk0NDQ3M30.SYPWJrTJDDquFfZCdS8X4L0iN-q3fsKB_vdWBEIPvyo';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseApiKey,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const TalkApp());
}

class TalkApp extends StatelessWidget {
  const TalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talk App',
      theme: ThemeData(
        primaryColor: const Color(0xFF80CBC4),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
      },
    );
  }
}
