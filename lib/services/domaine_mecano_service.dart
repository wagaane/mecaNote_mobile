import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meca_note_mobile/config/api_config.dart';

class GarageService{

  static String service = "services/";

  // LISTE DES GARAGE
  static Future listGarages() async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$service${'list-services'}');
      String? token = await ApiConfig.getToken();

      var headers = {
        'Accept': 'application/json',
        'Authorization': "Bearer ${token!}" ?? '',
      };

      var response = await http.get(
        url,
        headers: headers,
      );
      return jsonDecode(utf8.decode(response.bodyBytes));
    }catch(e){
      print(e);
      return {
        "status": 'EXCEPTION',
        "message": 'Une erreur est survenue lors du chargement des données.'
      };
    }

  }
  // DES DES SERVICES D'UN GARAGE
  static Future listServicesByGarageId(id) async{

    try{
      print('====== Liste services d\'un garage avec id: $id ======');
      var url = Uri.parse('${ApiConfig.baseUrl}$service${'my-list-services'}/$id');
      String? token = await ApiConfig.getToken();

      var headers = {
        'Accept': 'application/json',
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
        "message": 'Une erreur est survenue lors du chargement des données.'
      };
    }

  }
  // MISE A JOUR DE LA LISTE D'UN GARAGE
  static Future updateMyList(List<String> domaines) async{

    String  domainesList = domaines.join(",");
    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$service${'update-mecano-domaines-mecanos/${domainesList}'}');
      String? token = await ApiConfig.getToken();

      var headers = {
        'Accept': 'application/json',
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
        "message": 'Une erreur est survenue lors du chargement des données.'
      };
    }

  }
}
