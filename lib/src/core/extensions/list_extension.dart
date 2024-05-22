part of 'extensions.dart';

extension ListExtension<T> on List<T> {
  Iterable<S> indexedMap<S extends Object?>(S Function(int index, T item) func) {
    return Iterable.generate(length).map((index) => func(index, this[index]!));
  }

  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }

    return null;
  }
}
