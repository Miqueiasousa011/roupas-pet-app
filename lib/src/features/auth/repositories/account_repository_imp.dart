import 'package:result_dart/result_dart.dart';
import 'package:roupaspet/src/core/app_exception.dart';
import 'package:roupaspet/src/core/services/http/http_service.dart';

import 'package:roupaspet/src/features/auth/models/account_model.dart';

import 'account_repository.dart';

class AccountRepositoryImp implements AccountRepository {
  final HttpService _httpService;

  AccountRepositoryImp(this._httpService);

  @override
  AsyncResult<AccountModel, AppException> login(String email, String password) async {
    try {
      final response = await _httpService.post('/auth/signin', body: {
        'email': email,
        'password': password,
      });

      return response.fold(
        (data) => Success(AccountModel.fromJson(data)),
        (failure) => Failure(failure),
      );
    } catch (e) {
      return const Failure(UnknownException('LOGIN ERROR'));
    }
  }

  @override
  AsyncResult<void, AppException> register(AddAccountParams params) async {
    try {
      final response = await _httpService.post('/auth/signup', body: params.toJson());

      return response.fold(
        (data) => const Success(true),
        (failure) => Failure(failure),
      );
    } catch (e) {
      return const Failure(UnknownException('REGISTER ERROR'));
    }
  }
}
