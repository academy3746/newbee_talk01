import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newbee_talk/features/auth/views/login_screen.dart';
import 'package:newbee_talk/features/auth/views/sign_up_screen.dart';
import 'package:newbee_talk/features/main/views/main_screen.dart';
import 'package:newbee_talk/features/splash/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  var supabaseUrl = dotenv.get('SUPABASE_URL');

  var supabaseApiKey = dotenv.get('SUPABASE_API_KEY');

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseApiKey,
  );

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
        primaryColor: const Color(0xFFFDD835),
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
