import 'dart:convert';
import '../config/api_config.dart';
import 'package:http/http.dart' as http;


class ReferenceService{

  static String  reference = "reference";

  static Future listProfiles() async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$reference/${'profiles'}');
      print(url);
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
