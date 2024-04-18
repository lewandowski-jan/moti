import 'package:flutter/material.dart';
import 'package:moti/features/activities/presentation/activity_screen.dart';

class MtApp extends StatelessWidget {
  const MtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AcitivityScreen(),
    );
  }
}
