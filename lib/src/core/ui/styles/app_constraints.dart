part of 'styles.dart';

class AppConstraints {
  static const double _base = 8.0;

  /// Multiplica 8 por 1!
  static double get x1 => _base;

  /// Multiplica 8 por 2!
  static double get x2 => _base * 2;

  /// Multiplica 8 por 3!
  static double get x3 => _base * 3;

  /// Multiplica 8 por 4!
  static double get x4 => _base * 4;

  /// Multiplica 8 por 6!
  static double get x6 => _base * 6;

  /// Multiplica 8 por 8!
  static double get x8 => _base * 8;

  /// Multiplica 8 por 16!
  static double get x16 => _base * 16;

  /// Multiplica 8 por 32!
  static double get x32 => _base * 32;

  /// Multiplica 8 por 48!
  static double get x48 => _base * 48;

  /// Multiplica 8 por 64!
  static double get x64 => _base * 64;

  /// Multiplica 8 pelo valor informado!
  static double xCustom(double value) => _base * value;
}
