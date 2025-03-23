import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/modules/auth/store/auth_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../profile/pages/profile_page.dart';
import 'pages/sign_in_page.dart';

class AuthModule {
  static void registerDependencies() {
    final getIt = GetIt.I;

    // Reg Store
    getIt.registerFactory<AuthStore>(() => AuthStore(getIt<FirebaseAuth>()));
  }

  // Route list
  static GoRoute routes() {
    return GoRoute(
      path: '/',
      builder: (context, state) => ProfilePage(title: 'Profile'),
      routes: [
        GoRoute(
          path: 'sign-in',
          name: 'sign-in',
          builder: (context, state) {
            return BlocProvider(
              create: (context) => GetIt.instance<AuthStore>(),
              child: SignInPage(title: 'Sign In'),
            );
          },
        ),
      ],
    );
  }
}