import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p9_714230067/botnav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late SharedPreferences loginData;
  bool rememberMe = false;
  bool newUser = true;

  @override
  void initState() {
    super.initState();
    loadRememberedUser();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 🔹 LOAD REMEMBER ME + USERNAME
  void loadRememberedUser() async {
    loginData = await SharedPreferences.getInstance();

    rememberMe = loginData.getBool("rememberMe") ?? false;

    if (rememberMe) {
      _usernameController.text = loginData.getString("savedUsername") ?? "";
    }

    newUser = (loginData.getBool('login') ?? true);

    if (newUser == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DynamicBottomNavBar()),
      );
    }

    setState(() {});
  }

  String? _validateUsername(String? value) {
    if (value != null && value.length < 4) {
      return 'Masukkan minimal 4 karakter';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value != null && value.length < 3) {
      return 'Masukkan minimal 3 karakter';
    }
    return null;
  }

  // 🔹 LOGIN FUNCTION
  void _login() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    String username = _usernameController.text;

    // Save login status
    loginData.setBool('login', false);
    loginData.setString('username', username);

    // 🔹 Handle Remember Me
    if (rememberMe) {
      loginData.setBool("rememberMe", true);
      loginData.setString("savedUsername", username);
    } else {
      loginData.setBool("rememberMe", false);
      loginData.remove("savedUsername");
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DynamicBottomNavBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Shared Preference')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Username
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: _validateUsername,
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_rounded),
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                    ),
                  ),

                  // Password
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      validator: _validatePassword,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded),
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                    ),
                  ),

                  // 🔹 Remember Me Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text("Remember Me"),
                    ],
                  ),

                  // LOGIN BUTTON
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
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

