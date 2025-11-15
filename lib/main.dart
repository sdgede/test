import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SiswaList());
  }
}

class SiswaList extends StatefulWidget {
  const SiswaList({super.key});

  @override
  State<SiswaList> createState() => _SiswaListState();
}

class _SiswaListState extends State<SiswaList> {
  List<Map<String, dynamic>> siswaList = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> request() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      Dio dio = Dio();
      final response = await dio.get(
        "",
      );

      debugPrint("Response: ${response.data}");

      if (response.data is List) {
        List data = response.data;
        setState(() {
          siswaList = data.cast<Map<String, dynamic>>();
        });
      } else if (response.data is Map && response.data["data"] is List) {
        List data = response.data["data"];
        setState(() {
          siswaList = data.cast<Map<String, dynamic>>();
        });
      } else {
        setState(() {
          errorMessage = "Format data tidak sesuai";
        });
      }
    } on DioException catch (e) {
      setState(() {
        errorMessage = "Error: ${e.message}";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Siswa")),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : RefreshIndicator(
                onRefresh: request, // tarik untuk refresh
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: siswaList.length,
                  itemBuilder: (context, index) {
                    final siswa = siswaList[index];
                    return ListTile(
                      title: Text(siswa["nama_lengkap"] ?? "Tanpa Nama"),
                      subtitle: Text("NIS: ${siswa["nis"] ?? "-"}"),
                    );
                  },
                ),
              ),
    );
  }
}
