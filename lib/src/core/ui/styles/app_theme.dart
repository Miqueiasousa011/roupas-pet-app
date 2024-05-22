part of 'styles.dart';

class AppTheme {
  static AppColors get colors => AppColors();

  static ThemeData light(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: false,
      scaffoldBackgroundColor: colors.nutral10,
      cardColor: colors.nutral10,
      scrollbarTheme: const ScrollbarThemeData(
        thumbVisibility: WidgetStatePropertyAll(true),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.main,
        elevation: 1,
        iconTheme: IconThemeData(color: colors.nutral10),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.main,
          foregroundColor: colors.nutral10,
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          padding: const EdgeInsets.all(10),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          fixedSize: const Size.fromHeight(40.0),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colors.nutral10,
          foregroundColor: colors.main,
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          side: BorderSide(color: colors.main),
          padding: const EdgeInsets.all(10),
          fixedSize: const Size.fromHeight(40.0),
        ),
      ),
      inputDecorationTheme: _buildInputDecoration(
        labelColor: colors.nutral50,
        fillColor: WidgetStateColor.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return colors.nutral20;
            }

            return colors.nutral10;
          },
        ),
        borderColor: colors.main,
        errorBorderColor: colors.error,
        focusedBorderColor: colors.main,
        errorFocusedBorderColor: colors.error,
        enabledBorderColor: colors.main,
        disabledBorderColor: colors.main,
      ),
      textTheme: GoogleFonts.montserratTextTheme(),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.main,
        selectionColor: colors.primary20,
        selectionHandleColor: colors.primary20,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecoration({
    required Color labelColor,
    required Color borderColor,
    required Color errorBorderColor,
    required Color focusedBorderColor,
    required Color errorFocusedBorderColor,
    required Color enabledBorderColor,
    required Color disabledBorderColor,
    required Color fillColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      prefixIconColor: labelColor,
      suffixIconColor: labelColor,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: fillColor,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: errorBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focusedBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: enabledBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: disabledBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
