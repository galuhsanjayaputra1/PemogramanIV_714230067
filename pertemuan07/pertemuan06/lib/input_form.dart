import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyInputForm(),
    );
  }
}

class MyInputForm extends StatefulWidget {
  const MyInputForm({super.key});

  @override
  State<MyInputForm> createState() => _MyFormValidationState();
}

class _MyFormValidationState extends State<MyInputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  final List<Map<String, dynamic>> _myDataList = [];

  Map<String, dynamic>? editedData; // menyimpan data yang sedang diedit

  // --- Validasi Email ---
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

  void _addData() {
    final data = {
      'name': _controllerNama.text,
      'email': _controllerEmail.text,
    };

    setState(() {
      if (editedData != null) {
        // Jika sedang dalam mode edit
        editedData!['name'] = data['name'];
        editedData!['email'] = data['email'];
        editedData = null; // reset
      } else {
        // Tambah data baru
        _myDataList.add(data);
      }

      _controllerNama.clear();
      _controllerEmail.clear();
    });
  }

  // --- Edit Data ---
  void _editData(Map<String, dynamic> data) {
    setState(() {
      _controllerEmail.text = data['email'];
      _controllerNama.text = data['name'];
      editedData = data;
    });
  }

  // --- Hapus Data dengan Konfirmasi ---
  void _deleteData(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Data'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // batal
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myDataList.remove(data);
                });
                Navigator.of(context).pop(); // tutup dialog
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = editedData != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Validation'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // --- Input Email ---
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    fillColor: Color.fromARGB(255, 222, 254, 255),
                    filled: true,
                  ),
                ),
              ),

              // --- Input Nama ---
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    fillColor: Color.fromARGB(255, 222, 254, 255),
                    filled: true,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // --- Tombol Submit / Update ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEditing ? Colors.orange : Colors.blue,
                ),
                child: Text(isEditing ? "Update" : "Submit"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _addData();
                    });
                  }
                },
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'List Data',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // --- ListView Data ---
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _myDataList.length,
                itemBuilder: (context, index) {
                  final data = _myDataList[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(
                          'ULBI',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(data['name'] ?? ''),
                      subtitle: Text(data['email'] ?? ''),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          // Tombol Edit
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _editData(data);
                              });
                            },
                            icon: const Icon(Icons.edit, color: Colors.orange),
                          ),

                          // Tombol Hapus (dengan dialog konfirmasi)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _deleteData(data);
                              });
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
