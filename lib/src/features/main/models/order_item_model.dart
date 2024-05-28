import 'package:equatable/equatable.dart';

import 'product_model.dart';

class OrderItemModel extends Equatable {
  final ProductModel product;
  final int quantity;

  const OrderItemModel({
    required this.product,
    required this.quantity,
  });

  double get subTotal => product.price * quantity;

  OrderItemModel copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return OrderItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [product, quantity];
}
