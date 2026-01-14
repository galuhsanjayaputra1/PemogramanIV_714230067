import 'package:dio_contact/view/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:dio_contact/model/login_model.dart';
import 'package:dio_contact/services/api_services.dart';
import 'package:dio_contact/services/auth_manager.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiServices _dataService = ApiServices();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    bool isLoggedIn = await AuthManager.isLoggedIn();
    if (isLoggedIn) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) => (value != null && value.length < 4) ? 'Masukkan minimal 4 karakter' : null;
  String? _validatePassword(String? value) => (value != null && value.length < 3) ? 'Masukkan minimal 3 karakter' : null;

  void displaySnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login Page')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: _validateUsername,
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_rounded),
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: _validatePassword,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password_rounded),
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final postModel = LoginInput(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        );

                        LoginResponse? res = await _dataService.login(postModel);

                        if (res != null && res.status == 200) {
                          // MENYIMPAN TOKEN KE AUTH MANAGER
                          await AuthManager.login(_usernameController.text, res.token ?? "");
                          
                          if (!mounted) return;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                            (route) => false,
                          );
                        } else {
                          if (!mounted) return;
                          displaySnackbar(res?.message ?? "Login Gagal");
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}