import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'core/di/service_locator.dart';
import 'core/router/router.dart';
import 'modules/auth/store/auth_store.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthStore>(
          create: (context) => GetIt.I<AuthStore>()..add(CheckAuthStatus()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Auth',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}