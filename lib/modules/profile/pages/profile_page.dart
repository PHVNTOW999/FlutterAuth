import 'package:flutter/material.dart';
import 'package:flutter_auth/core/widgets/custom_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/loading_screen.dart';
import '../../auth/store/auth_store.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Profile',
      body: BlocBuilder<AuthStore, AuthState>(
        builder: (context, state) {
          // If User is loading
          if (state is AuthLoading) {
            return LoadingScreen();
            //   If User is auth
          } else if (state is AuthUser) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthStore>().add(AuthSignOut());
                },
                child: Text('Exit ${state.user.email}'),
              ),
            );
            // If User isn't auth
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
            );
          }
        },
      ),
    );
  }
}
