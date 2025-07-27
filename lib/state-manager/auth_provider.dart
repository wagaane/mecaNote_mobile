import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meca_note_mobile/services/auth_service.dart';

import '../auth/valider_register_screen.dart';
import '../back-office/client/home_client_screen.dart';
import '../back-office/mecanicien/home_mecano_screen.dart';
import '../config/api_config.dart';
import '../utils/notification_helper.dart';

class AuthProvider extends ChangeNotifier {

  /**
   * CONNEXION
   */
  Future<void> login(data, context) async{
    try{
      var response  = await AuthService.login(data);
      if(response['data']['status'] == 'OK'){
        await ApiConfig.setData(response);
        NotificationHelper.success(context, 'Connexion réussie.');
        if(response['data']['payload']['role'] == 'CHEFMECANO'){
          //   go to mecano
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeMecanoScreen(),
            ),
          );
        }else{
          //   got to client
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeClientScreen(),
            ),
          );
        }
      }else{
        NotificationHelper.error(context, 'Login et/ou mot de passe incorrecte..');
      }
    }catch(e){
      NotificationHelper.error(context, e.toString());
    }
  }


  /**
   * INSCRIPTION
   */
  Future<void> register(data, context)async{
    try{
      var response = await AuthService.register(data);
      var isOk = (response['data']['status'] == 'OK');
      if (isOk) {
        NotificationHelper.success(
            context, response['data']['message']);
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>  ValiderRegisterScreen(email: data['email'],),
          ),
        );

      } else {
        NotificationHelper.error(
            context, response['data']['message']);
      }
    }catch(e){
      NotificationHelper.error(
          context, e.toString());
    }
  }
}
