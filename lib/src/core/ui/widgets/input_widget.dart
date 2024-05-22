part of 'widgets.dart';

enum InputTypes { text, password, date }

class InputWidget extends StatefulWidget {
  const InputWidget._({
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.formatters = const [],
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateChanged,
    this.textInputType,
    required this.type,
  });

  factory InputWidget.text({
    Key? key,
    void Function(String value)? onChanged,
    void Function(String value)? onFieldSubmitted,
    void Function(String? value)? onSaved,
    String? Function(String? value)? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    String? labelText,
    String? hintText,
    bool obscureText = false,
    bool readOnly = false,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    InputController? controller,
    List<TextInputFormatter> formatters = const [],
    TextInputType? textInputType,
  }) {
    return InputWidget._(
      key: key,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: autovalidateMode,
      labelText: labelText,
      hintText: hintText,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      controller: controller,
      formatters: formatters,
      textInputType: textInputType,
      type: InputTypes.text,
    );
  }

  factory InputWidget.password({
    Key? key,
    void Function(String value)? onChanged,
    void Function(String value)? onFieldSubmitted,
    void Function(String? value)? onSaved,
    String? Function(String? value)? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    bool readOnly = false,
    bool enabled = true,
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    InputController? controller,
    List<TextInputFormatter> formatters = const [],
    TextInputType? textInputType,
  }) {
    return InputWidget._(
      key: key,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: autovalidateMode,
      labelText: labelText,
      hintText: hintText,
      obscureText: true,
      readOnly: readOnly,
      enabled: enabled,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      controller: controller,
      formatters: formatters,
      textInputType: textInputType,
      type: InputTypes.password,
    );
  }

  final void Function(DateTime? date)? onDateChanged;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  factory InputWidget.date({
    Key? key,
    void Function(DateTime? value)? onDateChanged,
    void Function(String value)? onFieldSubmitted,
    void Function(String? value)? onSaved,
    String? Function(String? value)? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    bool readOnly = false,
    bool enabled = true,
    String? labelText,
    String? hintText,
    InputController? controller,
    DateTime? initialValue,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return InputWidget._(
      key: key,
      validator: validator ?? _dateValidator,
      autovalidateMode: autovalidateMode,
      labelText: labelText,
      hintText: hintText,
      obscureText: false,
      readOnly: readOnly,
      enabled: enabled,
      controller: controller,
      initialDate: initialValue,
      firstDate: firstDate,
      lastDate: lastDate,
      onDateChanged: onDateChanged,
      formatters: const [_DateInputFormatter()],
      type: InputTypes.date,
    );
  }

  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter> formatters;

  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final AutovalidateMode autovalidateMode;
  final TextInputType? textInputType;
  final InputController? controller;

  final InputTypes type;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late bool obscureText = switch (widget.type) {
    InputTypes.text => false,
    InputTypes.password => true,
    InputTypes.date => false,
  };

  void toggleObsecureText() {
    FocusScope.of(context).requestFocus(widget.controller?.focus);

    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void didUpdateWidget(covariant InputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      final text = widget.controller?.text ?? '';
      final isEmpty = text.isEmpty;
      widget.controller?.value = TextEditingValue(
        text: text,
        selection: switch (isEmpty) {
          true => const TextSelection.collapsed(offset: 0),
          false => oldWidget.controller!.value.selection,
        },
        composing: oldWidget.controller?.value.composing ?? TextRange.empty,
      );
      if (oldWidget.controller?.focus.hasFocus ?? false) {
        widget.controller?.updateFocusNode(oldWidget.controller!.focus);
      }
      oldWidget.controller?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.controller?.focus,
      onChanged: switch (widget.type) {
        InputTypes.text => widget.onChanged,
        InputTypes.password => widget.onChanged,
        InputTypes.date => (value) {
            if (value.isEmpty) return widget.onDateChanged?.call(null);

            final date = _tryParseStrict(value);

            if (date != null) return widget.onDateChanged?.call(date);
          },
      },
      keyboardType: widget.textInputType,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      inputFormatters: widget.formatters,
      readOnly: widget.readOnly,
      obscureText: obscureText,
      style: context.textTheme.bodyMedium?.copyWith(
        fontSize: 14,
        color: context.colors.nutral100,
      ),
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: context.textTheme.bodySmall?.copyWith(
          fontSize: 14,
          color: context.colors.nutral70,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: switch (widget.type) {
          InputTypes.password => IconButton(
              onPressed: toggleObsecureText,
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: context.colors.main,
              ),
            ),
          InputTypes.date => IconButton(
              onPressed: () async {
                FocusScope.of(context).requestFocus(widget.controller?.focus);

                final date = await showDatePicker(
                  context: context,
                  firstDate: widget.firstDate ?? DateTime(2000, 1, 1),
                  lastDate: widget.lastDate ?? DateTime(2999, 12, 31),
                  initialDate: widget.initialDate ?? DateTime.now(),
                );

                if (date != null) {
                  widget.controller?._setDate(date);
                  return widget.onDateChanged?.call(date);
                }
              },
              icon: Icon(
                Icons.calendar_today_outlined,
                color: context.colors.main,
                size: 18,
              ),
            ),
          _ => widget.suffixIcon,
        },
      ),
    );
  }
}

class InputController extends TextEditingController {
  DateTime? date;

  late FocusNode _focus;

  FocusNode get focus => _focus;

  InputController._({super.text, this.date}) : super() {
    _focus = FocusNode();
    addListener(_listenToTextChanges);
  }

  void _listenToTextChanges() {
    final currentText = value.text;

    if (currentText.isEmpty) {
      date = null;
    } else {
      date = _tryParseStrict(currentText);
    }
  }

  factory InputController.text([String? text]) {
    return InputController._(text: text);
  }

  factory InputController.date([DateTime? date]) {
    return InputController._(date: date)
      ..value = TextEditingValue(
        text: date?.toViewStringDate ?? '',
        selection: TextSelection.collapsed(offset: date?.toViewStringDate.length ?? 0),
      );
  }

  factory InputController.fromTextEditingController(TextEditingController controller) {
    return InputController._(text: controller.text);
  }

  void _setDate(DateTime? date) {
    this.date = date;
    value = TextEditingValue(
      text: date?.toViewStringDate ?? '',
      selection: TextSelection.collapsed(offset: date?.toViewStringDate.length ?? 0),
    );
  }

  void updateFocusNode(FocusNode focus) {
    _focus = focus;
  }

  @override
  void dispose() {
    removeListener(_listenToTextChanges);
    super.dispose();
  }
}

class _DateInputFormatter extends TextInputFormatter {
  const _DateInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    const maxLength = 10;
    var newText = newValue.text;

    newText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    var selectionIndex = newValue.selection.end;

    if (newText.length > maxLength) {
      newText = newText.substring(0, maxLength);
    }

    var formattedText = '';

    if (newText.isNotEmpty) {
      formattedText += newText.substring(0, math.min(2, newText.length));
    }

    if (newText.length > 2) {
      formattedText += '/${newText.substring(2, math.min(4, newText.length))}';
    }

    if (newText.length > 4) {
      formattedText += '/${newText.substring(4, math.min(8, newText.length))}';
    }

    selectionIndex += formattedText.length - newValue.text.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

String? _dateValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Data obrigatória';
  }

  if (!RegExp(r'^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$').hasMatch(value)) {
    return 'Data inválida';
  }

  if (_tryParseStrict(value) == null) {
    return 'Data inválida';
  }

  return null;
}

DateTime? _tryParseStrict(String value) {
  if (!RegExp(r'^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$').hasMatch(value)) {
    return null;
  }

  try {
    return DateFormat('dd/MM/yyyy').parseStrict(value);
  } catch (_) {
    return null;
  }
}
