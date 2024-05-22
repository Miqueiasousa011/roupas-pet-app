import 'dart:async';

class Debounce {
  Timer? _timer;

  Debounce();

  void call(FutureOr<void> Function() callback, [Duration duration = const Duration(milliseconds: 500)]) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  FutureOr<T>? future<T>(FutureOr<T> Function() callback, [Duration duration = const Duration(milliseconds: 500)]) async {
    final completer = Completer<T>();
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(duration, () async {
      final result = await callback();
      completer.complete(result);
    });
    return completer.future;
  }
}

void debounce(FutureOr<void> Function() callback, [Duration duration = const Duration(milliseconds: 500)]) {
  return Debounce().call(callback, duration);
}
