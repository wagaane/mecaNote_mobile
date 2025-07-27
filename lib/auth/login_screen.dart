import 'package:flutter/material.dart';
import 'package:meca_note_mobile/auth/register_screen.dart';
import 'package:meca_note_mobile/state-manager/auth_provider.dart';
import 'package:meca_note_mobile/utils/utilis.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';
import 'package:provider/provider.dart';
import '../welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,
       leading:  GestureDetector(
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
      ),
      body: _loading ? Utils.loading() : SingleChildScrollView(
          child: SizedBox(
              child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 200,
            ),
            const Text(
              "Un problème avec votre voiture ? Connectez-vous et trouvez de l’aide.",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(
              height: 15,
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
                  icon:
                      Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                ),
                // labelText: 'Nom Garage',
                hintText: "Mot de passe",
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
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  _loading = true;
                });
                var data = {"login":_email.text,"password":_password.text};
                await provider.login(data, context);
                setState(() {
                  _loading = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusWidget.borderRadius05(),
                    color: ColorWidget.blue),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      "Se connecter",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const RegisterScreen(),
                  ),
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusWidget.borderRadius05(),
                      border: Border.all(color: ColorWidget.blue!, width: 0.2)),
                  child: Center(
                      child: Text(
                    "Vous n'avez pas de compte ? Inscriver vous.",
                    style: TextStyle(
                        fontSize: 12, color: Colors.black.withOpacity(0.6)),
                  ))),
            )
          ],
        ),
      ))),
    );
  }
}
