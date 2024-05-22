import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/navigation_cubit.dart';
import 'ui/pages/navigation_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<NavigationCubit>((i) => NavigationCubit()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => const NavigationPage(),
          children: [],
        ),
      ];
}
