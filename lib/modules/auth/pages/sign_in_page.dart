import 'package:flutter/material.dart';
import 'package:flutter_auth/core/widgets/app_scaffold.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.title});

  final String title;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: widget.title, body: Center(child: Text('GGG')));
  }
}
