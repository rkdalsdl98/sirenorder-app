import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sirenorder_app/bloc/menu/menu_bloc.dart';
import 'package:sirenorder_app/bloc/regist/regist_bloc.dart';
import 'package:sirenorder_app/bloc/user/user_bloc.dart';
import 'package:sirenorder_app/datasource/local_manager.dart';
import 'package:sirenorder_app/respository/menu_repository.dart';
import 'package:sirenorder_app/respository/user_repository.dart';
import 'package:sirenorder_app/system/color_schemes.g.dart';
import 'package:sirenorder_app/view/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => LocalManager()),
        RepositoryProvider(
            create: (repoContext) =>
                UserRepository(repoContext.read<LocalManager>())),
        RepositoryProvider(
            create: (repoContext) =>
                MenuRepository(repoContext.read<LocalManager>())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (blocContext) =>
                  UserBloc(blocContext.read<UserRepository>())),
          BlocProvider(
              create: (blocContext) =>
                  MenuBloc(blocContext.read<MenuRepository>())),
        ],
        child: MaterialApp(
          title: "SirenOrder",
          theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
          ),
          supportedLocales: const [
            Locale('ko', 'KR'),
            Locale('en', 'US'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          onGenerateRoute: (settings) => initGeneratedRoutes(settings, context),
        ),
      ),
    );
  }
}
