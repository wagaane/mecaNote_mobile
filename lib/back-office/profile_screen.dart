import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/profil/condition_utilisation_screen.dart';
import 'package:meca_note_mobile/back-office/profil/configuration/configuration_screen.dart';
import 'package:meca_note_mobile/back-office/profil/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';
import '../utils/notification_helper.dart';
import '../welcome_screen.dart';
import '../widgets/border_radius_widget.dart';
import '../widgets/color_widget.dart';
import '../widgets/padding_widget.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var W = MediaQuery.of(context).size.width;
    var H = MediaQuery.of(context).size.height;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: H / 7,
        ),
        Center(
          child: Column(
            children: [
              Container(
                width: W / 5,
                height: W / 5,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusWidget.borderRadius100()),
                child: Image.asset(
                  "assets/user.png",
                  width: 50,
                ),
              ),
              Text(
                "Ablaye Faye",
                style: TextStyle(
                    color: ColorWidget.blue, fontWeight: FontWeight.w600),
              ),
              const Text("ablayefaye9725@gmail.com"),
              const Text("221778545382"),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: W - 50,
          // height: H - 100,
          decoration: BoxDecoration(
            // color: Colors.white,
              borderRadius: BorderRadiusWidget.borderRadius10()),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
                child: ListTile(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                          const MyProfileScreen(),
                        ),
                      );
                    },
                    title: const Text("Mon profil"),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.person_outline,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                          const ConfigurationScreen(),
                        ),
                      );
                    },
                    title: const Text("Configuration"),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.settings_outlined,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                    title: const Text("Aide & Assistance"),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.help_outline,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                          const ConditionUtilisationScreen(),
                        ),
                      );
                    },
                    title: const Text("Condition d'utilisation"),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.info_outline,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                    title: const Text("Inviter un ami"),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.share_outlined,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
              const SizedBox(
                height: 1,
              ),
              GestureDetector(
                onTap: () async {
                  SharedPreferences _pref = await SharedPreferences.getInstance();
                  _pref.clear();
                  await AuthService.signOutUser();
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const WelcomeScreen(),
                    ),
                  );
                  // @
                  NotificationHelper.success(
                      context, "Déconnexion éffectuée avec succès.");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: ListTile(
                      title: const Text(
                        "Se déconnecter",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Container(
                        padding: PaddingWidget.padding5,
                        decoration: BoxDecoration(
                            color: ColorWidget.blackWithOpacityO1,
                            borderRadius: BorderRadiusWidget.borderRadius100()),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: ColorWidget.blue,
                          size: 20,
                        ),
                      ),
                      leading: Container(
                        padding: PaddingWidget.padding5,
                        decoration: BoxDecoration(
                            color: ColorWidget.blackWithOpacityO1,
                            borderRadius: BorderRadiusWidget.borderRadius100()),
                        child: Icon(
                          Icons.logout,
                          color: ColorWidget.blue,
                          size: 20,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
