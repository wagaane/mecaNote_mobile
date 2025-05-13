import 'dart:convert';

import '../config/api_config.dart';
import 'package:http/http.dart' as http;


class AuthService{
  static String  auth = "auth";

  // CONNEXION
  static Future login(data) async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$auth/${'login'}');
      String? token = await ApiConfig.getToken();

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',

        'Authorization': "Bearer ${token!}" ?? '',
      };

      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data)
      );
      return jsonDecode(utf8.decode(response.bodyBytes));
    }catch(e){
      return {
        "status": 'EXCEPTION',
        "message": 'Une erreur est survenue lors de la connexion.'
      };
    }

  }
  // INSCRIPTION
  static Future register(data) async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$auth/${'register'}');
      String? token = await ApiConfig.getToken();

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',

        'Authorization': "Bearer ${token!}" ?? '',
      };

      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data)
      );
      return jsonDecode(utf8.decode(response.bodyBytes));
    }catch(e){
      return {
        "status": 'EXCEPTION',
        "message": 'Une erreur est survenue lors de la connexion.'
      };
    }

  }

}
