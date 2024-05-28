import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';

abstract class ProductState extends Equatable {}

class InitialState extends ProductState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends ProductState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class SuccessState extends ProductState {
  final List<ProductModel> products;

  SuccessState(this.products);
  @override
  List<Object?> get props => [];
}
