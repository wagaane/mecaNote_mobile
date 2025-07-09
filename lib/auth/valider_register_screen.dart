import 'package:flutter/material.dart';
import 'package:meca_note_mobile/auth/login_screen.dart';
import 'package:meca_note_mobile/services/auth_service.dart';
import 'package:meca_note_mobile/utils/notification_helper.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';

import '../welcome_screen.dart';

class ValiderRegisterScreen extends StatefulWidget {
  final email;
  const ValiderRegisterScreen({super.key, this.email});

  @override
  State<ValiderRegisterScreen> createState() => _ValiderRegisterScreenState();
}

class _ValiderRegisterScreenState extends State<ValiderRegisterScreen> {
  String _code = "     ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text("Renseigner code OTP", style: TextStyle(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 18),),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorWidget.blue!.withOpacity(0.5)),
                      borderRadius: BorderRadiusWidget.borderRadius10()),
                  child: Text(
                    _code[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorWidget.blue!.withOpacity(0.5)),
                      borderRadius: BorderRadiusWidget.borderRadius10()),
                  child: Text(
                    _code[1],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorWidget.blue!.withOpacity(0.5)),
                      borderRadius: BorderRadiusWidget.borderRadius10()),
                  child: Text(
                    _code[2],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorWidget.blue!.withOpacity(0.5)),
                      borderRadius: BorderRadiusWidget.borderRadius10()),
                  child: Text(
                    _code[3],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ColorWidget.blue!.withOpacity(0.5)),
                      borderRadius: BorderRadiusWidget.borderRadius10()),
                  child: Text(
                    _code[4],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(context, '1'),
                button(context, '2'),
                button(context, '3'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(context, '4'),
                button(context, '5'),
                button(context, '6'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(context, '7'),
                button(context, '8'),
                button(context, '9'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    if(_code.split('').last != ' '){
                      // verification code OTP
                      var response = await AuthService.validerOtp({'email':widget.email,'otp':_code.trim()});
                      print('$response');
                      if(response['status'] == 'OK'){
                        NotificationHelper.success(context, response['message']);
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const LoginScreen(),
                          ),
                        );
                      }else{
                        NotificationHelper.error(context, response['message']);
                      }
                    }else{
                      NotificationHelper.error(context, "Code invalide");
                    }
                    print('$_code');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2.5),
                    width: MediaQuery.of(context).size.width / 3 - 5,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 10),
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                        border: Border.all(
                            color: ColorWidget.blue!.withOpacity(0.2)),
                        borderRadius: BorderRadiusWidget.borderRadius10()),
                    child:  const Center(
                        child: Icon(Icons.check_outlined, size: 30, color: Colors.white,)),
                  ),
                ),
                button(context,'0'),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _code = remplacerDernierCaractereNonEspace(_code, ' ');
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2.5),
                    width: MediaQuery.of(context).size.width / 3 - 5,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 10, top: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorWidget.blue!.withOpacity(0.2)),
                        borderRadius: BorderRadiusWidget.borderRadius10()),
                    child:  const Center(
                        child: Icon(Icons.backspace_outlined, size: 30, color: Colors.red,)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector button(BuildContext context, number) {
    return GestureDetector(
                onTap: () {

                  _setCode(number.toString());
                },
                child: Container(
                  margin: const EdgeInsets.all(2.5),
                  width: MediaQuery.of(context).size.width / 3 - 5,
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 10, top: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorWidget.blue!.withOpacity(0.2)),
                      borderRadius: BorderRadiusWidget.borderRadius10()),
                  child:  Center(
                      child: Text(
                        number.toString(),
                    style:
                        const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  )),
                ),
              );
  }

  void _setCode(String value) {
    var index = _code.indexOf(" ");
    if (index == -1) {
      NotificationHelper.error(context, "champ déja rempli.");
    } else {
      var code = _code.split('');
      code[index] = value;
      setState(() {
        _code = code.join('');
      });
    }

  }

  String remplacerDernierCaractereNonEspace(String input, String replacement) {
    for (int i = input.length - 1; i >= 0; i--) {
      if (input[i] != ' ') {
        return input.substring(0, i) + replacement + input.substring(i + 1);
      }
    }
    return input; // aucun caractère à remplacer
  }
}
