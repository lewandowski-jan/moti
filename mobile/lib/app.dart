import 'package:flutter/material.dart';

class MtApp extends StatelessWidget {
  const MtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Moti'),
        ),
      ),
    );
  }
}
