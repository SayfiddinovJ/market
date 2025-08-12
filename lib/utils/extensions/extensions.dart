import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Space on num {
  SizedBox get ph => SizedBox(height: toDouble().h);

  SizedBox get pw => SizedBox(width: toDouble().w);
}

class ContainerColors extends ThemeExtension<ContainerColors> {
  final Color background;

  const ContainerColors({required this.background});

  @override
  ContainerColors copyWith({Color? background}) {
    return ContainerColors(background: background ?? this.background);
  }

  @override
  ContainerColors lerp(ThemeExtension<ContainerColors>? other, double t) {
    if (other is! ContainerColors) return this;
    return ContainerColors(
      background: Color.lerp(background, other.background, t)!,
    );
  }
}
