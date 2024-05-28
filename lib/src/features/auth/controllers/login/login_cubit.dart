import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roupaspet/src/features/auth/controllers/state/auth_state.dart';

import '../../../../core/services/local_storage/local_storage_service.dart';
import '../../repositories/account_repository.dart';

class LoginCubit extends Cubit<AuthState> {
  final AccountRepository _accountRepository;
  final LocalStorageService _localStorageService;

  LoginCubit(this._accountRepository, this._localStorageService) : super(AuthInitial());

  String email = '';
  String password = '';

  void loginWithCredentials() async {
    emit(AuthLoading());

    await _localStorageService.clear();

    final result = await _accountRepository.login(email, password);
    result.fold(
      (data) async {
        await _localStorageService.set<String>('token', data.token);

        emit(AuthSuccess());
      },
      (failure) => emit(AuthError(failure.message)),
    );
  }
}
