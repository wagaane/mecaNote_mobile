import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/profil/configuration/edit_mot_de_passe_screen.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';

import '../../../widgets/go_back_widget.dart';
import '../../../widgets/title_widget.dart';
class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),

      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        title: TitleWidget.setTitle("Configuration"),
        leading: GoBackWidget.goBack(context),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white
                    ),
                    child:  ListTile(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const EditMotDePasseScreen(),
                          ),
                        );
                      },
                      title: Text("Mot de passe"),
                      leading: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                            color: ColorWidget.blue?.withOpacity(0.1)),
                        child: const Icon(Icons.lock_outline),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),

                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: const Divider(color: Colors.black12,),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white
                    ),
                    child:  ListTile(
                      title: Text("Notification"),
                      leading: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                            color: ColorWidget.blue?.withOpacity(0.1)),
                        child: const Icon(Icons.notifications_outlined),
                      ),
                      trailing: Icon(Icons.toll),
                    ),
                  ),
                  const SizedBox(height: 20,),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
