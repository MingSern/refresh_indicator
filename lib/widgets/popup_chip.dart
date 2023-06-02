import 'package:flutter/material.dart';

class PopupChip extends StatefulWidget {
  final String message;

  const PopupChip(this.message, {super.key});

  @override
  State<PopupChip> createState() => _FinishedLoadingState();
}

class _FinishedLoadingState extends State<PopupChip>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: AnimatedBuilder(
        animation: _controller,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(100),
          ),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(widget.message),
        ),
        builder: (context, child) {
          final value = _controller.value * 20;
          return Transform.translate(
            offset: Offset(0, 20 - value),
            child: child ?? const SizedBox(),
          );
        },
      ),
    );
  }
}
