import 'package:result_dart/result_dart.dart';
import 'package:roupaspet/src/core/app_exception.dart';

import '../models/account_model.dart';

abstract class AccountRepository {
  AsyncResult<AccountModel, AppException> login(String email, String password);
  AsyncResult<void, AppException> register(AddAccountParams params);
}

class AddAccountParams {
  String name;
  String email;
  String password;
  String street;
  String houseNumber;
  String neighborhood;
  String city;
  String state;
  String zipcode;

  AddAccountParams({
    this.name = '',
    this.email = '',
    this.password = '',
    this.street = '',
    this.houseNumber = '',
    this.neighborhood = '',
    this.city = '',
    this.state = '',
    this.zipcode = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email.trim().toLowerCase(),
      'password': password,
      'street': street,
      'houseNumber': houseNumber,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
      'zipcode': zipcode,
    };
  }
}
