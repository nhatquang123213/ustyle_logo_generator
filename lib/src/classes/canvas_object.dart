import 'dart:ui';

class CanvasObject<T> {
  final double? dx;
  final double? dy;
  final T? child;

  CanvasObject({
    this.dx = 0,
    this.dy = 0,
    this.child,
  });

  CanvasObject<T> copyWith({
    double? dx,
    double? dy,
    T? child,
  }) {
    return CanvasObject<T>(
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
      child: child ?? this.child,
    );
  }

  Offset get offset => Offset(dx ?? 0, dy ?? 0);
  Rect get rect => offset & Size(0, 0);
}
