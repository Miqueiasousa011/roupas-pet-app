import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final phoneMask = MaskTextInputFormatter(
  mask: '(##) #####-####',
  filter: {'#': RegExp('[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

final cpfMask = MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {'#': RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.eager,
);

final dateMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {'#': RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.eager,
);
