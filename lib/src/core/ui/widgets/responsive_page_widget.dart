part of 'widgets.dart';

class ResponsivePageWidget<W extends StatefulWidget, M extends StatefulWidget> extends StatelessWidget {
  const ResponsivePageWidget({super.key, required this.web, required this.mobile});

  final W web;
  final M mobile;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: switch (context.width < 600) {
        true => mobile,
        false => web,
      },
    );
  }
}
