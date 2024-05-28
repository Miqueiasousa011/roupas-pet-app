import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';

import '../../controllers/navigation/navigation_cubit.dart';
import '../../controllers/navigation/navigation_state.dart';

class BottomNavigationComponent extends StatelessWidget {
  const BottomNavigationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationCubit = BlocProvider.of<NavigationCubit>(context);

    return BlocBuilder<NavigationCubit, NavidationState>(
      bloc: navigationCubit,
      builder: (context, state) => BottomNavigationBar(
        backgroundColor: context.colors.nutral10,
        currentIndex: navigationCubit.state.curruntPageIndex,
        selectedItemColor: context.colors.main,
        unselectedItemColor: context.colors.nutral70,
        selectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
        onTap: (index) {
          Modular.to.navigate(navigationCubit.getNavigationMenus()[index].path);
          navigationCubit.setCurrentIndex(index);
        },
        items: <BottomNavigationBarItem>[
          for (final menu in navigationCubit.getNavigationMenus())
            BottomNavigationBarItem(
              activeIcon: Icon(
                menu.icon,
                color: context.colors.main,
              ),
              icon: Icon(
                menu.icon,
                color: context.colors.nutral70,
              ),
              label: menu.title,
            ),
        ],
      ),
    );
  }
}
