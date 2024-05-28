import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/features/main/controllers/products/products_cubit.dart';
import 'package:roupaspet/src/features/main/repositories/product_repository.dart';
import 'package:roupaspet/src/features/main/ui/pages/home/shopping_cart_page.dart';

import 'controllers/navigation/navigation_cubit.dart';
import 'controllers/shopping_cart/shopping_cart_cubit.dart';
import 'repositories/product_repository_imp.dart';
import 'ui/pages/home/home_page.dart';
import 'ui/pages/home/product_page.dart';
import 'ui/pages/navigation_page.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<ProductRepository>((i) => ProductRepositoryImp(i())),
        Bind.singleton<ProductCubit>((i) => ProductCubit(i())),
        Bind.singleton<NavigationCubit>((i) => NavigationCubit()),
        Bind.singleton<ShoppingCartCubit>((i) => ShoppingCartCubit()),
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
              child: (_, args) => ProductPage(product: args.data),
            ),
            ChildRoute(
              '/home/shopping-cart',
              child: (_, args) => const ShoppingCartPage(),
            ),
          ],
        ),
      ];
}
