import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/navigation_cubit.dart';
import 'ui/pages/home/home_page.dart';
import 'ui/pages/home/product_page.dart';
import 'ui/pages/navigation_page.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<NavigationCubit>((i) => NavigationCubit()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => const NavigationPage(),
          children: [
            ChildRoute(
              '/home/',
              child: (_, __) => const HomePage(),
            ),
            ChildRoute(
              '/home/product',
              child: (_, __) => const ProductPage(),
            ),
          ],
        ),
      ];
}
