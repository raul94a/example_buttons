import 'package:example_buttons/mixin/widget_state_property.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({
    super.key,
    required this.text,
    this.textStyle,
    this.buttonStyle,
    this.width = 200.0,
    this.height = 45.0,
    this.active = true,
    this.gradient,
    required this.onPressed,
  });

  final bool active;
  final String text;
  final double width, height;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final Function onPressed;
  final LinearGradient? gradient;

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
    with WidgetStatePropertyMixin {
  bool loading = false;
  void changeLoadingStatus() => setState(() => loading = !loading);
  Future<void> onPressed() async {
    if (loading) return;
    try {
      changeLoadingStatus();
      await widget.onPressed();
    } catch (_) {
      rethrow;
    } finally {
      changeLoadingStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasGradient = widget.gradient != null;
    final currentBackgroudColor = widget.buttonStyle?.backgroundColor;
    final button = ElevatedButton(
        style: widget.buttonStyle?.copyWith(
            backgroundColor: hasGradient
                ? getProperty(Colors.transparent)
                : currentBackgroudColor),
        onPressed: !widget.active ? null : onPressed,
        child: Text(
          widget.text,
          style: widget.textStyle,
        ));

    if (!hasGradient) return button;
    return Container(
      decoration: ShapeDecoration(
          shape: const StadiumBorder(), gradient: widget.gradient),
      child: TextButton(
          style: widget.buttonStyle,
          onPressed: onPressed,
          child: Text(
            widget.text,
            style: widget.textStyle,
          )),
    );
  }
}
