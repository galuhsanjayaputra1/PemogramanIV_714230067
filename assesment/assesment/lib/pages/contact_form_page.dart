import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/contact_model.dart';

class ContactFormPage extends StatefulWidget {
  final ContactModel? contact;
  final int? index;

  const ContactFormPage({super.key, this.contact, this.index});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController dateC = TextEditingController();

  Color? pickedColor;
  String hexColor = "";

  String fileName = "";
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();

    if (widget.contact != null) {
      nameC.text = widget.contact!.name;
      phoneC.text = widget.contact!.phone;
      dateC.text = widget.contact!.date;
      fileName = widget.contact!.fileName;
      imageBytes = widget.contact!.imageBytes;
      hexColor = widget.contact!.color;

      pickedColor = Color(int.parse(hexColor.replaceAll("#", "0xff")));
    }
  }

  // PICK IMAGE
  Future pickImage() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result == null) return;

    setState(() {
      fileName = result.files.first.name;
      imageBytes = result.files.first.bytes!;
    });
  }

  // PICK COLOR
  void pickColorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pick Color"),
        content: ColorPicker(
          pickerColor: pickedColor ?? Colors.blue,
          onColorChanged: (value) {
            setState(() {
              pickedColor = value;

              // FIX DEPRECATED → gunakan toARGB32()
              hexColor =
                  "#${value.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}";
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  // SUBMIT
  void submit() {
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Form belum lengkap")));
      return;
    }

    if (pickedColor == null || hexColor.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Warna belum dipilih")));
      return;
    }

    if (imageBytes == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Gambar wajib dipilih")));
      return;
    }

    Navigator.pop(
      context,
      ContactModel(
        name: nameC.text,
        phone: phoneC.text,
        date: dateC.text,
        color: hexColor,
        fileName: fileName,
        imageBytes: imageBytes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Contact")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              // NAME
              TextFormField(
                controller: nameC,
                validator: (v) => validateName(v!),
                decoration: const InputDecoration(labelText: "Nama"),
              ),
              const SizedBox(height: 16),

              // PHONE
              TextFormField(
                controller: phoneC,
                validator: (v) => validatePhone(v!),
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
              const SizedBox(height: 16),

              // DATE
              TextFormField(
                controller: dateC,
                readOnly: true,
                validator: (v) => v!.isEmpty ? "Tanggal harus diisi" : null,
                decoration: const InputDecoration(
                  labelText: "Date",
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                onTap: pickDate,
              ),

              const SizedBox(height: 20),

              // COLOR PREVIEW
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: pickedColor ?? Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: pickColorDialog,
                child: const Text("Pick Color"),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text("Pick File"),
              ),

              const SizedBox(height: 10),

              // IMAGE PREVIEW
              imageBytes != null
                  ? Image.memory(imageBytes!, height: 200)
                  : const Text("Tidak ada gambar dipilih"),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: submit,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // VALIDASI NAMA
  String? validateName(String value) {
    if (value.isEmpty) return "Nama harus diisi";
    if (!value.contains(" ")) return "Nama minimal 2 kata";

    final words = value.split(" ");
    for (var w in words) {
      if (!RegExp(r"^[A-Z][a-zA-Z]*$").hasMatch(w)) {
        return "Setiap kata harus kapital & tanpa angka";
      }
    }
    return null;
  }

  // VALIDASI TELEPON
  String? validatePhone(String value) {
    if (value.isEmpty) return "Nomor telepon harus diisi";
    if (!RegExp(r"^[0-9]+$").hasMatch(value)) return "Harus angka";
    if (value.length < 8 || value.length > 13) return "Digit 8–13";
    if (!value.startsWith("62")) return "Harus mulai dengan 62";
    return null;
  }

  // DATE PICKER
  Future<void> pickDate() async {
    FocusScope.of(context).unfocus();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        dateC.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }
}
