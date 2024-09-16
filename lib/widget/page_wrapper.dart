import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({
    required this.title,
    required this.body,
    this.floatingAction,
    super.key,
    this.useSafeArea = true,
  });

  final String title;
  final Widget body;
  final bool useSafeArea;
  final VoidCallback? floatingAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: useSafeArea ? SafeArea(child: body) : body,
      floatingActionButton: Visibility(
        visible: floatingAction != null,
        child: FloatingActionButton(
          onPressed: floatingAction,
          child: const Icon(CupertinoIcons.restart),
        ),
      ),
    );
  }
}
