import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/registrasi.dart';

class RegistrasiBloc {
  // Fungsi untuk melakukan registrasi dengan parameter nama, email, dan password
  static Future<Registrasi> registrasi({
    String? nama,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registrasi;  // URL API untuk registrasi
    var body = {
      "nama": nama, 
      "email": email, 
      "password": password
    };

    // Memanggil API untuk melakukan request registrasi
    var response = await Api().post(apiUrl, body);
    
    // Parsing response dari server ke format JSON
    var jsonObj = json.decode(response.body);
    
    // Mengembalikan data yang sudah di-convert ke model Registrasi
    return Registrasi.fromJson(jsonObj);
  }
}
