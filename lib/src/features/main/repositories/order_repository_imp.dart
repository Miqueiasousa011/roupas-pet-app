import 'package:result_dart/result_dart.dart';

import '../../../core/app_exception.dart';
import '../../../core/services/http/http_service.dart';
import '../models/order_model.dart';
import 'order_repository.dart';

class OrderRepositoryImp implements OrderRepository {
  final HttpService _httpService;

  OrderRepositoryImp(this._httpService);

  @override
  AsyncResult<bool, AppException> finalizeOrder(Map<String, dynamic> data) async {
    try {
      final response = await _httpService.post('/orders', body: data);

      return response.fold(
        (data) => const Success(true),
        (failure) => Failure(failure),
      );
    } catch (e) {
      return const Failure(UnknownException('ERROR'));
    }
  }

  @override
  AsyncResult<List<OrderModel>, AppException> getOrders() async {
    try {
      final response = await _httpService.get('/orders');

      return response.fold(
        (data) {
          final orders = data.map((e) => OrderModel.fromJson(e)).toList();
          return Success(orders.cast<OrderModel>());
        },
        (failure) => Failure(failure),
      );
    } catch (e) {
      return const Failure(UnknownException('ERROR'));
    }
  }
}
