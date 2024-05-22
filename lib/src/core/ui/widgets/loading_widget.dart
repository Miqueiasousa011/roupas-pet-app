import 'package:flutter/material.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(context.colors.main),
      ),
    );
  }
}
