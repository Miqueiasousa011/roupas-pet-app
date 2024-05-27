import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/app_paths.dart';
import 'package:roupaspet/src/features/auth/repositories/account_repository_imp.dart';

import 'controllers/add_account/add_account_cubit.dart';
import 'controllers/login/login_cubit.dart';
import 'repositories/account_repository.dart';
import 'ui/pages/add_account_page.dart';
import 'ui/pages/auth_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<AccountRepository>((i) => AccountRepositoryImp(i.get())),
        Bind.singleton<AddAccountCubit>((i) => AddAccountCubit(i())),
        Bind.singleton<LoginCubit>((i) => LoginCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const AuthPage()),
        ChildRoute(paths.createAccount, child: (_, __) => const AddAccountPage()),
      ];
}
