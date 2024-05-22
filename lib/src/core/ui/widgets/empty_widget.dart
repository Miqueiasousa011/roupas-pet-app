import 'package:flutter/material.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/empty_result.png',
            width: 388.0,
          ),
          const SizedBox(height: 16.0),
          Text(
            message,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: context.isMobile ? 16 : 24,
              color: context.colors.nutral100,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
