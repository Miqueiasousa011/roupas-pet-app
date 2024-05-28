import 'package:result_dart/result_dart.dart';

import '../../../core/app_exception.dart';
import '../../../core/services/http/http_service.dart';
import '../models/product_model.dart';
import 'product_repository.dart';

class ProductRepositoryImp implements ProductRepository {
  final HttpService _httpService;

  ProductRepositoryImp(this._httpService);

  @override
  AsyncResult<List<ProductModel>, AppException> getProducts() async {
    try {
      final response = await _httpService.get('/products');

      return response.fold(
        (data) {
          final products = data.map((e) => ProductModel.fromJson(e)).toList();
          return Success(products.cast<ProductModel>());
        },
        (failure) => Failure(failure),
      );
    } catch (e) {
      return const Failure(UnknownException('LOGIN ERROR'));
    }
  }
}
