import 'package:flutter/material.dart';

class MyStateFull extends StatefulWidget {
  const MyStateFull({super.key});

  @override
  State<MyStateFull> createState() => _MyStateFullState();
}

class _MyStateFullState extends State<MyStateFull> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Hello world, statefull widget!')),
      ),
    );
  }
}