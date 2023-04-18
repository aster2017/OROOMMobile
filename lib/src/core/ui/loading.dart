import 'package:flutter/material.dart';
import 'package:orb/src/core/constants/colors.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: primaryColor.withOpacity(.1),
      child: Center(
        child: RotationTransition(
            turns: _animation,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: secondaryColor,
            )),
      ),
    );
  }
}
