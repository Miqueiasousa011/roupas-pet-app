import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:roupaspet/src/features/main/models/order_item_model.dart';

import '../../repositories/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderCubit(this._orderRepository) : super(OrderInitial());

  Future<void> finalizeOrder(
      List<OrderItemModel> orderItems, String payment, double shippingCost) async {
    emit(OrderLoading());

    final json = {
      "items": [
        ...orderItems.map(
          (e) => {
            "productId": e.product.id,
            "quantity": e.quantity,
          },
        )
      ],
      "paymentMethod": payment,
      "shippingCost": shippingCost,
    };

    try {
      await _orderRepository.finalizeOrder(json).fold(
            (success) => emit(OrderSuccess()),
            (failure) => emit(OrderError(failure.message)),
          );
    } catch (e) {
      emit(OrderError('Erro ao finalizar pedido'));
    }
  }

  Future<void> getOrders() async {}
}
