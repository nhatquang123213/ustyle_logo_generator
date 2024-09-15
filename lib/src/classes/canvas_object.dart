import 'dart:ui';

class CanvasObject<T> {
  final double? dx;
  final double? dy;
  final String type;
  final T? child;

  CanvasObject({
    this.dx = 0,
    this.dy = 0,
    this.child,
    required this.type,
  });

  CanvasObject<T> copyWith({
    double? dx,
    double? dy,
    String? type,
    T? child,
  }) {
    return CanvasObject<T>(
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
      type: type ?? this.type,
      child: child ?? this.child,
    );
  }

  Offset get offset => Offset(dx ?? 0, dy ?? 0);
  Rect get rect => offset & Size(0, 0);
}
