import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import '../../firebase_options.dart';
import '../../modules/auth/auth.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AuthModule.registerDependencies();
}
