class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id'; //sesuaikan dengan ip laptop / localhost teman teman / url server Codeigniter

  static const String baseUrlKeuangan = baseUrl + '/api/keuangan';
  static const String registrasi = baseUrl + '/api/registrasi';
  static const String login = baseUrl + '/api/login';
  static const String listProduk = baseUrlKeuangan + '/pemasukan';
  static const String createProduk = baseUrlKeuangan + '/pemasukan';

  static String updateProduk(int id) {
    return baseUrlKeuangan + '/pemasukan/' + id.toString() + '/update';
  }

  static String showProduk(int id) {
    return baseUrlKeuangan + '/pemasukan/' + id.toString();
  }

  static String deleteProduk(int id) {
    return baseUrlKeuangan + '/pemasukan/' + id.toString() + '/delete';
  }
}