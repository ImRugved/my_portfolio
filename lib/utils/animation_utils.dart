import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationUtils {
  static Duration get defaultDuration => const Duration(milliseconds: 800);
  static Duration get defaultDelay => const Duration(milliseconds: 200);
  static Curve get defaultCurve => Curves.easeInOut;

  static List<Effect> get fadeSlideUp => [
        FadeEffect(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          delay: const Duration(milliseconds: 100),
        ),
        SlideEffect(
          begin: const Offset(0, 30),
          end: const Offset(0, 0),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          delay: const Duration(milliseconds: 100),
        ),
      ];

  static List<Effect> get fadeSlideRight => [
        FadeEffect(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          delay: const Duration(milliseconds: 200),
        ),
        SlideEffect(
          begin: const Offset(-30, 0),
          end: const Offset(0, 0),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          delay: const Duration(milliseconds: 200),
        ),
      ];

  static List<Effect> get fadeIn => [
        FadeEffect(
          duration: defaultDuration,
          curve: defaultCurve,
          delay: defaultDelay,
        ),
      ];

  static List<Effect> get scaleIn => [
        ScaleEffect(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: defaultDuration,
          curve: defaultCurve,
          delay: defaultDelay,
        ),
        FadeEffect(
          duration: defaultDuration,
          curve: defaultCurve,
          delay: defaultDelay,
        ),
      ];

  static List<Effect> get slideInLeft => [
        SlideEffect(
          begin: const Offset(-30, 0),
          end: const Offset(0, 0),
          duration: defaultDuration,
          curve: defaultCurve,
          delay: defaultDelay,
        ),
        FadeEffect(
          duration: defaultDuration,
          curve: defaultCurve,
          delay: defaultDelay,
        ),
      ];

  static List<Effect> get slideInRight => [
        SlideEffect(
          begin: const Offset(30, 0),
          end: const Offset(0, 0),
          duration: defaultDuration,
          curve: defaultCurve,
          delay: defaultDelay,
        ),
        FadeEffect(
          duration: defaultDuration,
          curve: defaultCurve,
          delay: defaultDelay,
        ),
      ];

  static List<Effect> get bounceIn => [
        ScaleEffect(
          begin: const Offset(0.3, 0.3),
          end: const Offset(1, 1),
          duration: defaultDuration,
          curve: Curves.bounceOut,
          delay: defaultDelay,
        ),
        FadeEffect(
          duration: const Duration(milliseconds: 400),
          curve: defaultCurve,
          delay: defaultDelay,
        ),
      ];

  static List<Effect> get rotateIn => [
        RotateEffect(
          begin: 0.2,
          end: 0,
          duration: defaultDuration,
          curve: defaultCurve,
          delay: defaultDelay,
        ),
        FadeEffect(
          duration: defaultDuration,
          curve: defaultCurve,
          delay: defaultDelay,
        ),
      ];

  static List<Effect> getStaggeredFadeSlideUp(int index) => [
        FadeEffect(
          duration: defaultDuration,
          curve: defaultCurve,
          delay:
              Duration(milliseconds: 100 * index + defaultDelay.inMilliseconds),
        ),
        SlideEffect(
          begin: const Offset(0, 30),
          end: const Offset(0, 0),
          duration: defaultDuration,
          curve: defaultCurve,
          delay:
              Duration(milliseconds: 100 * index + defaultDelay.inMilliseconds),
        ),
      ];

  static List<Effect> getStaggeredScaleIn(int index) => [
        ScaleEffect(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: defaultDuration,
          curve: defaultCurve,
          delay:
              Duration(milliseconds: 100 * index + defaultDelay.inMilliseconds),
        ),
        FadeEffect(
          duration: defaultDuration,
          curve: defaultCurve,
          delay:
              Duration(milliseconds: 100 * index + defaultDelay.inMilliseconds),
        ),
      ];
}
