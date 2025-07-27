import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meca_note_mobile/auth/valider_register_screen.dart';
import 'package:meca_note_mobile/services/auth_service.dart';
import 'package:meca_note_mobile/services/push_notification_service.dart';
import 'package:meca_note_mobile/state-manager/auth_provider.dart';
import 'package:meca_note_mobile/utils/geolocation_helper.dart';
import 'package:meca_note_mobile/utils/notification_helper.dart';
import 'package:meca_note_mobile/utils/utilis.dart';
import 'package:meca_note_mobile/welcome_screen.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:provider/provider.dart';

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
  final _descriptionGarage = TextEditingController();
  final _telephone = TextEditingController();
  final _nomGarage = TextEditingController();
  String locationMessage = "Position inconnue";
  late double _latitude;
  late double _longitude;
  bool _loading = false;

  Future<void> _determinePosition() async {
    var position = await GeolocationHelper.determinePosition();
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
    print('latitude: $_latitude; longitude: $_longitude');
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusWidget.borderRadius100(),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      color: ColorWidget.blue,
                      borderRadius: BorderRadiusWidget.borderRadius100()),
                  child: Center(
                      child: Text(
                    "$_page / 4",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                  )),
                ),
              ),
            ],
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const WelcomeScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: ColorWidget.blue?.withOpacity(0.1)),
              child: const Icon(Icons.home_outlined),
            ),
          ),
          elevation: 0.0,
        ),
        body: _loading ? Utils.loading() : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo.png",
                  width: MediaQuery.of(context).size.height / 5,
                ),
                Text(
                  _titrePage,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                _renderedPage(_page),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('Prev');
                        if (_page > 1) {
                          setState(() {
                            _page = _page - 1;
                          });
                          changeTitle();
                        }
                      },
                      child: _buttonPrec(),
                    ),
                    _page == 4
                        ? GestureDetector(
                            onTap: () async {

                              setState(() {
                                _loading = true;
                              });
                              // DONNÉE D'INSCRIPTION
                              var data = {
                                "prenom": _prenom.text,
                                "nom": _nom.text,
                                "telephone": _telephone.text,
                                "email": _email.text,
                                'password': _password.text,
                                'profile': _isActifG ? "CHEFMECANO" : "CLIENT",
                                'token': await PushNotificationService
                                    .getDeviceToken(),
                                'nomGarage': _nomGarage.text,
                                'descriptionGarage': _descriptionGarage.text,
                                'latitude': _latitude.toString(),
                                'longitude': _longitude.toString()
                              };

                              // INSCRIPTION
                              await provider.register(data,context);


                              setState(() {
                                _loading = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              // width: 80,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusWidget.borderRadius10(),
                                color: ColorWidget.blue,
                              ),
                              child: const Center(
                                  child: Text(
                                "S'inscrire",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              )),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              print('$_isActifC $_isActifG');
                              print('Suiv');
                              if (_page < 4) {
                                if (_page == 1 && !_isActifG && !_isActifC) {
                                  NotificationHelper.error(
                                      context, "Veuillez choisir un profil");
                                } else {
                                  if (_page == 2) {
                                    if ((_nomGarage.text == '' && _isActifG) ||
                                        _prenom.text == '' ||
                                        _nom.text == '' ) {
                                      NotificationHelper.error(context,
                                          "Veuillez renseigner tous les champs svp.");

                                    }else{
                                    // aa@yopmail.com
                                    setState(() {
                                      _page = _page + 1;
                                    });
                                    changeTitle();

                                    }
                                  }else if(_page == 3){
                                    if ((_nomGarage.text == '' && _isActifG) ||
                                        _email.text == '' ||
                                        _telephone.text == '' ||
                                        _password.text == '') {
                                      NotificationHelper.error(context,
                                          "Veuillez renseigner tous les champs svp.");
                                    } else {
                                      final emailRegex =
                                      RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                      if (!emailRegex.hasMatch(_email.text)) {
                                        NotificationHelper.success(context,
                                            "Saisissez un mail valide.");
                                      } else {
                                        setState(() {
                                          _page = _page + 1;
                                        });
                                        changeTitle();
                                      }
                                    }

                                  } else {
                                    setState(() {
                                      _page = _page + 1;
                                    });
                                    changeTitle();
                                  }
                                }
                              }
                            },
                            child: _buttonSuiv(),
                          )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusWidget.borderRadius05(),
                          border:
                              Border.all(color: ColorWidget.blue!, width: 0.2)),
                      child: Center(
                          child: Text(
                        "Vous avez déjà un compte ? Connectez-vous.",
                        style: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.6)),
                      ))),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ));
  }

  void changeTitle() {
    switch (_page) {
      case 1:
        setState(() {
          _titrePage = 'Quel est votre profil ?';
        });
        break;
      case 2:
        setState(() {
          _titrePage = 'Renseigner les informations';
        });
        break;
        case 3:
        setState(() {
          _titrePage = 'Renseigner les informations';
        });
        break;
      case 4:
        setState(() {
          _titrePage = 'Récapitulation';
        });
        break;
    }
  }

  int _page = 1;
  String _titrePage = "Quel est votre profil ?";
  bool _obscure = true;

  Widget _renderedPage(page) {
    switch (page) {
      case 1:
        return _page_1();
      case 2:
        return _page_2();
        case 3:
        return _page_4();
      case 4:
        return _page_3();
      default:
        return const SizedBox.shrink();
    }
  }

  Column _page_3() {
    return Column(
      children: [
        _isActifG
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Nom Garage "),
                  Text(_nomGarage.text),
                ],
              )
            : const SizedBox.shrink(),
        _isActifG
            ? const SizedBox(
                height: 10,
              )
            : const SizedBox.shrink(),
        _isActifG
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              )
            : const SizedBox.shrink(),
        _isActifG
            ? const SizedBox(
                height: 10,
              )
            : const SizedBox.shrink(),
        _isActifG
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Description Garage "),
                  Text(_descriptionGarage.text),
                ],
              )
            : const SizedBox.shrink(),
        _isActifG
            ? const SizedBox(
                height: 10,
              )
            : const SizedBox.shrink(),
        _isActifG
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              )
            : const SizedBox.shrink(),
        _isActifG
            ? const SizedBox(
                height: 10,
              )
            : const SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Prénom "),
            Text(_prenom.text),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Nom "),
            Text(_nom.text),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Téléphone"),
            Text(_telephone.text),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("E-mail "),
            Text(_email.text),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Mot de passe "),
            Text("********"),
          ],
        ),
      ],
    );
  }

  Column _page_2() {
    return Column(
      children: [
        _isActifG
            ? TextField(
                controller: _nomGarage,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.garage_outlined,
                    color: ColorWidget.blue,
                  ),
                  hintText: "Nom garage",
                  hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w100),
                  border: OutlineInputBorder(
                    // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: ColorWidget.blue!.withOpacity(0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // When focused (clicked)
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: ColorWidget.blue!.withOpacity(0.4), width: 2),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        _isActifG
            ? const SizedBox(
                height: 5,
              )
            : const SizedBox.shrink(),
        _isActifG
            ? TextField(
                controller: _descriptionGarage,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.garage_outlined,
                    color: ColorWidget.blue,
                  ),
                  hintText: "Description Garage",
                  hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w100),
                  border: OutlineInputBorder(
                    // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: ColorWidget.blue!.withOpacity(0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // When focused (clicked)
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: ColorWidget.blue!.withOpacity(0.4), width: 2),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        _isActifG
            ? const SizedBox(
                height: 5,
              )
            : const SizedBox.shrink(),
        TextField(
          controller: _prenom,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.contact_page_outlined,
              color: ColorWidget.blue,
            ),
            hintText: "Prénom",
            hintStyle: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w100),
            border: OutlineInputBorder(
              // Default border
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              // When not focused
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorWidget.blue!.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              // When focused (clicked)
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: ColorWidget.blue!.withOpacity(0.4), width: 2),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: _nom,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.contact_page_outlined,
              color: ColorWidget.blue,
            ),
            hintText: "Nom",
            hintStyle: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w100),
            border: OutlineInputBorder(
              // Default border
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              // When not focused
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorWidget.blue!.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              // When focused (clicked)
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: ColorWidget.blue!.withOpacity(0.4), width: 2),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
  Column _page_4() {
    return Column(
      children: [
        TextField(
          controller: _telephone,
          inputFormatters: [
            // Optional: block non-digit input
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (_telephone.text.length >= 9) {
              _telephone.text = _telephone.text.substring(0, 9);
              NotificationHelper.success(context,
                  "Numéro de téléphone ne doit pas dépasser 9 caractères.");
            }
          },
          decoration: InputDecoration(
            prefixIcon: SizedBox(
              width: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      "+221",
                      style: TextStyle(
                          color: ColorWidget.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
            hintText: "Téléphone",
            hintStyle: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w100),
            border: OutlineInputBorder(
              // Default border
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              // When not focused
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorWidget.blue!.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              // When focused (clicked)
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: ColorWidget.blue!.withOpacity(0.4), width: 2),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: _email,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email_outlined,
              color: ColorWidget.blue,
            ),
            hintText: "E-mail",
            hintStyle: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w100),
            border: OutlineInputBorder(
              // Default border
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              // When not focused
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorWidget.blue!.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              // When focused (clicked)
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: ColorWidget.blue!.withOpacity(0.4), width: 2),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: _password,
          obscureText: _obscure,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock_outline,
              color: ColorWidget.blue,
            ),

            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscure = !_obscure;
                });
              },
            ),
            // labelText: 'Nom Garage',
            hintText: "Mot de passe",
            hintStyle: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w100),
            border: OutlineInputBorder(
              // Default border
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              // When not focused
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorWidget.blue!.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              // When focused (clicked)
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: ColorWidget.blue!.withOpacity(0.4), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Center _page_1() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isActifG = !_isActifG;
                  _isActifC = false;
                });
              },
              child: buttonTypeProfil("Garagiste".toUpperCase(), _isActifG),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isActifG = false;
                  _isActifC = !_isActifC;
                });
              },
              child: buttonTypeProfil("Client".toUpperCase(), _isActifC),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  bool _isActifG = false;
  bool _isActifC = false;
  Container buttonTypeProfil(testButton, isActif) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: ColorWidget.blue!, width: 0.5),
          color: isActif
              ? ColorWidget.blue
              : ColorWidget.black12?.withOpacity(0.5),
          borderRadius: BorderRadiusWidget.borderRadius10()),
      child: Center(
          child: Text(
        "$testButton",
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
      )),
    );
  }

  ClipPath _buttonPrec() {
    return ClipPath(
      clipper: LeftArrowClipper(),
      child: Container(
        width: 80,
        height: 50,
        color: _page == 1 ? Colors.blue.withOpacity(0.6) : Colors.blue,
        alignment: Alignment.center,
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }

  ClipPath _buttonSuiv() {
    return ClipPath(
      clipper: ArrowClipper(),
      child: Container(
        width: 80,
        height: 50,
        color: Colors.blue,
        alignment: Alignment.center,
        child: const Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(w - h / 2, 0);
    path.lineTo(w, h / 2);
    path.lineTo(w - h / 2, h);
    path.lineTo(0, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LeftArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    final path = Path();
    path.moveTo(h / 2, 0); // pointe gauche en haut
    path.lineTo(w, 0); // coin droit haut
    path.lineTo(w, h); // coin droit bas
    path.lineTo(h / 2, h); // pointe gauche bas
    path.lineTo(0, h / 2); // triangle flèche vers la gauche
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
