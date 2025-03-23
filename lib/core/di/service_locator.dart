import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth/modules/auth/auth.dart';
import 'package:get_it/get_it.dart';
import '../../firebase_options.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  try {
    getIt.registerLazySingleton(() => FirebaseAuth.instance);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    AuthModule.registerDependencies();
  } catch (e) {
    print("Firebase Error: $e");
  }
}
