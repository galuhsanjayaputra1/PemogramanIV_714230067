import 'package:flutter/material.dart';
import 'data_service.dart';
import 'user.dart';
import 'user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService _service = DataService();
  final _nameCtl = TextEditingController();
  final _jobCtl = TextEditingController();

  String _result = '-';
  List<User> _users = [];
  UserCreate? usCreate;

  @override
  void dispose() {
    _nameCtl.dispose();
    _jobCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API (DIO)'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameCtl,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _jobCtl,
              decoration: const InputDecoration(
                labelText: 'Job',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // ===== CRUD =====
            Row(
              children: [
                _btn('GET', () async {
                  final res = await _service.getUsers();
                  setState(() => _result = res.toString());
                }),
                _btn('POST', () async {
                  final res = await _service.postUser(
                    UserCreate(name: _nameCtl.text, job: _jobCtl.text),
                  );
                  setState(() => usCreate = res);
                }),
                _btn('PUT', () async {
                  final res = await _service.putUser(
                    '3',
                    _nameCtl.text,
                    _jobCtl.text,
                  );
                  setState(() => usCreate = res);
                }),
                _btn('DELETE', () async {
                  final res = await _service.deleteUser('4');
                  setState(() => _result = res ?? '-');
                }),
              ],
            ),

            const SizedBox(height: 6),

            // ===== MODEL + RESET =====
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () async {
                      final users = await _service.getUserModel();
                      setState(() => _users = users ?? []);
                    },
                    child: const Text('Model Class User Example'),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _result = '-';
                        _users.clear();
                        usCreate = null;
                        _nameCtl.clear();
                        _jobCtl.clear();
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Text('Result',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            Expanded(
              child: _users.isEmpty
                  ? SingleChildScrollView(child: Text(_result))
                  : ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (_, i) {
                        final u = _users[i];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(u.avatar),
                            ),
                            title: Text('${u.firstName} ${u.lastName}'),
                            subtitle: Text(u.email),
                          ),
                        );
                      },
                    ),
            ),

            if (usCreate != null) UserCard(usrCreate: usCreate!)
          ],
        ),
      ),
    );
  }

  Expanded _btn(String text, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(text),
        ),
      ),
    );
  }
}
