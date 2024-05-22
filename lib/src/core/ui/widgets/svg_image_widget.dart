import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:roupaspet/src/core/extensions/extensions.dart';

class SVGImageWidget extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final String svgString;

  const SVGImageWidget({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.color,
  }) : svgString = '';

  const SVGImageWidget.string(
    this.svgString, {
    super.key,
    this.width,
    this.height,
    this.color,
  }) : path = '';

  @override
  Widget build(BuildContext context) {
    return svgString.isNotEmpty
        ? SvgPicture.string(
            svgString,
            width: width,
            height: height,
            colorFilter: switch (color != null) {
              true => ColorFilter.mode(color!, BlendMode.srcIn),
              false => ColorFilter.mode(context.colors.main, BlendMode.srcIn),
            },
          )
        : SvgPicture.asset(
            path,
            width: width,
            height: height,
            colorFilter: switch (color != null) {
              true => ColorFilter.mode(color!, BlendMode.srcIn),
              false => ColorFilter.mode(context.colors.main, BlendMode.srcIn),
            },
          );
  }
}
