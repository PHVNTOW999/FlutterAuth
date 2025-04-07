import 'package:go_router/go_router.dart';
import '../../modules/auth/auth.dart';
import '../../modules/profile/pages/profile_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => ProfilePage(),
    ),
    ...AuthModule.routes,
  ],
);