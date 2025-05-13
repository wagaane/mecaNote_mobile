import 'dart:convert';

import '../config/api_config.dart';
import 'package:http/http.dart' as http;
class DemandService{
  static String  demande = "demande";

  static Future listDemands(int page, int size,String prenom, String nom, String status, String filter, String date, String adresse) async{
    print(filter);
    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$demande/${'list-demands'}?page=$page&size=$size&prenom=$prenom&nom=$nom&status=$status&filter=$filter&date=$date&adresse=$adresse');
      String? token = await ApiConfig.getToken();

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',

        'Authorization': "Bearer ${token!}" ?? '',
      };

      var response = await http.get(
          url,
          headers: headers,
      );
      return jsonDecode(utf8.decode(response.bodyBytes));
    }catch(e){
      return {
        "status": 'EXCEPTION',
        "message": 'Une erreur est survenue lors de la connexion.'
      };
    }

  }

  static Future  getLenDemands() async {
    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$demande/${'count'}');
      String? token = await ApiConfig.getToken();

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',

        'Authorization': "Bearer ${token!}" ?? '',
      };

      var response = await http.get(
        url,
        headers: headers,
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
