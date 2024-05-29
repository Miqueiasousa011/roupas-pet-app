import 'package:result_dart/result_dart.dart';

import '../../../core/app_exception.dart';
import '../models/order_model.dart';

abstract class OrderRepository {
  AsyncResult<bool, AppException> finalizeOrder(Map<String, dynamic> data);

  AsyncResult<List<OrderModel>, AppException> getOrders();
}
