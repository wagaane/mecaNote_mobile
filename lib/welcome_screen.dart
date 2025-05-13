import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:meca_note_mobile/auth/login_screen.dart';
import 'package:meca_note_mobile/auth/register_screen.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollTimer();
  }

  void _scrollTimer() async {
    Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;
        double nextScroll = currentScroll + 5;

        if (nextScroll >= maxScroll) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            nextScroll,
            duration: const Duration(milliseconds: 90),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  final List _services = [
    {
      'id': 1,
      'label': 'Mécanicien automobile généraliste',
      'code': 'MEC_GEN',
      'nomberOfClients': '10',
      'img': 'assets/mechanic.png'
    },
    {
      'id': 2,
      'label': 'Mécanicien motoriste',
      'code': 'MEC_MOT',
      'nomberOfClients': '10',
      'img': 'assets/motor.png'
    },
    {
      'id': 3,
      'label': 'Électricien automobile',
      'code': 'MEC_ELEC',
      'nomberOfClients': '10',
      'img': 'assets/electricity.png'
    },
    {
      'id': 3,
      'label': 'Spécialiste climatisation',
      'code': 'MEC_CLIM',
      'nomberOfClients': '10',
      'img': 'assets/ac.png'
    },
    {
      'id': 3,
      'label': 'Monteur de pneus / technicien pneumatique',
      'code': 'MEC_PNEU',
      'nomberOfClients': '10',
      'img': 'assets/tire.png'
    },
    {
      'id': 3,
      'label': 'Carrossier',
      'code': 'MEC_CARR',
      'nomberOfClients': '10',
      'img': 'assets/sander.png'
    },
    {
      'id': 3,
      'label': 'Peintre automobile',
      'code': 'MEC_PEINTRE',
      'nomberOfClients': '10',
      'img': 'assets/spray-gun.png'
    },
    {
      'id': 3,
      'label': 'Technicien en transmission',
      'code': 'MEC_TRANS',
      'nomberOfClients': '10',
      'img': 'assets/transmission.png'
    },
    {
      'id': 3,
      'label': 'Spécialiste suspension et direction',
      'code': 'MEC_SUS_DIR',
      'nomberOfClients': '10',
      'img': 'assets/shock-absorber.png'
    },
    {
      'id': 3,
      'label': 'Diagnosticien automobile',
      'code': 'MEC_DIAG',
      'nomberOfClients': '10',
      'img': 'assets/diagnostic-tool.png'
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mecano.jpg'),
            opacity: 0.9,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                padding: const EdgeInsets.only(bottom: 10),
                // width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white.withOpacity(0.2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 200,
                    ),

                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text("Mécano ou en quête du meilleur ? Vous êtes au bon endroit.",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),),
                ),
              ),

              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _services.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 100,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.orange, width: 0.3),
                           color: Colors.black.withOpacity(0.7),
                           borderRadius: const BorderRadius.all(Radius.circular(10))
                         ),
                        child: Center(
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset( _services[index]['img'], color: Colors.orange,),
                              SizedBox(
                                width: 150,
                                child: AutoSizeText(
                                  _services[index]['label'],
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: ColorWidget.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 100,),
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
                  margin: const EdgeInsets.symmetric(horizontal: 70),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.5)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: ColorWidget.orange),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Se connecter",
                          style: TextStyle(
                              color: ColorWidget.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.login_rounded,
                        color: ColorWidget.white,
                        size: 25,
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pas de compte ?", style: TextStyle(
                      color: ColorWidget.white,
                      fontSize: 15,),),
                  const SizedBox(width: 15,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text('Sinscrire', style: TextStyle(
                        color: ColorWidget.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
