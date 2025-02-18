import 'package:flutter/material.dart';

class DesignProgressAnimation extends StatefulWidget {
  const DesignProgressAnimation({
    Key? key,
    this.color,
    this.size,
    this.value,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  final Color? color;
  final double? size;
  final double? value;
  final Duration duration;

  @override
  State<DesignProgressAnimation> createState() =>
      _DesignProgressAnimationState();
}

class _DesignProgressAnimationState extends State<DesignProgressAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.value ?? 0.0,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void didUpdateWidget(DesignProgressAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      _animationController.animateTo(widget.value ?? 0.0,
          duration: const Duration(milliseconds: 200));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          height: widget.size ?? 20,
          width: widget.size ?? 20,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: widget.color,
            value: _animation.value,
          ),
        );
      },
    );
  }
}

class DesignProgress extends StatelessWidget {
  const DesignProgress({
    Key? key,
    this.color,
    this.size,
    this.value,
  }) : super(key: key);

  final Color? color;
  final double? size;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 20,
      width: size ?? 20,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        color: color,
        value: value,
      ),
    );
  }
}
