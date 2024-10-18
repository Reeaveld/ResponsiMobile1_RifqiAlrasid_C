import 'package:flutter/material.dart';
import '/helpers/user_info.dart';
import '/ui/login_page.dart';
import '/ui/anggaran_page.dart'; // Mengubah produk_page menjadi anggaran_page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const AnggaranPage(); // Mengubah ke halaman anggaran
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Keuangan', // Judul aplikasi
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green, // Warna utama aplikasi
        scaffoldBackgroundColor: const Color.fromARGB(255, 7, 23, 8), // Latar belakang tema gelap hijau
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green, // Warna AppBar
          titleTextStyle: TextStyle(
            fontFamily: 'Tinos', // Menggunakan font Tinos
            fontSize: 20,
            color: Colors.white, // Warna teks AppBar putih
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Tinos', // Menggunakan font Tinos
            color: Colors.white, // Warna teks putih
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.white, // Warna label teks putih
          ),
          hintStyle: TextStyle(
            color: Colors.white54, // Warna hint teks putih (lebih redup)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Warna border saat tidak fokus
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green), // Warna border saat fokus
          ),
          filled: true, // Agar background input terlihat
          fillColor: Colors.black26, // Warna latar belakang input
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Warna latar tombol hijau
            textStyle: const TextStyle(
              fontFamily: 'Tinos', // Font tombol
              fontSize: 16,
              color: Colors.white, // Warna teks tombol putih
            ),
          ),
        ),
      ),
      home: page,
    );
  }
}
