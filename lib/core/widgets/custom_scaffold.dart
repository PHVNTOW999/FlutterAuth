import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../modules/auth/store/auth_store.dart';

class CustomScaffold extends StatelessWidget {
  final int pageIndex;
  final String title;
  final Widget body;
  final String? backBtn;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;

  const CustomScaffold({
    required this.pageIndex,
    required this.title,
    required this.body,
    this.backBtn,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    super.key,
  });

  void onItemTapped(BuildContext context, int index) {
    if (index == pageIndex) return;

    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/sign-in');
        break;
      case 2:
        context.go('/sign-up');
        break;
    }
  }

  static const anonNavBar = [
    BottomNavigationBarItem(
      icon: Icon(Icons.login),
      label: 'Auth',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Sign In',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Sign Up',
    ),
  ];

  static const authNavBar = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Sign In',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Sign Up',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthStore>().state;

    return Scaffold(
      appBar: backBtn != null
          ? AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(title),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  GoRouter.of(context).go(backBtn!);
                },
              ),
              automaticallyImplyLeading: true,
            )
          : AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(title),
            ),
      body: body,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: authState is AuthUser
          ? BottomNavigationBar(
              currentIndex: pageIndex,
              onTap: (index) => onItemTapped(context, index),
              items: authNavBar,
            )
          : BottomNavigationBar(
              currentIndex: pageIndex,
              onTap: (index) => onItemTapped(context, index),
              items: anonNavBar,
            ),
    );
  }
}
