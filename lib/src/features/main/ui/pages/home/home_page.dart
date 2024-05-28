import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/extensions/string_ext.dart';
import 'package:roupaspet/src/core/ui/widgets/widgets.dart';
import 'package:roupaspet/src/features/main/controllers/products/product_state.dart';
import 'package:roupaspet/src/features/main/controllers/products/products_cubit.dart';
import 'package:roupaspet/src/features/main/models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = Modular.get<ProductCubit>();

    scheduleMicrotask(() => _productCubit.getProducts());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputWidget.text(
              hintText: 'Buscar produtos',
              suffixIcon: Icon(
                Icons.search_outlined,
                color: context.colors.main,
              ),
            ).margin(const EdgeInsets.symmetric(horizontal: 24)),
            Text(
              'Produtos',
              style: context.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.primary80,
              ),
            ).margin(const EdgeInsets.symmetric(horizontal: 24)),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                bloc: _productCubit,
                builder: (context, state) {
                  if (state is SuccessState) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: state.products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 180 / 200,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) => Product(
                        product: state.products[index],
                      ),
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      color: context.colors.main,
                    ),
                  );
                },
              ),
            ),
          ],
        ).applySpacing(spacing: 16),
        floatingActionButton: const ShoppingCartFabButton(),
      ),
    );
  }
}

class Product extends StatelessWidget {
  const Product({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 200,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Material(
              color: context.colors.nutral20,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {
                  Modular.to.pushNamed('/main/home/product');
                },
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            product.name,
            style: context.textTheme.bodyLarge!.copyWith(color: context.colors.main),
            maxLines: 1,
          ),
          Text(
            product.price.toBRL,
            style: context.textTheme.bodyLarge!.copyWith(color: context.colors.main),
          ),
        ],
      ),
    );
  }
}

class ShoppingCartFabButton extends StatelessWidget {
  const ShoppingCartFabButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FloatingActionButton(
          backgroundColor: context.colors.main,
          onPressed: () {},
          child: const Icon(Icons.shopping_cart_outlined),
        ),
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colors.primary80,
            shape: BoxShape.circle,
          ),
          child: Text(
            '10',
            style: TextStyle(
                color: context.colors.nutral10, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
