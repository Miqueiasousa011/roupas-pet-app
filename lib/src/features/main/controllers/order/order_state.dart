part of 'order_cubit.dart';

abstract class OrderState extends Equatable {}

class OrderInitial extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderLoading extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderSuccess extends OrderState {
  @override
  List<Object?> get props => [];
}
