import 'package:go_router/go_router.dart';
import '../profile/pages/profile_page.dart';
import 'pages/sign_in_page.dart';

class AuthModule {
  static void registerDependencies() {
    // Здесь можно добавить DI (например, GetIt)
  }

  static GoRoute routes() {
    return GoRoute(
      path: '/',
      builder: (context, state) => ProfilePage(title: 'Profile'),
      routes: [
        GoRoute(
          path: 'sign-in',
          name: 'sign-in',
          builder: (context, state) => SignInPage(title: 'Sign In'),
        ),
      ],
    );
  }
}