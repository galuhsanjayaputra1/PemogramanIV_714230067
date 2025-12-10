import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyShared extends StatefulWidget {
  const MyShared({super.key});

  @override
  State<MyShared> createState() => _MySharedState();
}

class _MySharedState extends State<MyShared> {
  late SharedPreferences prefs;

  final TextEditingController _inputController = TextEditingController(); 
  final TextEditingController _outputController = TextEditingController(); 

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  save() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('IniData', _inputController.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Data saved!")));
  }

  retrieve() async {
    prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('IniData') ?? "";

    _outputController.text = value;

    setState(() {});
  }

  deleteValue() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('IniData');

    _outputController.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Data deleted!")));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input data (untuk Save)
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: "Masukkan Data",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: save,
              child: const Text("Save"),
            ),

            const SizedBox(height: 20),

            // Output data (untuk Get Value)
            TextField(
              readOnly: true,
              controller: _outputController,
              decoration: const InputDecoration(
                labelText: "Hasil Get Value",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: retrieve,
              child: const Text("Get Value"),
            ),

            ElevatedButton(
              onPressed: deleteValue,
              child: const Text("Delete Value"),
            ),
          ],
        ),
      ),
    );
  }
}
