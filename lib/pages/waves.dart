import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pages/main.dart';
import 'package:pages/widget/page_wrapper.dart';

class WavesPage extends StatefulWidget {
  const WavesPage({super.key});

  static const title = 'WavesPage';

  @override
  State<WavesPage> createState() => _WavesPageState();
}

class _WavesPageState extends State<WavesPage>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller
      ..duration = DurationData.of(context)?.duration
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: WavesPage.title,
      useSafeArea: false,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: const Size.fromHeight(400),
              painter: _WavePainter(
                waveColor: Colors.blue,
                animationValue: _controller.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  _WavePainter({
    required this.waveColor,
    required this.animationValue,
  });

  static const _pi2 = 2 * pi;

  final Color waveColor;
  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();

    for (var i = 0.0; i < width; i++) {
      path.lineTo(i, 0.0 - sin(_pi2 * (i / width + animationValue)) * 6);
    }

    path
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();
    final wavePoint = Paint()..color = waveColor;
    canvas.drawPath(path, wavePoint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
