part of 'extensions.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Size get size => MediaQuery.sizeOf(this);

  double get width => size.width;

  double get height => size.height;

  bool get isMobile => size.width < 701;

  bool get isDarkMode => colorScheme.brightness == Brightness.dark;

  bool get isLightMode => colorScheme.brightness == Brightness.light;

  ThemeMode get themeMode => switch (colorScheme.brightness) {
        Brightness.light => ThemeMode.light,
        Brightness.dark => ThemeMode.dark,
      };

  AppColors get colors => AppColors();

  void showSnackbar(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    Duration? duration,
  }) {
    final scaffold = ScaffoldMessenger.maybeOf(this);

    if (scaffold != null) {
      scaffold.removeCurrentSnackBar();
      scaffold.showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          content: Text(
            message,
            style: textTheme.bodyMedium?.copyWith(
              color: textColor,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: duration ?? const Duration(seconds: 2),
        ),
      );
    }
  }

  void showSuccessSnackbar(
    String message, {
    Duration? duration,
  }) {
    return showSnackbar(
      message,
      duration: duration,
      backgroundColor: colors.success,
      textColor: colors.nutral10,
    );
  }

  void showErrorSnackbar(
    String message, {
    Duration? duration,
  }) {
    return showSnackbar(
      message,
      duration: duration,
      backgroundColor: colors.error,
      textColor: colors.nutral10,
    );
  }

  Future<S?> showPopup<S>({
    List<Widget> children = const [],
    Widget? child,
    double spacing = 16.0,
    BoxConstraints constraints = const BoxConstraints(maxWidth: 400),
    Duration transitionDuration = const Duration(milliseconds: 300),
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    GlobalKey<FormState>? formKey,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog<S>(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'Popup',
      transitionDuration: transitionDuration,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOut));
        return ScaleTransition(
          scale: animation.drive(tween),
          child: child,
        );
      },
      pageBuilder: (context, first, second) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ConstrainedBox(
            constraints: constraints,
            child: Form(
              key: formKey,
              child: child ??
                  Column(
                    mainAxisSize: mainAxisSize,
                    crossAxisAlignment: crossAxisAlignment,
                    mainAxisAlignment: mainAxisAlignment,
                    children: children,
                  ).applySpacing(
                    spacing: spacing,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  ),
            ),
          ),
        );
      },
    );
  }
}
