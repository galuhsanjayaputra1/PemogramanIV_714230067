import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import 'contact_form_page.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<ContactModel> contacts = [];

  void addContact(ContactModel c) {
    setState(() => contacts.add(c));
  }

  void updateContact(int index, ContactModel c) {
    setState(() => contacts[index] = c);
  }

  void deleteContact(int index) {
    setState(() => contacts.removeAt(index));
  }

  Color parseColor(String code) {
    return Color(int.parse(code.replaceAll("#", "0xff")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List Contacts")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ContactFormPage()));

          if (result != null) addContact(result);
        },
      ),
      body: contacts.isEmpty
          ? const Center(child: Text("Belum ada kontak"))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                var c = contacts[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // FOTO ATAU WARNA
                            c.imageBytes != null
                                ? CircleAvatar(
                                    radius: 28,
                                    backgroundImage: MemoryImage(c.imageBytes!),
                                  )
                                : CircleAvatar(
                                    radius: 28,
                                    backgroundColor: parseColor(c.color),
                                  ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    c.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(c.phone),
                                  Text(c.date),
                                  Text("File: ${c.fileName}"),
                                ],
                              ),
                            ),

                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () async {
                                    var updated = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ContactFormPage(
                                          contact: c,
                                          index: index,
                                        ),
                                      ),
                                    );

                                    if (updated != null) {
                                      updateContact(index, updated);
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => deleteContact(index),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // 👉 STRIP WARNA SESUAI PILIHAN USER
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: parseColor(c.color),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
