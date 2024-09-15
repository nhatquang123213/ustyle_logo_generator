import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BackgroundColor extends Equatable {
  final Color? startColor, endColor;

  BackgroundColor({required this.startColor, this.endColor});

  bool get isSolidColor => startColor != null && endColor == null;
  bool get isGradientColor => startColor != null && endColor != null;

  @override
  List<Object?> get props => [startColor.toString(), endColor.toString()];
}
