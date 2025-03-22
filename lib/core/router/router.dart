import 'package:go_router/go_router.dart';
import '../../modules/auth/auth.dart';
import '../../modules/auth/pages/sign_in_page.dart';
import '../../modules/profile/pages/profile_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ProfilePage(title: 'Profile'),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => ProfilePage(title: 'Profile'),
    ),
    AuthModule.routes(),
  ],
);