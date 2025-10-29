import 'package:flutter/material.dart';

void main() {
  runApp(const Pertemuan4App());
}

class Pertemuan4App extends StatelessWidget {
  const Pertemuan4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Pertemuan 4',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tugas Pertemuan 4'),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: const WidgetLayout(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class WidgetLayout extends StatelessWidget {
  const WidgetLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          Container(
            width: 300,
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: const Text(
              'Box 1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              Container(
                width: 100,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: const Text(
                  'Box 2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 25),

             
              Container(
                width: 100,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: const Text(
                  'Box 3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
