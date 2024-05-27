import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              child: GridView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.66, // Relação de aspecto (largura / altura)
                  mainAxisSpacing: 10.0, // Espaçamento entre os elementos na direção principal
                  crossAxisSpacing: 10.0, // Espaçamento entre os elementos na direção cruzada
                ),
                itemBuilder: (context, index) => const Product(),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ).applySpacing(spacing: 16),
        floatingActionButton: const ShoppingCartFabButton(),
      ),
    );
  }
}

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.nutral10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Material(
              color: context.colors.nutral20,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {
                  Modular.to.pushNamed('/main/home/product');
                },
                child: Container(),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Nome do produto',
            style: context.textTheme.bodyLarge!.copyWith(color: context.colors.main),
          ),
          Text(
            'R\$ 100,00',
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
