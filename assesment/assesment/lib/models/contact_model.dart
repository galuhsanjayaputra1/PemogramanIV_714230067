import 'dart:typed_data';

class ContactModel {
  final String name;
  final String phone;
  final String date;
  final String color;
  final String fileName;
  final Uint8List? imageBytes;

  ContactModel({
    required this.name,
    required this.phone,
    required this.date,
    required this.color,
    required this.fileName,
    required this.imageBytes,
  });
}
