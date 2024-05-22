import 'package:flutter/material.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';

mixin UtilsMixin<T extends StatefulWidget> on State<T> {
  void showSnackbar(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    Duration? duration,
  }) {
    return context.showSnackbar(
      message,
      backgroundColor: backgroundColor,
      textColor: textColor,
      duration: duration,
    );
  }

  void showErrorSnackbar(
    String message, {
    Duration? duration,
  }) {
    return context.showErrorSnackbar(
      message,
      duration: duration,
    );
  }

  void showSuccessSnackbar(
    String message, {
    Duration? duration,
  }) {
    return context.showSuccessSnackbar(
      message,
      duration: duration,
    );
  }

  Future<S?> showPopup<S>({
    List<Widget> children = const [],
    double spacing = 16.0,
    BoxConstraints constraints = const BoxConstraints(maxWidth: 400),
    Duration transitionDuration = const Duration(milliseconds: 300),
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    GlobalKey<FormState>? formKey,
  }) async {
    return context.showPopup<S>(
      children: children,
      spacing: spacing,
      constraints: constraints,
      transitionDuration: transitionDuration,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      formKey: formKey,
    );
  }

  OverlayEntry? _loadingOverlay;

  void showLoading() {
    removeLoading();

    _loadingOverlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: context.colors.nutral10.withOpacity(0.5),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(context.colors.main),
            ),
          ),
        );
      },
    );

    return Overlay.of(context).insert(_loadingOverlay!);
  }

  void removeLoading() {
    _loadingOverlay?.remove();
    _loadingOverlay = null;
  }
}
