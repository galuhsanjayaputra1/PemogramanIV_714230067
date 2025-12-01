import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/ulbi_bg.jpg"), // BACKGROUND JPG
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black38, // biar teks tetap terbaca
            BlendMode.darken,
          ),
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // FOTO KAMU DALAM JPG
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage("assets/galuh.jpg"), // FOTO JPG
          ),

          const SizedBox(height: 20),

          const Text(
            "Aplikasi Contact List",
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Nama: Galuh Sanjaya Putra\nNPM: 714230067",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
