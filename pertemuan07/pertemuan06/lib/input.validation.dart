import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyFormValidation(),
    );
  }
}

class MyFormValidation extends StatefulWidget {
  const MyFormValidation({super.key});

  @override
  State<MyFormValidation> createState() => _MyFormValidationState();
}

class _MyFormValidationState extends State<MyFormValidation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  // --- VALIDATOR EMAIL ---
  String? _validateEmail(String? value) {
    const String expression =
        "[a-zA-Z0-9+._%-+]{1,256}"
        "\\@"
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
        "("
        "\\."
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
        ")+";
    final RegExp regExp = RegExp(expression);

    if (value == null || value.isEmpty) {
      return 'Email wajib diisi';
    }
    if (!regExp.hasMatch(value)) {
      return "Tolong inputkan email yang valid!";
    }
    return null;
  }

  // --- VALIDATOR NAMA ---
  String? _validateNama(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.length < 3) {
      return 'Masukkan setidaknya 3 karakter';
    }
    return null;
  }

  @override
  void dispose() {
    _controllerNama.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  // --- TAMPILKAN ALERT DIALOG ---
  void _showDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Data yang Dimasukkan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${_controllerNama.text}'),
              const SizedBox(height: 8),
              Text('Email: ${_controllerEmail.text}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Validation'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // --- FIELD EMAIL ---
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                decoration: const InputDecoration(
                  hintText: 'Write your email here...',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  fillColor: Color.fromARGB(255, 222, 254, 255),
                  filled: true,
                ),
              ),
            ),

            // --- FIELD NAMA ---
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controllerNama,
                keyboardType: TextInputType.name,
                validator: _validateNama,
                decoration: const InputDecoration(
                  hintText: 'Write your name here...',
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  fillColor: Color.fromARGB(255, 222, 254, 255),
                  filled: true,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // --- TOMBOL SUBMIT ---
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Jika valid, tampilkan dialog
                  _showDataDialog(context);
                } else {
                  // Jika form belum lengkap
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please complete the form'),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
