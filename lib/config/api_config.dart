import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig{
  static String baseUrl = "http://192.168.10.48:9002/api/v1/mecanote/";
  // static String baseUrl = "http://192.168.100.131:9001/api/v1/mecanote/";
  // static String baseUrl = "http://192.168.10.12:9000/api/v1/mecanote/";
  // static String baseUrl = "http://192.168.1.63:9000/api/v1/mecanote/";
  // static String baseUrl = "http://10.0.0.2:9000/api/v1/mecanote/";

  // GET THE TOKEN
  static Future<String> getToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("token") ?? '';
  }


  // SET THE TOKEN
  static Future<void> setToken(token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }


  static Future<void> setData(response) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", response['data']['payload']['token']);
    preferences.setString("username", response['data']['payload']['username']);
    preferences.setString("role", response['data']['payload']['role']);
  }
  static Future<void> setDataSignWithGoogle(response) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", response['payload']['token']);
    preferences.setString("username", response['payload']['username']);
    preferences.setString("role", response['payload']['role']);
  }



  static Future<void> setUsername(username) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('username', username);
  }

  static Future<String> getUsername() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('username') ?? '';
  }

  static Future<String> getRole() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('role') ?? '';
  }
}
