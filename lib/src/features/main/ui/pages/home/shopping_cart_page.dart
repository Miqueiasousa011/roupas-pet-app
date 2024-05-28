import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/extensions/string_ext.dart';
import 'package:roupaspet/src/features/main/controllers/shopping_cart/shopping_cart_cubit.dart';
import 'package:roupaspet/src/features/main/models/order_item_model.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({
    super.key,
  });

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    final shoppingCartCubit = Modular.get<ShoppingCartCubit>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Carrinho',
            style: context.textTheme.titleMedium!.copyWith(
              color: context.colors.primary100,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: context.colors.primary100,
          ),
        ),
        body: Builder(builder: (context) {
          if (shoppingCartCubit.state.items.isEmpty) {
            return Center(
              child: Text(
                'Carrinho vazio',
                style: context.textTheme.titleLarge!.copyWith(color: context.colors.primary90),
              ),
            );
          }

          return ListView.separated(
            itemCount: shoppingCartCubit.state.items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = shoppingCartCubit.state.items[index];
              return ProductCardInLine(
                onRemove: () => setState(() => shoppingCartCubit.removeProduct(item)),
                item: item,
              );
            },
          );
        }),
        bottomNavigationBar: ElevatedButton(
          onPressed: () {},
          child: const Text('Finalizar Pedido'),
        ).margin(const EdgeInsets.symmetric(horizontal: 16)),
      ),
    );
  }
}

class ProductCardInLine extends StatelessWidget {
  const ProductCardInLine({super.key, required this.item, required this.onRemove});

  final OrderItemModel item;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.colors.nutral10,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: context.colors.nutral20,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: context.colors.nutral20,
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.product.image,
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.product.name,
                style: context.textTheme.bodyLarge!.copyWith(color: context.colors.primary80),
                maxLines: 1,
              ),
              Text(
                'Quantidade: ${item.quantity}',
                style: context.textTheme.bodyLarge!.copyWith(color: context.colors.primary80),
              ),
              Text(
                'Valor: ${item.product.price.toBRL}/UND',
                style: context.textTheme.bodyLarge!.copyWith(color: context.colors.primary80),
              ),
              Text(
                'Total: ${item.subTotal.toBRL}',
                style: context.textTheme.bodyLarge!.copyWith(color: context.colors.primary80),
              ),
            ],
          ).applySpacing(spacing: 5),
          const Spacer(),
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.delete),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
