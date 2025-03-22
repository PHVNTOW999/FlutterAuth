import 'package:flutter/material.dart';
import 'package:flutter_auth/core/widgets/app_scaffold.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.title,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/sign-in'); // Переход на профиль
          },
          child: Text('Открыть профиль'),
        ),
      ),
    );
  }
}
