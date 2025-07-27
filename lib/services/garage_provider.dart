import 'dart:convert';
import 'dart:io';
import 'package:meca_note_mobile/config/api_config.dart';
import 'package:path/path.dart' as path;

import 'package:global/global.dart' as http;

class GarageService {

  static Future<void> uploadImage(File imageFile, int id, String type) async {
    print('garage----- : $type');
    final uri = Uri.parse(
        '${ApiConfig.baseUrl}file/upload?id=$id&type=garage'); // ou ton IP locale

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer ${await ApiConfig.getToken()}'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        filename: path.basename(imageFile.path),
      ));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed: ${response.statusCode}');
    }
  }
  static Future<dynamic> saveGarage(data) async {
    final url = Uri.parse('${ApiConfig.baseUrl}garage/create');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await ApiConfig.getToken()}',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('✅ Données envoyées avec succès');
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print('❌ Erreur: ${response.statusCode}');
      print(response.body);
      return jsonDecode(response.body);
    }
  }
  static Future<dynamic> downloadFile(String fileName) async {
    final url = Uri.parse('${ApiConfig.baseUrl}file/download/0cf2a656-c2af-4a88-8fda-f5b9cf1d6356_20250721101648.1000035518.heic');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await ApiConfig.getToken()}',
      },
    );

    if (response.statusCode == 200) {
      print('Image loaded');
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print('❌ Erreur: ${response.statusCode}');
      print(response.body);
      return jsonDecode(response.body);
    }
  }
  static Future<dynamic> listGarages({page, size}) async {
    final url = Uri.parse('${ApiConfig.baseUrl}garage/list-garages?page=$page&size=$size');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await ApiConfig.getToken()}',
      },
    );

    if (response.statusCode == 200) {
      print('List loaded');
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print('❌ Erreur: ${response.statusCode}');
      print(response.body);
      return jsonDecode(response.body);
    }
  }




}
