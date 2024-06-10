class Api {
  static const _host = "http://192.168.56.2/api_if22c";

  static String _mahasiswa = "$_host/mahasiswa";

  // mahasiswa
  static String getMahasiswa = "$_mahasiswa/view.php";
  static String addMahasiswa = "$_mahasiswa/add.php";
  static String updateMahasiswa = "$_mahasiswa/update.php";
  static String deleteMahasiswa = "$_mahasiswa/delete.php";
}
