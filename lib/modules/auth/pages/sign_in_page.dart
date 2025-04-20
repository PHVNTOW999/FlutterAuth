import 'package:flutter/material.dart';
import 'package:flutter_auth/core/widgets/custom_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/notificator.dart';
import '../store/auth_store.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageIndex: 2,
      title: 'Sign In',
      backBtn: '/',
      body: BlocListener<AuthStore, AuthState>(
        listener: (context, state) {
          if (state is AuthUser) {
            GoRouter.of(context).go('/');
          } else if (state is AuthError) {
            Notificator.error(context, state.message);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthStore>().add(
                        AuthSignIn(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        ),
                      );
                },
                child: Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
