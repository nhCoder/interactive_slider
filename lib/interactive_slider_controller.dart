import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InteractiveSliderController extends ValueNotifier<double> {
  InteractiveSliderController(super._value);

  @override
  set value(double value) => super.value = value.clamp(0.0, 1.0);
}

class SecondaryProgressController extends ValueNotifier<double> {
  final Color? color;
  Timer? _timer;

  SecondaryProgressController(
    super._value, {
    this.color = Colors.red,
  });

  @override
  set value(double newValue) {
    _timer?.cancel();
    const frameRate = 90; // 60 frames per second
    final duration = Duration(milliseconds: 300);
    final totalFrames = (duration.inMilliseconds / (1000 / frameRate)).round();
    final step = (newValue.clamp(0.0, 1.0) - super.value) / totalFrames;
    var currentFrame = 0;

    _timer = Timer.periodic(Duration(milliseconds: (1000 / frameRate).round()),
        (timer) {
      if (currentFrame >= totalFrames) {
        super.value = newValue.clamp(0.0, 1.0);
        timer.cancel();
        return;
      }
      super.value += step;
      currentFrame++;
    });
  }
  //
  // void animateTo(double newValue,
  //     {Duration duration = const Duration(seconds: 1)}) {
  //   _timer?.cancel();
  //   const frameRate = 60; // 60 frames per second
  //   final totalFrames = (duration.inMilliseconds / (1000 / frameRate)).round();
  //   final step = (newValue - value) / totalFrames;
  //   var currentFrame = 0;
  //
  //   _timer = Timer.periodic(Duration(milliseconds: (1000 / frameRate).round()),
  //       (timer) {
  //     if (currentFrame >= totalFrames) {
  //       value = newValue;
  //       timer.cancel();
  //       return;
  //     }
  //     value += step;
  //     currentFrame++;
  //   });
  // }
}
