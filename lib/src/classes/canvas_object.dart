import 'dart:ui';

class CanvasObject<T> {
  final double? dx;
  final double? dy;
  final double? width;
  final double? height;
  final T? child;

  CanvasObject({
    this.dx = 0,
    this.dy = 0,
    this.width = 100,
    this.height = 100,
    this.child,
  });

  CanvasObject<T> copyWith({
    double? dx,
    double? dy,
    double? width,
    double? height,
    T? child,
  }) {
    return CanvasObject<T>(
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
      width: width ?? this.width,
      height: height ?? this.height,
      child: child ?? this.child,
    );
  }

  Size get size => Size(width ?? 0, height ?? 0);
  Offset get offset => Offset(dx ?? 0, dy ?? 0);
  Rect get rect => offset & size;
}
