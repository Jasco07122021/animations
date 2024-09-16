import 'package:flutter/material.dart';
import 'package:pages/widget/page_wrapper.dart';
import 'package:pages/main.dart';
import 'dart:math';

class CardsGradientPage extends StatelessWidget {
  const CardsGradientPage({super.key});

  static const title = 'CardsGradientPage';

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: CardsGradientPage.title,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return AnimatedCardBox();
        },
        itemCount: 1,
      ),
    );
  }
}

class AnimatedCardBox extends StatefulWidget {
  const AnimatedCardBox({super.key});

  @override
  State<AnimatedCardBox> createState() => _AnimatedCardBoxState();
}

class _AnimatedCardBoxState extends State<AnimatedCardBox>
    with SingleTickerProviderStateMixin {
  static const _collapsedHeight = 56.0;
  static const _expandedHeight = 120.0;
  static const _color = Colors.white;

  late final _controller = AnimationController(vsync: this);

  void _toggleCard() {
    switch (_controller.status) {
      case AnimationStatus.dismissed:
        _controller.forward();
        break;
      case AnimationStatus.forward:
        _controller.reverse();
        break;
      case AnimationStatus.reverse:
        _controller.forward();
        break;
      case AnimationStatus.completed:
        _controller.reverse();
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = DurationData
        .of(context)
        ?.duration;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            height: Tween(
              begin: _collapsedHeight,
              end: _expandedHeight,
            ).evaluate(_controller),
            decoration: DecorationTween(
              begin: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: _color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ],
              ),
              end: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: _color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ],
              ),
            ).evaluate(_controller),
            margin: EdgeInsets.all(16),
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Card Title'),
                    Transform.rotate(
                      angle: Tween(begin: 0.0, end: pi).evaluate(_controller),
                      child: Icon(
                        Icons.arrow_downward,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Opacity(
                    opacity: Tween(begin: 0.0, end: 1.0).evaluate(_controller),
                    child: Text(
                      "If you need to create mockups and design prototypes, you",
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
