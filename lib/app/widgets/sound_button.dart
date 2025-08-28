import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsguess/app/providers/audio_provider.dart';

class SoundButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool autofocus;
  final Clip clipBehavior;
  final FocusNode? focusNode;

  const SoundButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Play tap sound first
        context.read<AudioProvider>().playTapSound();
        // Then execute the original onPressed callback
        onPressed?.call();
      },
      style: style,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      child: child,
    );
  }
}

class SoundIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? icon;
  final ButtonStyle? style;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? tooltip;

  const SoundIconButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Play tap sound first
        context.read<AudioProvider>().playTapSound();
        // Then execute the original onPressed callback
        onPressed?.call();
      },
      icon: icon ?? const SizedBox.shrink(),
      style: style,
      autofocus: autofocus,
      focusNode: focusNode,
      tooltip: tooltip,
    );
  }
}

class SoundTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool autofocus;
  final Clip clipBehavior;
  final FocusNode? focusNode;

  const SoundTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Play tap sound first
        context.read<AudioProvider>().playTapSound();
        // Then execute the original onPressed callback
        onPressed?.call();
      },
      style: style,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      child: child,
    );
  }
}
