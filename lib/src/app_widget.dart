import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'core/mixins/keyboard_manager_mixin.dart';
import 'core/ui/styles/styles.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with HideKeyboardMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ROUPAS PET',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(context),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
      builder: (context, child) => GestureDetector(
        onTap: hindeKeyBoard,
        child: child,
      ),
    );
  }
}
