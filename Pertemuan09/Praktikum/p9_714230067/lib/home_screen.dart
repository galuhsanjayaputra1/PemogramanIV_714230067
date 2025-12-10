import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late SharedPreferences logindata;
  String username = "";

  void initial() async {
    logindata = await SharedPreferences.getInstance();

    setState(() {
      // aman dari nilai "null"
      username = logindata.getString('username') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Home',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // tampilkan username
              Text(
                "Hello, $username",
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 30),

              // tombol logout dengan rememberMe
              ElevatedButton(
                onPressed: () {
                  logindata.setBool('login', true);

                  // cek rememberMe
                  bool remember = logindata.getBool("rememberMe") ?? false;

                  // jika rememberMe TIDAK aktif → hapus username
                  if (!remember) {
                    logindata.remove('username');
                    logindata.remove('savedUsername');
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

