import 'package:flutter/material.dart';

/// Pulsing placeholder used while a panel loads.
class SkeletonBox extends StatefulWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const SkeletonBox({super.key, this.width, this.height = 16, this.borderRadius = 6});

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Color.lerp(scheme.surfaceContainerLow, scheme.surfaceContainerHighest, _controller.value),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
    );
  }
}

/// A few skeleton lines stacked, for list/table placeholders.
class SkeletonLines extends StatelessWidget {
  final int lines;
  const SkeletonLines({super.key, this.lines = 4});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(spacing: 14, children: [for (var i = 0; i < lines; i++) SkeletonBox(width: double.infinity, height: 14)]),
    );
  }
}
