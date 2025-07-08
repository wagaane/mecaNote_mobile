import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/go_back_widget.dart';
import 'package:meca_note_mobile/widgets/padding_widget.dart';
import 'package:meca_note_mobile/widgets/title_widget.dart';

import '../../widgets/color_widget.dart';
class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _prenomController = TextEditingController();
  final _nomController = TextEditingController();
  final _adresseController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  _initData(){
    setState(() {
      _prenomController.text = "Ablaye";
      _nomController.text = "Faye";
      _adresseController.text = "Dakar/Mariste";
      _telephoneController.text = "221707687048";
      _emailController.text = "ablayefaye9725@gmail.com";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        title: TitleWidget.setTitle("Modifier mon profil"),
        leading: MyButtonWidget.goBack(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                children: [
                  Text("Les champs avec '*' sont obligatoires", style: TextStyle(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w600),),
                ],
              ),
              const SizedBox(height: 30,),
              TextField(
                controller: _prenomController,
                decoration: InputDecoration(
                  labelText: 'Prénom *',
                  labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder( // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder( // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder( // When focused (clicked)
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: ColorWidget.blue!.withOpacity(0.4), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: _nomController,
                decoration: InputDecoration(

                  labelText: 'Nom *',
                  labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder( // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder( // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder( // When focused (clicked)
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: ColorWidget.blue!.withOpacity(0.4), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: _adresseController,
                decoration: InputDecoration(
                  labelText: 'Adresse *',
                  labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder( // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder( // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder( // When focused (clicked)
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: ColorWidget.blue!.withOpacity(0.4), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: _emailController,

                decoration: InputDecoration(
                  enabled: false,
                  labelText: 'E-mail',
                  labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder( // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder( // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder( // When focused (clicked)
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: ColorWidget.blue!.withOpacity(0.4), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: PaddingWidget.padding10,
                decoration: BoxDecoration(
                  color: ColorWidget.blue,
                  borderRadius: BorderRadiusWidget.borderRadius10()
                ),
                child: const Center(
                  child: Text("Enregistrer", style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
