import 'package:flutter/material.dart';

mixin HideKeyboardMixin<T extends StatefulWidget> on State<T> {
  void hindeKeyBoard() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
