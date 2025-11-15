class SiswaModel {
  int? idSiswa;
  int? nis;
  String? namaLengkap;
  int? idKelas;
  String? username;
  String? password;

  SiswaModel({
    this.idSiswa,
    this.nis,
    this.namaLengkap,
    this.idKelas,
    this.password,
    this.username,
  });

  factory SiswaModel.fromJson(Map<String, dynamic> json) {
    return SiswaModel(
      idSiswa: json['id_siswa'],
      nis: json['nis'],
      namaLengkap: json['nama_lengkap'],
      idKelas: json['id_kelas'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_siswa': idSiswa,
      'nis': nis,
      'nama_lengkap': namaLengkap,
      'id_kelas': idKelas,
      'username': username,
      'password': password,
    };
  }
}
