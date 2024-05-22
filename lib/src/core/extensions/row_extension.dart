part of 'extensions.dart';

extension RowExtension on Row {
  Row applySpacing({
    double spacing = 0.0,
    EdgeInsets? padding,
  }) {
    return Row(
      key: key,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      textDirection: textDirection,
      children: [
        if ((padding?.left ?? 0) > 0) SizedBox(width: padding?.left),
        ...List.from(
          children.indexedMap(
            (index, item) {
              if (item is Spacer) return item;

              // final child = switch (item) {
              //   Expanded e => e.child,
              //   Flexible f => f.child,
              //   _ => item,
              // };

              // final flex = switch (item) {
              //   Expanded e => e.flex,
              //   Flexible f => f.flex,
              //   _ => null,
              // };

              // final fit = switch (item) {
              //   Expanded e => e.fit,
              //   Flexible f => f.fit,
              //   _ => null,
              // };

              if (item is Expanded) {
                return Expanded(
                  key: item.key,
                  flex: item.flex,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0.0 : spacing / 2,
                      right: index == children.length - 1 ? 0.0 : spacing / 2,
                      top: padding?.top ?? 0.0,
                      bottom: padding?.bottom ?? 0.0,
                    ),
                    child: item.child,
                  ),
                );
              } else if (item is Flexible) {
                return Flexible(
                  key: item.key,
                  flex: item.flex,
                  fit: item.fit,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0.0 : spacing / 2,
                      right: index == children.length - 1 ? 0.0 : spacing / 2,
                      top: padding?.top ?? 0.0,
                      bottom: padding?.bottom ?? 0.0,
                    ),
                    child: item.child,
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0.0 : spacing / 2,
                    right: index == children.length - 1 ? 0.0 : spacing / 2,
                    top: padding?.top ?? 0.0,
                    bottom: padding?.bottom ?? 0.0,
                  ),
                  child: item,
                );
              }
            },
          ),
        ),
        if ((padding?.right ?? 0) > 0) SizedBox(width: padding?.right),
      ],
    );
  }
}
