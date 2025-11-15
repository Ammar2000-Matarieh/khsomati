part of 'layout_cubit.dart';

@immutable
// sealed class LayoutState {}
class LayoutState extends Equatable {
  final int? currentIndex;

  const LayoutState({this.currentIndex = 0});

  LayoutState copyWith({int? currentIndex}) {
    return LayoutState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [currentIndex];
}

final class LayoutInitial extends LayoutState {}

final class LayoutLoading extends LayoutState {}

final class LayoutSuccess extends LayoutState {
  const LayoutSuccess();
}

final class LayoutError extends LayoutState {
  final String message;
  const LayoutError(this.message);
}
