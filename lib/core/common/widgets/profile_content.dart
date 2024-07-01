import 'package:flutter/material.dart';

import '../../constants_finals.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: singleBoxShadow,
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      height: 480,
      child: child,
    );
  }
}
