import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_auth/core/widgets/app_scaffold.dart';
import 'package:go_router/go_router.dart';
import '../../auth/store/auth_store.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: title,
      body: Center(
        child: BlocBuilder<AuthStore, AuthState>(
          builder: (context, state) {
            if (state is AuthUser) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello, ${state.user.email}!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthStore>().add(SignOutEvent());
                      context.read<AuthStore>().add(CheckAuthStatusEvent());
                      GoRouter.of(context).go('/sign-in');
                    },
                    child: Text('Sign Out'),
                  ),
                ],
              );
            } else if (state is AuthError) {
              return Text("Error: ${state.message}");
            } else {
              return ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/sign-in');
                },
                child: Text('Sign In'),
              );
            }
          },
        ),
      ),
    );
  }
}
