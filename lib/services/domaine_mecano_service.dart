import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meca_note_mobile/config/api_config.dart';

class DomaineMecanoService{

  static String domaineMecano = "domainemecano/";

  static Future list() async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$domaineMecano${'list-domaines-mecanos'}');
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
  static Future myList() async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$domaineMecano${'my-list-domaines-mecanos'}');
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
  static Future updateMyList(List<String> domaines) async{

    String  domainesList = domaines.join(",");
    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$domaineMecano${'update-mecano-domaines-mecanos/${domainesList}'}');
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
