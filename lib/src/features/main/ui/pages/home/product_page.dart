import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/extensions/string_ext.dart';
import 'package:roupaspet/src/features/main/controllers/shopping_cart/shopping_cart_cubit.dart';
import 'package:roupaspet/src/features/main/models/order_item_model.dart';
import 'package:roupaspet/src/features/main/models/product_model.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final shoppingCartCubit = Modular.get<ShoppingCartCubit>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            product.name,
            style: context.textTheme.titleMedium!.copyWith(
              color: context.colors.primary100,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: context.colors.primary100,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                product.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 400,
              ),
              Text(
                product.name,
                style: context.textTheme.titleLarge!.copyWith(
                  color: context.colors.primary100,
                ),
              ).margin(const EdgeInsets.symmetric(horizontal: 16)),
              Text(
                product.description,
                style: context.textTheme.titleMedium!.copyWith(
                  color: context.colors.primary80,
                ),
              ).margin(const EdgeInsets.symmetric(horizontal: 16)),
              Text(
                '${product.price.toBRL} ',
                style: context.textTheme.titleMedium!.copyWith(
                  color: context.colors.primary80,
                ),
              ).margin(const EdgeInsets.symmetric(horizontal: 16)),
              ElevatedButton(
                onPressed: () {
                  shoppingCartCubit.addProduct(OrderItemModel(product: product, quantity: 1));
                  Navigator.pop(context);
                  context.showSuccessSnackbar('Produto adicionado ao carrinho');
                },
                child: const Text('Adicionar ao carrinho'),
              ).margin(const EdgeInsets.symmetric(horizontal: 16, vertical: 50))
            ],
          ).applySpacing(spacing: 8),
        ),
      ),
    );
  }
}
