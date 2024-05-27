import 'package:bloc/bloc.dart';

import '../../repositories/account_repository.dart';
import '../state/auth_state.dart';

class AddAccountCubit extends Cubit<AuthState> {
  final AccountRepository _accountRepository;

  AddAccountCubit(this._accountRepository) : super(AuthInitial());

  final _params = AddAccountParams();

  AddAccountParams get params => _params;

  Future<void> addAccount() async {
    emit(AuthLoading());
    final result = await _accountRepository.register(params);
    result.fold(
      (data) => emit(AuthSuccess()),
      (failure) => emit(AuthError(failure.message)),
    );
  }
}
