import 'package:flutter/material.dart';
import 'package:flutter_auth/core/widgets/custom_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/loading_screen.dart';
import '../../auth/store/auth_store.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageIndex: 0,
      title: 'Profile',
      body: BlocBuilder<AuthStore, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingScreen();
          } else if (state is AuthUser) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthStore>().add(AuthSignOut());
                },
                child: Text('Exit ${state.user.email}'),
              ),
            );
          } else {
            return const Center(child: Text('Not authenticated'));
          }
        },
      ),
    );
  }
}
