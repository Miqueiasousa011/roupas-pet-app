import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:roupaspet/src/app_paths.dart';

import '../../models/navigation_model.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavidationState> {
  NavigationCubit() : super(const NavidationState());

  void setCurrentIndex(int index) {
    emit(state.copyWith(curruntPageIndex: index));
  }

  List<NavigationModel> getNavigationMenus() {
    return [
      NavigationModel(
        title: 'Home',
        icon: Icons.home_outlined,
        path: paths.home,
      ),
      NavigationModel(
        title: 'Pedidos',
        icon: Icons.shopping_bag_outlined,
        path: paths.orders,
      ),
      NavigationModel(
        title: 'Perfil',
        icon: Icons.person_outline,
        path: paths.profile,
      ),
    ];
  }
}
