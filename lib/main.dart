import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/utils/get_put.dart';
import 'package:newbee_talk/features/splash/views/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newbee_talk/get_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_API_KEY'),
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
    return GetMaterialApp(
      title: 'Talk App',
      theme: ThemeData(
        primaryColor: const Color(0xFFFDD835),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      getPages: GetRouter.pagesList,
      initialBinding: BindingsBuilder(GetController.put),
    );
  }
}
