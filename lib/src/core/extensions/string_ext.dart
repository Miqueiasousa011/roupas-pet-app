extension StringExt on String {
  String get toUSDate => isNotEmpty ? split('/').reversed.join('-') : this;
  String get toBRDate => isNotEmpty ? split('-').reversed.join('/') : this;

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
