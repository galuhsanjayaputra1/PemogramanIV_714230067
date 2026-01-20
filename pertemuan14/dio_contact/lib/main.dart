import 'package:dio_contact/view/screen/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Properti untuk menghilangkan label DEBUG di pojok kanan atas
      debugShowCheckedModeBanner: false, 
      
      title: 'Flutter Demo', 
      theme: ThemeData(
        // primarySwatch diatur ke indigo sesuai modul hal 7
        primarySwatch: Colors.indigo,
        useMaterial3: false,
      ),
      // Halaman awal diarahkan ke LoginPage sesuai modul hal 7
      home: const LoginPage(), 
    );
  }
}