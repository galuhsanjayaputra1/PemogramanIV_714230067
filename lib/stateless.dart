import 'package:flutter/material.dart';

class Mystatless extends StatelessWidget {
  const Mystatless({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Hello world, stateless!')),
      ),
    );
  }
}