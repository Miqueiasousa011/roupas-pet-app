import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/services/local_storage/shared_preferences_service.dart';

import 'core/services/http/dio_service.dart';
import 'core/services/http/http_service.dart';
import 'core/services/local_storage/local_storage_service.dart';
import 'features/auth/auth_module.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.instance<LocalStorageService>(SharedPreferencesService()),
        Bind.factory<HttpService>(
          (i) => DioService(const String.fromEnvironment('BASE_URL'), i.get()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: AuthModule(),
          transition: TransitionType.noTransition,
        ),
      ];
}
