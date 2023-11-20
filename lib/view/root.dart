import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sirenorder_app/system/color_schemes.g.dart';
import 'package:sirenorder_app/view/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
