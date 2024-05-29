import 'package:result_dart/result_dart.dart';

import '../../../core/app_exception.dart';

abstract class OrderRepository {
  AsyncResult<bool, AppException> finalizeOrder(Map<String, dynamic> data);
}
