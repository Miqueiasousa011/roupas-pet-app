part of 'shopping_cart_cubit.dart';

class ShoppingCartState extends Equatable {
  const ShoppingCartState(this.items);

  final List<OrderItemModel> items;

  double get total => items.fold(0, (total, item) => total + item.subTotal);
  String get totalItems => items.length.toString().padLeft(2, '0');

  @override
  List<Object> get props => [items];

  ShoppingCartState copyWith({
    List<OrderItemModel>? items,
  }) {
    return ShoppingCartState(
      items ?? this.items,
    );
  }
}
