import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/client/dashboard_client_screen.dart';
import 'package:meca_note_mobile/back-office/mecanicien/dashboard_mecano_screen.dart';
import 'package:meca_note_mobile/back-office/unknow_user_screen.dart';
import 'package:meca_note_mobile/config/api_config.dart';
import 'package:meca_note_mobile/services/auth_service.dart';
import 'package:meca_note_mobile/utils/notification_helper.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';

import '../services/push_notification_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _login = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 2 - 100,
                    child: Image.asset(
                      width: 100,
                      "assets/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 80),
                      // height: MediaQuery.of(context).size.height/2+100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                          ),
                          color: Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          children: [
                            TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    color: ColorWidget.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                controller: _login,
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelStyle:
                                      TextStyle(color: ColorWidget.white),
                                  hintStyle:
                                      TextStyle(color: ColorWidget.white),
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: ColorWidget.white,
                                  ),
                                  hintText: "Email",
                                  labelText: "Email",
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              obscureText: _obscureText,
                              style: TextStyle(
                                  color: ColorWidget.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              controller: _password,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    )),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelStyle: TextStyle(color: ColorWidget.white),
                                hintStyle: TextStyle(color: ColorWidget.white),
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: ColorWidget.white,
                                ),
                                hintText: "Mot de passe",
                                labelText: "Mot de passe",
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_loading) {
                                  NotificationHelper.success(context,
                                      "Tantative de connexion en cours.");
                                } else {
                                  setState(() {
                                    _loading = true;
                                  });
                                  var response = await AuthService.login({
                                    "login": _login.text.trim(),
                                    "password": _password.text.trim()
                                  });
                                  print(response);
                                  if (response['data']['status'] == 'OK') {
                                    await ApiConfig.setData(response);
                                    var res = await PushNotificationService
                                        .updateDeviceToken(
                                            await PushNotificationService
                                                .getDeviceToken());
                                    print(res);
                                    NotificationHelper.success(
                                        context, response['data']['message']);

                                    setState(() {
                                      _loading = false;
                                    });
                                    var username =
                                        await ApiConfig.getUsername();
                                    if (username == 'MECANO') {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const DashboardMecanoScreen(),
                                        ),
                                      );
                                    } else {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const DashboardClientScreen(),
                                        ),
                                      );
                                    }
                                  } else {
                                    setState(() {
                                      _loading = false;
                                    });
                                    NotificationHelper.error(
                                        context, response['data']['message']);
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width - 10,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Colors.blueAccent.withOpacity(0.5)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    color: _loading
                                        ? ColorWidget.blue?.withOpacity(0.5)
                                        : ColorWidget.blue),
                                child: const Center(
                                  child: Text(
                                    "se connecter",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "ou se connecter avec",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var response =
                                        await AuthService.signInWithGoogle();
                                    print(response);
                                    if (response['status'] == 'OK') {
                                      await ApiConfig.setDataSignWithGoogle(
                                          response);
                                      await PushNotificationService
                                          .updateDeviceToken(
                                              await PushNotificationService
                                                  .getDeviceToken());
                                      NotificationHelper.success(
                                          context, response['message']);

                                      setState(() {
                                        _loading = false;
                                      });
                                      var role = await ApiConfig.getRole();
                                      if (role == 'UNKNOW') {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const UnknowUserScreen(),
                                          ),
                                        );
                                      } else {
                                        if (role == 'MECANO') {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  const DashboardMecanoScreen(),
                                            ),
                                          );
                                        } else {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  const DashboardClientScreen(),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/icons/google.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Image.asset(
                                      'assets/icons/facebook.png',
                                      fit: BoxFit.contain,
                                      color: ColorWidget.blue,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
