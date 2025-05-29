import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/client/dashboard_client_screen.dart';
import 'package:meca_note_mobile/config/api_config.dart';
import 'package:meca_note_mobile/services/auth_service.dart';
import 'package:meca_note_mobile/utils/notification_helper.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mecanicien/dashboard_mecano_screen.dart';
class UnknowUserScreen extends StatefulWidget {
  const UnknowUserScreen({super.key});

  @override
  State<UnknowUserScreen> createState() => _UnknowUserScreenState();
}

class _UnknowUserScreenState extends State<UnknowUserScreen> {
  List<String> profiles = ["MECANO", "CLIENT"];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/logo.png'),
              const Text("Quel est votre profil ?", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
              const SizedBox(height: 50,),
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                 await pref.setString("role", profiles[1]);
                  var response =  await AuthService.setUserProfile(profiles[1]);
                  print(response);
                  if(response['status'] == 'OK'){

                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                        const DashboardClientScreen(),
                      ),
                    );
                    NotificationHelper.success(context, response['message']);

                  }else{
                    NotificationHelper.error(context, response['message']);
                  }

                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 60,
                  decoration: BoxDecoration(color: ColorWidget.blue, borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: const Center(child: Text("CLIENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                ),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  await pref.setString("role", profiles[0]);
                  var role = await ApiConfig.getRole();
                  print('uuuuuuuuuuuuuu');
                  print(role);
                  var response =  await AuthService.setUserProfile(profiles[0]);
                  if(response['status'] == 'OK'){

                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                        const DashboardMecanoScreen(),
                      ),
                    );
                    NotificationHelper.success(context, response['message']);

                  }else{
                    NotificationHelper.error(context, response['message']);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 60,
                  decoration: BoxDecoration(color: ColorWidget.blue, borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: const Center(child: Text("MECANO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
