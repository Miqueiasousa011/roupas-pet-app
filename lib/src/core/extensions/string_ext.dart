import 'package:intl/intl.dart';

extension StringExt on String {
  String get toUSDate => isNotEmpty ? split('/').reversed.join('-') : this;
  String get toBRDate => isNotEmpty ? split('-').reversed.join('/') : this;

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}

extension DoubleExtension on double {
  String get toBRL {
    final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return format.format(this);
  }
}
