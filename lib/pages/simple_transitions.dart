import 'package:flutter/material.dart';
import 'package:pages/main.dart';
import 'package:pages/widget/page_wrapper.dart';

class SimpleTransitionsPage extends StatefulWidget {
  const SimpleTransitionsPage({super.key});

  static const title = 'SimpleTransitionsPage';

  @override
  State<SimpleTransitionsPage> createState() => _SimpleTransitionsPageState();
}

class _SimpleTransitionsPageState extends State<SimpleTransitionsPage>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(vsync: this);
  late final Animation<AlignmentGeometry> _alignmentGeometryAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Decoration> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );

    _alignmentGeometryAnimation = curvedAnimation.drive(
      AlignmentTween(
        begin: Alignment.center,
        end: Alignment.bottomCenter,
      ),
    );

    _scaleAnimation = curvedAnimation.drive(
      Tween(begin: 1, end: 1.5),
    );

    _borderRadiusAnimation = curvedAnimation.drive(
      DecorationTween(
        begin: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(70)),
        ),
        end: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController
      ..duration = DurationData.of(context)?.duration
      ..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: SimpleTransitionsPage.title,
      floatingAction: () {
        _animationController
          ..reset()
          ..forward();
      },
      body: AlignTransition(
        alignment: _alignmentGeometryAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: DecoratedBoxTransition(
            decoration: _borderRadiusAnimation,
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return PageWrapper(
  //     title: SimpleTransitionsPage.title,
  //     floatingAction: () {
  //       _animationController
  //         ..reset()
  //         ..forward();
  //     },
  //     body: _CustomTransition(
  //       alignmentGeometryAnimation: _alignmentGeometryAnimation,
  //       borderRadiusAnimation: _borderRadiusAnimation,
  //       scaleTransition: _scaleAnimation,
  //     ),
  //   );
  // }
}

class _CustomTransition extends AnimatedWidget {
  _CustomTransition({
    required this.alignmentGeometryAnimation,
    required this.scaleTransition,
    required this.borderRadiusAnimation,
    super.key,
  }) : super(
          listenable: Listenable.merge([
            alignmentGeometryAnimation,
            scaleTransition,
            borderRadiusAnimation,
          ]),
        );

  final Animation<AlignmentGeometry> alignmentGeometryAnimation;
  final Animation<double> scaleTransition;
  final Animation<Decoration> borderRadiusAnimation;

  @override
  Widget build(BuildContext context) {
    return AlignTransition(
      alignment: alignmentGeometryAnimation,
      child: ScaleTransition(
        scale: scaleTransition,
        child: DecoratedBoxTransition(
          decoration: borderRadiusAnimation,
          child: const SizedBox.square(dimension: 100),
        ),
      ),
    );
  }
}
