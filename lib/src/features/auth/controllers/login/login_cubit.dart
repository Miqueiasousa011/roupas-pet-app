import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roupaspet/src/features/auth/controllers/state/auth_state.dart';

import '../../repositories/account_repository.dart';

class LoginCubit extends Cubit<AuthState> {
  final AccountRepository _accountRepository;

  LoginCubit(this._accountRepository) : super(AuthInitial());

  String email = '';
  String password = '';

  void loginWithCredentials() async {
    emit(AuthLoading());
    emit(AuthLoading());
    final result = await _accountRepository.login(email, password);
    result.fold(
      (data) => emit(AuthSuccess()),
      (failure) => emit(AuthError(failure.message)),
    );
  }
}
