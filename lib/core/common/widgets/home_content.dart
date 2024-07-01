import 'package:flutter/material.dart';

import '../../constants_finals.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.child,
    required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: doubleBoxShadow,
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: height,
      child: child,
    );
  }
}
