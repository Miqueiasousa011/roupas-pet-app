part of 'extensions.dart';

extension WidgetExtension on Widget {
  Padding margin(EdgeInsetsGeometry padding) => Padding(padding: padding, child: this);
  SizedBox sizedBox({double? width, double? height}) => SizedBox(width: width, height: height, child: this);
}
