part of 'extensions.dart';

extension ColumnExtension on Column {
  Column applySpacing({
    double spacing = 0.0,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return Column(
      key: key,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      textDirection: textDirection,
      children: [
        if (padding.top > 0.0) SizedBox(height: padding.top),
        ...List.from(
          children.indexedMap(
            (index, item) {
              if (item is Spacer) return item;

              final child = switch (item.runtimeType) {
                const (Expanded) => (item as Expanded).child,
                const (Flexible) => (item as Flexible).child,
                _ => item,
              };

              final flex = switch (item.runtimeType) {
                const (Expanded) => (item as Expanded).flex,
                const (Flexible) => (item as Flexible).flex,
                _ => null,
              };

              final fit = switch (item.runtimeType) {
                const (Expanded) => (item as Expanded).fit,
                const (Flexible) => (item as Flexible).fit,
                _ => null,
              };

              if (item is Expanded) {
                return Expanded(
                  key: item.key,
                  flex: flex ?? 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? 0.0 : spacing / 2,
                      bottom: index == children.length - 1 ? 0.0 : spacing / 2,
                      left: padding.left,
                      right: padding.right,
                    ),
                    child: child,
                  ),
                );
              } else if (item is Flexible) {
                return Flexible(
                  key: item.key,
                  flex: flex ?? 1,
                  fit: fit ?? FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? 0.0 : spacing / 2,
                      bottom: index == children.length - 1 ? 0.0 : spacing / 2,
                      left: padding.left,
                      right: padding.right,
                    ),
                    child: child,
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(
                    top: index == 0 ? 0.0 : spacing / 2,
                    bottom: index == children.length - 1 ? 0.0 : spacing / 2,
                    left: padding.left,
                    right: padding.right,
                  ),
                  child: child,
                );
              }
            },
          ),
        ),
        if (padding.bottom > 0.0) SizedBox(height: padding.bottom),
      ],
    );
  }
}
