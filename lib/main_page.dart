import 'package:flutter/material.dart';
import 'package:pages/main.dart';
import 'package:pages/pages/cards_gradient.dart';
import 'package:pages/pages/simple_transitions.dart';
import 'package:pages/pages/waves.dart';

class MainPage extends StatelessWidget {
  const MainPage({required this.onSliderChanged, super.key});

  static const title = 'MainPage';

  static const _map = <String, Widget>{
    SimpleTransitionsPage.title: SimpleTransitionsPage(),
    WavesPage.title: WavesPage(),
    CardsGradientPage.title: CardsGradientPage(),
  };

  final void Function(double) onSliderChanged;

  Future<void> pushShowcase(String title) async {
    await navigatorKey.currentState?.pushNamed(title);
  }

  @override
  Widget build(BuildContext context) {
    final durationValue = DurationData.of(context)!.durationValue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animations'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final view = _map.entries.elementAt(index);
          return _MainItem(
            index: index,
            title: view.key,
            onTap: () => pushShowcase(view.key),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _map.length,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Duration: ${durationValue.round()} ms',
                style: const TextStyle(fontSize: 18),
              ),
              Slider(
                max: 4000,
                activeColor: Colors.green,
                inactiveColor: Colors.purple,
                thumbColor: Colors.black,
                divisions: 40,
                value: durationValue,
                onChanged: onSliderChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainItem extends StatelessWidget {
  const _MainItem({
    required this.index,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox.fromSize(
        size: const Size.fromHeight(70),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Text(
                index.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
