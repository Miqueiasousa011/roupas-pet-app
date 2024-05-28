import 'package:result_dart/result_dart.dart';

import '../../../core/app_exception.dart';
import '../models/product_model.dart';

abstract class ProductRepository {
  AsyncResult<List<ProductModel>, AppException> getProducts();
}
