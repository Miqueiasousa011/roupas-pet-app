part of 'widgets.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget(
    this.label, {
    super.key,
    required this.child,
    this.spacing = 4.0,
    this.style,
    this.constraints = const BoxConstraints(maxWidth: 400),
  });

  final String label;
  final double spacing;
  final Widget child;
  final TextStyle? style;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.textTheme.bodyMedium;
    final fontSize = context.isMobile ? 14.0 : null;
    return ConstrainedBox(
      constraints: constraints,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label.isNotEmpty)
            Text.rich(
              TextSpan(
                children: [
                  if (!label.endsWith('*'))
                    TextSpan(
                      text: label,
                      style: style?.copyWith(
                        fontSize: fontSize,
                        color: context.colors.nutral100,
                      ),
                    ),
                  if (label.endsWith('*'))
                    TextSpan(
                      text: label.replaceFirst('*', ''),
                      style: style?.copyWith(
                        fontSize: fontSize,
                        color: context.colors.nutral100,
                      ),
                    ),
                  if (label.endsWith('*'))
                    TextSpan(
                      text: '*',
                      style: style?.copyWith(
                        fontSize: fontSize,
                        color: context.colors.error,
                      ),
                    ),
                ],
              ),
            ),
          SizedBox(height: spacing),
          child
        ],
      ),
    );
  }
}
