import 'package:equatable/equatable.dart';

class NavidationState extends Equatable {
  const NavidationState({
    this.curruntPageIndex = 0,
  });

  final int curruntPageIndex;

  @override
  List<Object?> get props => [curruntPageIndex];

  NavidationState copyWith({
    int? curruntPageIndex,
  }) {
    return NavidationState(
      curruntPageIndex: curruntPageIndex ?? this.curruntPageIndex,
    );
  }
}
