import 'package:flutter/material.dart';
import 'package:flutter_auth/core/widgets/custom_scaffold.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageIndex: 4,
      title: 'Authorization',
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/sign-in');
            },
            child: const Text('Go to Sign In'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/sign-up');
            },
            child: const Text('Go to Sign Up'),
          ),
        ],
      ),
    );
  }
}
