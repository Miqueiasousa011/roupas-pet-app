part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  /// Retorna a data no formato yyyy-MM-dd
  String get toInternationalStringDate => DateFormat('yyyy-MM-dd').format(this);

  /// Retorna a data no formato dd/MM/yyyy
  String get toViewStringDate => DateFormat('dd/MM/yyyy').format(this);
}
