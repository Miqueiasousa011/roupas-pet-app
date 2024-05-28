import 'package:bloc/bloc.dart';
import 'package:result_dart/result_dart.dart';

import '../../repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit(this.productRepository) : super(InitialState());

  Future<void> getProducts() async {
    emit(LoadingState());
    try {
      await productRepository.getProducts().fold(
            (data) => emit(SuccessState(data)),
            (failure) => emit(ErrorState(failure.message)),
          );
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
