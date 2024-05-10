import 'dart:convert';
import 'dart:io';

import 'package:ucp_kedua/model/kuliner.dart';
import 'package:ucp_kedua/service/kuliner_service.dart';

class KulinerController {
  final kulinerService = KulinerService();

  Future<Map<String, dynamic>> addPlace(Kuliner place, File? file) async {
    Map<String, String> data = {
      "nama": place.nama,
      "date": place.tanggal,
      "lokasi": place.lokasi
    };

    try {
      var response = await kulinerService.addPlace(data, file);
      if (response.statusCode == 201) {
        return {
          'success': true,
          "message": "Data berhasil disimpan",
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            "message": decodedJson['message'] ?? 'Terjadi kesalahan',
          };
        }
        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          "message":
              decodedJson['message'] ?? 'Terjadi kesalahan saat menyimpan data'
        };
      }
    } catch (e) {
      return {"success": false, "message": 'Terjadi kesalahan: $e'};
    }
  }

  Future<List<Kuliner>> getLocation() async {
    try {
      List<dynamic> locationData = await kulinerService.fetchLocation();
      List<Kuliner> location =
          locationData.map((json) => Kuliner.fromMap(json)).toList();
      return location;
    } catch (e) {
      print(e);
      throw Exception('Failed to get location');
    }
  }
}
