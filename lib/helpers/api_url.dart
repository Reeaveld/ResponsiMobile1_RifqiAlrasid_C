class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id/api/keuangan';

  static const String registrasi =
      'http://responsi.webwizards.my.id/api/registrasi';
  static const String login = 'http://responsi.webwizards.my.id/api/login';
  
  // API endpoints untuk anggaran
  static const String listAnggaran = baseUrl + '/anggaran'; // Endpoint untuk mendapatkan daftar anggaran
  static const String createAnggaran = baseUrl + '/anggaran'; // Endpoint untuk membuat anggaran
  
  static String updateAnggaran(int id) {
    return baseUrl + '/anggaran/' + id.toString(); // Endpoint untuk memperbarui anggaran
  }

  static String showAnggaran(int id) {
    return baseUrl + '/anggaran/' + id.toString(); // Endpoint untuk menampilkan detail anggaran
  }

  static String deleteAnggaran(int id) {
    return baseUrl + '/anggaran/' + id.toString(); // Endpoint untuk menghapus anggaran
  }
}
