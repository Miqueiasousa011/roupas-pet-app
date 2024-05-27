import 'package:string_validator/string_validator.dart';

mixin ValidatorsMixin {
  String? requiredValidator(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return message ?? 'Campo obrigatório';
    }

    return null;
  }

  String? emailValidator(String? value, [String? message]) {
    if (value == null || value.isEmpty) {
      return message ?? 'Email obrigatório';
    }

    if (!isEmail(value)) {
      return 'Email inválido';
    }

    return null;
  }

  String? cpfValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'CPF obrigatório';
    }

    if (!RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$').hasMatch(value)) {
      return 'CPF inválido';
    }

    return null;
  }

  String? combinedValidator(List<String? Function()> validators) {
    for (var validator in validators) {
      final result = validator();
      if (result != null) return result;
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha obrigatória';
    }

    if (value.length < 6) {
      return 'Senha deve ter no mínimo 6 caracteres';
    }

    return null;
  }
}
