import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/router/router.dart';
import 'firebase_options.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Ошибка инициализации Firebase: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
      // home: const SignInPage(title: 'Sign In'),
    );
  }
}
