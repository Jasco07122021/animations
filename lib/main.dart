import 'package:flutter/material.dart';
import 'package:pages/main_page.dart';
import 'package:pages/pages/cards_gradient.dart';
import 'package:pages/pages/simple_transitions.dart';
import 'package:pages/pages/waves.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: _AnimationApp(),
    );
  }
}

class _AnimationApp extends StatefulWidget {
  const _AnimationApp();

  @override
  State<_AnimationApp> createState() => _AnimationAppState();
}

class _AnimationAppState extends State<_AnimationApp> {
  double _durationValue = 2000;
  late Duration _duration = Duration(milliseconds: _durationValue.round());

  Route generatePage(Widget child) {
    return MaterialPageRoute(builder: (context) => child);
  }

  void _changeDuration(double value) {
    setState(() {
      _durationValue = value;
      _duration = Duration(milliseconds: _durationValue.round());
    });
  }

  @override
  Widget build(BuildContext context) {
    return DurationData(
      duration: _duration,
      durationValue: _durationValue,
      child: Navigator(
        key: navigatorKey,
        initialRoute: MainPage.title,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case MainPage.title:
              return generatePage(MainPage(onSliderChanged: _changeDuration));
            case SimpleTransitionsPage.title:
              return generatePage(const SimpleTransitionsPage());
            case WavesPage.title:
              return generatePage(const WavesPage());
            case CardsGradientPage.title:
              return generatePage(const CardsGradientPage());
          }
          return null;
        },
      ),
    );
  }
}

class DurationData extends InheritedWidget {
  const DurationData({
    required this.duration,
    required this.durationValue,
    required super.child,
    super.key,
  });

  final Duration duration;
  final double durationValue;

  @override
  bool updateShouldNotify(DurationData oldWidget) {
    return duration != oldWidget.duration ||
        durationValue != oldWidget.durationValue;
  }

  static DurationData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DurationData>();
  }
}
