import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/extensions/string_ext.dart';
import 'package:roupaspet/src/features/main/controllers/shopping_cart/shopping_cart_cubit.dart';
import 'package:roupaspet/src/features/main/models/order_item_model.dart';
import 'package:roupaspet/src/features/main/models/product_model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int total = 1;
  @override
  Widget build(BuildContext context) {
    final shoppingCartCubit = Modular.get<ShoppingCartCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.product.name,
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
              widget.product.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 400,
            ),
            Text(
              widget.product.name,
              style: context.textTheme.titleLarge!.copyWith(
                color: context.colors.primary100,
              ),
            ).margin(const EdgeInsets.symmetric(horizontal: 16)),
            Text(
              widget.product.description,
              style: context.textTheme.titleMedium!.copyWith(
                color: context.colors.primary80,
              ),
            ).margin(const EdgeInsets.symmetric(horizontal: 16)),
            Text(
              '${widget.product.price.toBRL} ',
              style: context.textTheme.titleMedium!.copyWith(
                color: context.colors.primary80,
                fontWeight: FontWeight.bold,
              ),
            ).margin(const EdgeInsets.symmetric(horizontal: 16)),
            Row(
              children: [
                Text(
                  'Quantidade: ',
                  style: context.textTheme.titleMedium!.copyWith(
                    color: context.colors.primary80,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButton<int>(
                  value: total,
                  items: List.generate(
                    5,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: context.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.colors.primary80,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onChanged: (e) {
                    setState(() {
                      if (e != null) total = e;
                    });
                  },
                ),
              ],
            ).margin(const EdgeInsets.symmetric(horizontal: 16)),
            ElevatedButton(
              onPressed: () {
                if (shoppingCartCubit.state.items.map((e) => e.product).contains(widget.product)) {
                  context.showErrorSnackbar('Produto já adicionado ao carrinho');
                  return;
                }

                shoppingCartCubit.addProduct(
                  OrderItemModel(
                    product: widget.product,
                    quantity: total,
                  ),
                );
                Navigator.pop(context);
                context.showSuccessSnackbar('Produto adicionado ao carrinho');
              },
              child: const Text('Adicionar ao carrinho'),
            ).margin(const EdgeInsets.symmetric(horizontal: 16, vertical: 50))
          ],
        ).applySpacing(spacing: 8),
      ),
    );
  }
}
