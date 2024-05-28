import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../controllers/navigation/navigation_cubit.dart';
import '../components/bottom_navigation_component.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late NavigationCubit navigationCubit;

  @override
  void initState() {
    super.initState();
    navigationCubit = Modular.get<NavigationCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    Modular.dispose<NavigationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => navigationCubit,
      child: const Scaffold(
        body: RouterOutlet(),
        bottomNavigationBar: BottomNavigationComponent(),
      ),
    );
  }
}
