import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' as fm;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/app_paths.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/extensions/string_ext.dart';
import 'package:roupaspet/src/features/main/controllers/products/product_state.dart';
import 'package:roupaspet/src/features/main/controllers/products/products_cubit.dart';
import 'package:roupaspet/src/features/main/models/product_model.dart';

import '../../../controllers/shopping_cart/shopping_cart_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProductCubit _productCubit;
  late ShoppingCartCubit _shoppingCartCubit;

  @override
  void initState() {
    super.initState();
    _productCubit = fm.Modular.get<ProductCubit>();
    _shoppingCartCubit = fm.Modular.get<ShoppingCartCubit>();

    scheduleMicrotask(() => _productCubit.getProducts());
  }

  @override
  void dispose() {
    super.dispose();
    fm.Modular.dispose<ShoppingCartCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShoppingCartCubit>(
      create: (context) => _shoppingCartCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 25,
              ),
              const SizedBox(width: 8), // 8
              Text(
                'RoupasPet',
                style: context.textTheme.titleMedium!.copyWith(color: context.colors.primary80),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  fm.Modular.to.pushNamed(paths.auth);
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: context.colors.main,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  fm.Modular.to.pushNamed('/main/home/product', arguments: product);
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
            style: context.textTheme.bodyLarge!.copyWith(color: context.colors.primary80),
            maxLines: 1,
          ),
          Text(
            product.price.toBRL,
            style: context.textTheme.bodyLarge!.copyWith(
              color: context.colors.primary80,
              fontWeight: FontWeight.bold,
            ),
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
    final shoppingCartCubit = BlocProvider.of<ShoppingCartCubit>(context);

    return Stack(
      children: [
        FloatingActionButton(
          backgroundColor: context.colors.main,
          onPressed: () => Modular.to.pushNamed('/main/home/shopping-cart'),
          child: const Icon(Icons.shopping_cart_outlined),
        ),
        BlocBuilder<ShoppingCartCubit, ShoppingCartState>(
          bloc: shoppingCartCubit,
          builder: (context, state) {
            return Visibility(
              visible: state.totalItems != '00',
              child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.colors.primary80,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  state.totalItems,
                  style: TextStyle(
                    color: context.colors.nutral10,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
