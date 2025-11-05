import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'model/tourism_place.dart';

var iniFontCustom = const TextStyle(fontFamily: 'Staatliches');

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Stack untuk gambar dan tombol kembali
              Stack(
                children: <Widget>[
                  Image.asset(place.imageAsset),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Gambar utama dengan sudut membulat

              // Nama tempat
              Container(
                margin: const EdgeInsets.only(top: 16.0, bottom: 10.0),
                child: Text(
                  place.name, // Menampilkan nama tempat dari objek place
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Staatliches',
                  ),
                ),
              ),

              // Baris ikon + teks (dengan data dinamis)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Color.fromARGB(255, 34, 107, 0),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          place.openDays, // Menampilkan openDays dari objek place
                          style: iniFontCustom,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Color.fromARGB(255, 34, 107, 0),
                        ),
                        const SizedBox(height: 8),
                        Text(place.openTime), // Menampilkan openTime dari objek place
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          color: Color.fromARGB(255, 34, 107, 0),
                        ),
                        const SizedBox(height: 8),
                        Text(place.ticketPrice), // Menampilkan ticketPrice dari objek place
                      ],
                    ),
                  ],
                ),
              ),

              // Deskripsi (dengan data dinamis)
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  place.description, // Menampilkan description dari objek place
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                    color: Color.fromARGB(255, 84, 1, 133),
                  ),
                ),
              ),

              // ListView dengan gambar horizontal dan sudut membulat (dengan data dinamis)
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: place.imageUrls.map((url) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0), // Sudut membulat
                        child: Image.network(
                          url, // Menggunakan URL gambar dari imageUrls
                          fit: BoxFit.cover, // Menggunakan BoxFit.cover agar gambar sesuai ukuran
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
