import 'package:flutter/material.dart';
import 'package:meca_note_mobile/models/profil_model.dart';
import 'package:meca_note_mobile/services/auth_service.dart';
import 'package:meca_note_mobile/services/push_notification_service.dart';
import 'package:meca_note_mobile/services/reference_service.dart';
import 'package:meca_note_mobile/utils/geolocation_helper.dart';
import 'package:meca_note_mobile/utils/notification_helper.dart';

import '../widgets/color_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _prenom = TextEditingController();
  final _nom = TextEditingController();
  final _adresse = TextEditingController();
  final _telephone = TextEditingController();
  bool _obscureText = true;
  Map<String, bool> selectedSpecialities = {};
  String? _selectedProfil;
  String locationMessage = "Position inconnue";
  late double _latitude;
  late double _longitude;
  List<ProfilModel> _profiles = [];

  _getListProfiles() async {
    var profiles = ProfilModel.fromList(
        (await ReferenceService.listProfiles())['payload']);
    setState(() {
      _profiles = profiles;
    });
  }

  Future<void> _determinePosition() async {
    var position = await GeolocationHelper.determinePosition();
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _getListProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 3),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.orange,
              ],
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.cover,
                  width: 200,
                ),
                TextField(
                  controller: _prenom,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelStyle: TextStyle(color: ColorWidget.white),
                      hintStyle: TextStyle(color: ColorWidget.white),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: ColorWidget.white,
                      ),
                      hintText: "Prénom",
                      labelText: "Prénom",
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _nom,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelStyle: TextStyle(color: ColorWidget.white),
                      hintStyle: TextStyle(color: ColorWidget.white),
                      prefixIcon:
                          Icon(Icons.person_outline, color: ColorWidget.white),
                      hintText: "Nom",
                      labelText: "Nom",
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _adresse,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelStyle: TextStyle(color: ColorWidget.white),
                      hintStyle: TextStyle(color: ColorWidget.white),
                      prefixIcon: Icon(Icons.location_on_outlined,
                          color: ColorWidget.white),
                      hintText: "Adresse",
                      labelText: "Adresse",
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _telephone,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelStyle: TextStyle(color: ColorWidget.white),
                      hintStyle: TextStyle(color: ColorWidget.white),
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: ColorWidget.white,
                      ),
                      hintText: "Téléphone",
                      labelText: "Téléphone",
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<dynamic>(
                  dropdownColor: Colors.blue.withOpacity(0.3),
                  style: TextStyle(
                      color: ColorWidget.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: ColorWidget.white),
                    hintStyle: TextStyle(color: ColorWidget.white),
                    prefixIcon:
                        Icon(Icons.work_outline, color: ColorWidget.white),
                    labelText: 'S\'inscrire en tant que ',
                    border: const OutlineInputBorder(),
                  ),
                  value: _selectedProfil,
                  items: _profiles.map((ProfilModel value) {
                    return DropdownMenuItem<dynamic>(
                      value: value.code,
                      child: Text(value.label),
                    );
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      print(newValue);
                      _selectedProfil = newValue;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelStyle: TextStyle(color: ColorWidget.white),
                      hintStyle: TextStyle(color: ColorWidget.white),
                      prefixIcon:
                          Icon(Icons.person_outline, color: ColorWidget.white),
                      hintText: "Email",
                      labelText: "Email",
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: _obscureText,
                  controller: _password,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
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
                          )),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelStyle: TextStyle(color: ColorWidget.white),
                      hintStyle: TextStyle(color: ColorWidget.white),
                      prefixIcon:
                          Icon(Icons.password, color: ColorWidget.white),
                      hintText: "Mot de passe",
                      labelText: "Mot de passe",
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    List<String> newSelectedSpecialities = [];
                    selectedSpecialities.forEach(
                      (key, value) {
                        newSelectedSpecialities.add(key);
                      },
                    );
                    var data = {
                      'prenom': _prenom.text.trim(),
                      'nom': _nom.text.trim(),
                      'adresse': _adresse.text.trim(),
                      'telephone': _telephone.text.trim(),
                      'email': _email.text.trim(),
                      'password': _password.text.trim(),
                      'profile': _selectedProfil ?? '',
                      'latitude': _latitude.toString(),
                      'longitude': _longitude.toString(),
                      'token': ''
                    };

                    var response = await AuthService.register(data);
                    print(response);
                    if (response['data']['status'] == 'OK') {
                      var token = await PushNotificationService.getDeviceToken();
                      PushNotificationService.sendOtp(token);
                      NotificationHelper.success(
                          context, response['data']['message']);
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const LoginScreen(),
                        ),
                      );
                    } else {
                      NotificationHelper.error(
                          context, response['data']['message']);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.5)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: ColorWidget.blue),
                    child: Center(
                      child: Text(
                        "s'inscrire",
                        style: TextStyle(
                            color: ColorWidget.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginScreen(),
                      ),
                    );

                    // request to API
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.5)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: ColorWidget.blackWithOpacityO5),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vous avez déjà un compte ? ",
                            style: TextStyle(
                                color: Colors.orange[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "se connecter",
                            style: TextStyle(
                                color: ColorWidget.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
