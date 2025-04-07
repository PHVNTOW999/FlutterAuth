import 'package:flutter_auth/modules/auth/pages/sign_in_page.dart';
import 'package:flutter_auth/modules/auth/pages/sign_up_page.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'store/auth_store.dart';


class AuthModule {
  static void registerDependencies() {
    final getIt = GetIt.I;

    // Registering an AuthRepository so GetIt knows how to create instances
    getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(FirebaseAuth.instance));

    // Register AuthStore as a factory to create a new instance each time
    getIt.registerFactory<AuthStore>(() => AuthStore(getIt<AuthRepository>()));
  }

  // Module routes
  static final routes = [
    GoRoute(
      path: '/sign-in',
      name: 'sign-in',
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: '/sign-up',
      name: 'sign-up',
      builder: (context, state) => SignUpPage(),
    ),
  ];
}
