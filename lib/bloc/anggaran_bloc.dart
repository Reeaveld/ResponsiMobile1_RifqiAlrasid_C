import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '../model/anggaran.dart';

class AnggaranBloc {
  static Future<List<Anggaran>> getAnggarans() async {
    String apiUrl = ApiUrl.listAnggaran; // Ganti dengan endpoint list anggaran
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listAnggaran = (jsonObj as Map<String, dynamic>)['data'];
    List<Anggaran> anggarans = [];
    for (int i = 0; i < listAnggaran.length; i++) {
      anggarans.add(Anggaran.fromJson(listAnggaran[i]));
    }
    return anggarans;
  }

  static Future addAnggaran({Anggaran? anggaran}) async {
    String apiUrl = ApiUrl.createAnggaran; // Ganti dengan endpoint create anggaran

    var body = {
      "budget_item": anggaran!.budgetItem,
      "allocated": anggaran.allocated,
      "spent": anggaran.spent
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateAnggaran({required Anggaran anggaran}) async {
    String apiUrl = ApiUrl.updateAnggaran(anggaran.id!); // Ganti dengan endpoint update anggaran
    print(apiUrl);

    var body = {
      "budget_item": anggaran.budgetItem,
      "allocated": anggaran.allocated,
      "spent": anggaran.spent
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteAnggaran({int? id}) async {
    String apiUrl = ApiUrl.deleteAnggaran(id!); // Ganti dengan endpoint delete anggaran

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
