import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meca_note_mobile/models/google_user.dart';

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

  static  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return {
          "status": 'EXCEPTION',
          "message": 'Une erreur est survenue lors de la connexion.'
        };
      }else{
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        Map<String, dynamic> decodedToken = JwtDecoder.decode(googleAuth.idToken!);


        GoogleUser user = GoogleUser.fromJson(decodedToken);



        user.profile = await ApiConfig.getRole();
        user.profile = user.profile.isEmpty ? 'UNKNOW': user.profile;


        await FirebaseAuth.instance.signInWithCredential(credential);
        try{
          var url = Uri.parse('${ApiConfig.baseUrl}$auth/${'google'}');
          var headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          };


          var response = await http.post(
              url,
              headers: headers,
              body: jsonEncode(user)
          );


          print(utf8.decode(response.bodyBytes));

          return jsonDecode(utf8.decode(response.bodyBytes));
        }catch(e){
          print(e);
          return {
            "status": 'EXCEPTION',
            "message": 'Une erreur est survenue lors de la connexion.'
          };
        }


      }


    } catch (e) {
      print(e);
      return {
        "status": 'EXCEPTION',
        "message": 'Une erreur est survenue lors de la connexion.'
      };
    }
  }

  static Future<void> signOutUser() async {
    // Déconnexion de Firebase
    await FirebaseAuth.instance.signOut();

    // Déconnexion de Google
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
    }
  }


  static Future setUserProfile(profile) async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$auth/set-user-profile/$profile');
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
  static Future editUserProfile(data) async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$auth/edit-profile');
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
  static Future getConnectedUser() async{

    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$auth/get-connected-user');
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

  static Future editPasswordController(data) async{
    try{
      var url = Uri.parse('${ApiConfig.baseUrl}$auth/edit-password');
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
