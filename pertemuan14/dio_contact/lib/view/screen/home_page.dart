import 'package:flutter/material.dart';
import 'package:dio_contact/model/contact_model.dart';
import 'package:dio_contact/services/api_services.dart';
import 'package:dio_contact/services/auth_manager.dart'; 
import 'package:dio_contact/view/screen/login_page.dart'; 
import 'package:dio_contact/view/widget/contact_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtl = TextEditingController();
  final _numberCtl = TextEditingController();
  final ApiServices _dataService = ApiServices();
  final List<ContactsModel> _contactMdl = [];
  ContactResponse? ctRes;
  bool isEdit = false;
  String idContact = '';
  
  late SharedPreferences logindata;
  String username = '';
  String token = ''; // Variabel baru untuk token

  @override
  void initState() {
    super.initState();
    inital(); 
    refreshContactList(); 
  }

  void inital() async {
    logindata = await SharedPreferences.getInstance(); 
    setState(() {
      username = logindata.getString('username') ?? "";
      token = logindata.getString('token') ?? ""; // Mengambil token yang disimpan
    });
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Tidak')),
            TextButton(
              onPressed: () async {
                await AuthManager.logout();
                if (!mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Text('Ya'),
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
        title: const Text('Contacts API'),
        actions: [
          IconButton(
            onPressed: () => _showLogoutConfirmationDialog(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CARD MODIFIKASI (SESUAI GAMBAR)
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 2.0),
                color: Colors.tealAccent,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column( // Diganti menjadi Column agar Token tampil di bawah Username
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.account_circle_rounded),
                          const SizedBox(width: 8.0),
                          Text(
                            'Login sebagai : $username',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.vpn_key), // Ikon Token
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              'Token : $token',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              TextFormField(
                controller: _nameCtl,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Nama'),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _numberCtl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Nomor HP'),
              ),
              const SizedBox(height: 8.0),
              
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final postModel = ContactInput(namaKontak: _nameCtl.text, nomorHp: _numberCtl.text);
                      if (isEdit) {
                        await _dataService.putContact(idContact, postModel);
                      } else {
                        await _dataService.postContact(postModel);
                      }
                      setState(() { isEdit = false; });
                      _nameCtl.clear();
                      _numberCtl.clear();
                      await refreshContactList();
                    }
                  },
                  child: Text(isEdit ? 'UPDATE' : 'POST'),
                ),
              ),
              
              if (ctRes != null) ContactCard(ctRes: ctRes!, onDismissed: () => setState(() => ctRes = null)),
              
              const Text('List Contact', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              Expanded(child: _buildListContact()),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Sisa fungsi refreshContactList, deleteContact, buildListContact tetap sama)
  Widget _buildListContact() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final ctList = _contactMdl[index];
        return Card(
          child: ListTile(
            title: Text(ctList.namaKontak),
            subtitle: Text(ctList.nomorHp),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    final contacts = await _dataService.getSingleContact(ctList.id);
                    if (contacts != null) {
                      setState(() {
                        _nameCtl.text = contacts.namaKontak;
                        _numberCtl.text = contacts.nomorHp;
                        isEdit = true;
                        idContact = contacts.id;
                      });
                    }
                  },
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () => _showDeleteConfirmationDialog(ctList.id, ctList.namaKontak),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
      itemCount: _contactMdl.length,
    );
  }

  Future<void> refreshContactList() async {
    final users = await _dataService.getAllContact();
    if (users != null) {
      setState(() {
        _contactMdl.clear();
        _contactMdl.addAll(users.toList().reversed);
      });
    }
  }

  void _showDeleteConfirmationDialog(String id, String nama) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus data $nama ?'),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
            TextButton(
              onPressed: () async {
                await _dataService.deleteContact(id);
                if (!mounted) return;
                Navigator.pop(context);
                await refreshContactList();
              },
              child: const Text('DELETE', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}