import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChipInputEntry<T> extends Equatable {
  final T value;
  final String label;

  const ChipInputEntry(this.value, this.label);

  @override
  List<Object?> get props => [value, label];
}

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    super.key,
    required this.values,
    this.suggestionsBuilder,
    this.decoration = const InputDecoration(),
    this.style,
    this.strutStyle,
    required this.chipBuilder,
    this.suggestionBuilder,
    required this.onChanged,
    this.onChipTapped,
    this.onSubmitted,
    this.onTextChanged,
  });

  final List<ChipInputEntry<T>> values;
  final InputDecoration decoration;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T>? onChipTapped;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onTextChanged;

  final Widget Function(BuildContext context, T entry) chipBuilder;
  final Widget Function(BuildContext context, T entry)? suggestionBuilder;
  final Future<List<ChipInputEntry<T>>> Function(String query)? suggestionsBuilder;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>> {
  @visibleForTesting
  late final ChipsInputEditingController<T> controller;

  final ValueNotifier<List<ChipInputEntry<T>>> suggestions = ValueNotifier(<ChipInputEntry<T>>[]);

  String _previousText = '';
  TextSelection? _previousSelection;

  @override
  void initState() {
    super.initState();
    controller = ChipsInputEditingController<T>(
      <ChipInputEntry<T>>[...widget.values],
      widget.chipBuilder,
    );
    controller.addListener(_textListener);
  }

  @override
  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();

    super.dispose();
  }

  void _textListener() {
    final String currentText = controller.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<ChipInputEntry<T>> values = <ChipInputEntry<T>>[...widget.values];

      // If the current number and the previous number of replacements are different, then
      // the user has deleted the InputChip using the keyboard. In this case, we trigger
      // the onChanged callback. We need to be sure also that the current number of
      // replacements is different from the input chip to avoid double-deletion.
      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            if (cursorStart > values.length) {
              values.removeRange(cursorEnd, values.length);
            } else {
              values.removeRange(cursorEnd, cursorStart);
            }
          } else {
            if (cursorEnd > values.length) {
              values.removeRange(cursorStart, values.length);
            } else {
              values.removeRange(cursorStart, cursorEnd);
            }
          }
        }
        widget.onChanged(values.map((entry) => entry.value).toList());
      }
    }

    _previousText = currentText;
    _previousSelection = controller.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits.where((int u) => u == ChipsInputEditingController.kObjectReplacementChar).length;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateValues(<ChipInputEntry<T>>[...widget.values]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          minLines: 1,
          maxLines: 3,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Todos',
          ),
          style: widget.style,
          strutStyle: widget.strutStyle,
          controller: controller,
          onChanged: (String value) async {
            widget.onTextChanged?.call(controller.textWithoutReplacements);
            final result = await widget.suggestionsBuilder?.call(controller.textWithoutReplacements);
            if (result != null) {
              suggestions.value = result.where((e) => !widget.values.any((entry) => entry.value == e.value)).toList();
            }
          },
          onSubmitted: (String value) {
            final filters = suggestions.value.where((entry) {
              final alreadyAdded = widget.values.any((e) => e.value == entry.value);
              final contains = entry.label.toLowerCase().startsWith(controller.textWithoutReplacements.toLowerCase());
              return !alreadyAdded && contains && controller.textWithoutReplacements.isNotEmpty;
            }).toList();
            if (filters.isNotEmpty) {
              suggestions.value = suggestions.value.where((entry) => entry != filters.first).toList();
              widget.onChanged([...widget.values, filters.first].map((entry) => entry.value).toList());
            }
            widget.onSubmitted?.call(controller.textWithoutReplacements);
          },
        ),
        ValueListenableBuilder(
          valueListenable: suggestions,
          builder: (context, value, child) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: value.length,
              itemBuilder: (context, index) {
                final ChipInputEntry<T> entry = value[index];
                return widget.suggestionBuilder?.call(context, entry.value) ??
                    ListTile(
                      title: Text(entry.label),
                      onTap: () {
                        widget.onChanged([...widget.values, entry].map((entry) => entry.value).toList());
                        suggestions.value = List.from(suggestions.value..remove(entry));
                      },
                    );
              },
            );
          },
        ),
      ],
    );
  }
}

class ChipsInputEditingController<T> extends TextEditingController {
  ChipsInputEditingController(this.values, this.chipBuilder)
      : super(
          text: String.fromCharCode(kObjectReplacementChar) * values.length,
        );

  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputChip displayed.
  static const int kObjectReplacementChar = 0xFFFE;

  List<ChipInputEntry<T>> values;

  final Widget Function(BuildContext context, T data) chipBuilder;

  /// Called whenever chip is either added or removed
  /// from the outside the context of the text field.
  void updateValues(List<ChipInputEntry<T>> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    final Iterable<WidgetSpan> chipWidgets = values.map(
      (ChipInputEntry<T> entry) => WidgetSpan(
        child: chipBuilder(context, entry.value),
        alignment: PlaceholderAlignment.middle,
      ),
    );

    return TextSpan(
      style: style,
      children: <InlineSpan>[...chipWidgets, if (textWithoutReplacements.isNotEmpty) TextSpan(text: textWithoutReplacements)],
    );
  }
}
