import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/order_item_model.dart';

part 'shopping_cart_state.dart';

class ShoppingCartCubit extends Cubit<ShoppingCartState> {
  ShoppingCartCubit() : super(const ShoppingCartState([]));

  void addProduct(OrderItemModel item) {
    final items = List<OrderItemModel>.from(state.items);

    if (items.contains(item)) {
      final index = items.indexWhere((e) => e.product == item.product);
      final itemz = items[index];
      itemz.copyWith(quantity: item.quantity + 1);
      items[index] = itemz;
    } else {
      items.add(item);
    }

    emit(state.copyWith(items: items));
  }

  void removeProduct(OrderItemModel item) {
    final items = List<OrderItemModel>.from(state.items);
    items.remove(item);
    emit(state.copyWith(items: items));
  }

  void clear() {
    emit(state.copyWith(items: []));
  }
}
