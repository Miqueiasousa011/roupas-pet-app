import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final cepMask = MaskTextInputFormatter(
  mask: '#####-###',
  filter: {'#': RegExp('[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
