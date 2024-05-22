import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/app_paths.dart';

import 'ui/pages/add_account_page.dart';
import 'ui/pages/auth_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        // Bind.singleton((i) => AuthRepository(i.get())),
        // Bind.singleton((i) => AuthBloc(i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const AuthPage()),
        ChildRoute(paths.createAccount, child: (_, __) => const AddAccountPage()),
      ];
}
