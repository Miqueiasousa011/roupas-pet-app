import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';
import 'package:roupaspet/src/core/extensions/string_ext.dart';

import '../../../../../core/mixins/utils_mixin.dart';
import '../../../controllers/order/order_cubit.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> with UtilsMixin {
  late OrderCubit orderCubit;

  @override
  void initState() {
    super.initState();
    orderCubit = Modular.get<OrderCubit>();

    scheduleMicrotask(() => orderCubit.getOrders());
  }

  @override
  void dispose() {
    super.dispose();
    Modular.dispose<OrderCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: orderCubit,
      listener: (context, state) {
        if (state is OrderLoading) {
          showLoading();
        } else {
          removeLoading();
        }

        if (state is OrderError) {
          showErrorSnackbar(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Meus Pedidos'),
          ),
          body: Builder(
            builder: (context) {
              if (state is OrderSuccess) {
                if (state.orders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 100,
                          color: context.colors.primary80,
                        ),
                        Text(
                          'Nenhum pedido encontrado',
                          style: context.textTheme.titleLarge!.copyWith(
                            color: context.colors.primary80,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final orders = state.orders;
                return ListView.separated(
                  itemCount: orders.length,
                  separatorBuilder: (context, index) => Divider(color: context.colors.nutral40),
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return ListTile(
                      title: Text('Pedido ${order.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Valor ${order.total.toBRL}'),
                          Text('Status ${order.getStatus}'),
                        ],
                      ).applySpacing(spacing: 4),
                      trailing: Icon(order.getPaymentIcon),
                      onTap: () {},
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}
