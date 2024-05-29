import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/extensions/string_ext.dart';

import '../../../controllers/shopping_cart/shopping_cart_cubit.dart';

const paymentMethod = [
  'CREDIT_CARD',
  'PIX',
];

class FinalizeOrderPage extends StatefulWidget {
  const FinalizeOrderPage({super.key});

  @override
  State<FinalizeOrderPage> createState() => _FinalizeOrderPageState();
}

class _FinalizeOrderPageState extends State<FinalizeOrderPage> {
  String selectedPaymentMethod = paymentMethod.first;

  @override
  Widget build(BuildContext context) {
    final shoppingCartCubit = Modular.get<ShoppingCartCubit>();

    final totalToPay = 100.0 + shoppingCartCubit.state.total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Finalizar Pedido',
          style: context.textTheme.titleLarge!.copyWith(
            color: context.colors.primary100,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ).margin(const EdgeInsets.symmetric(horizontal: 16)),
        const Divider(),
        const Text('Frete: R\$ 100'),
        Text('Valor total: ${totalToPay.toBRL}'),
        const Text('Forma de pagamento'),
        Row(
          children: [
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: selectedPaymentMethod == paymentMethod.first
                    ? context.colors.primary30
                    : context.colors.nutral10,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.colors.primary60),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.nutral20,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() => selectedPaymentMethod = paymentMethod.first);
                },
                child: const Icon(Icons.credit_card),
              ),
            ),
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: selectedPaymentMethod == paymentMethod.last
                    ? context.colors.primary30
                    : context.colors.nutral10,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.colors.primary60),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.nutral20,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = paymentMethod.last;
                  });
                },
                child: const Icon(Icons.pix),
              ),
            ),
          ],
        ).applySpacing(spacing: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
                child: const Text('Cancelar'),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(selectedPaymentMethod);
                },
                child: const Text('Finalizar'),
              ),
            ),
          ],
        ).applySpacing(spacing: 10),
      ],
    ).applySpacing(spacing: 16).margin(const EdgeInsets.all(16));
  }
}
