import 'package:flutter/material.dart';
import 'package:flutter_auth/core/widgets/custom_scaffold.dart';
import 'package:flutter_auth/core/widgets/notificator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../store/auth_store.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageIndex: 3,
      title: 'Sign Up',
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
              TextField(
                controller: rePasswordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthStore>().add(
                        AuthSignUp(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            rePasswordController.text.trim()),
                      );
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
