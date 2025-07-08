import 'package:flutter/material.dart';

import '../../../widgets/border_radius_widget.dart';
import '../../../widgets/color_widget.dart';
import '../../../widgets/go_back_widget.dart';
import '../../../widgets/padding_widget.dart';
import '../../../widgets/title_widget.dart';

class EditMotDePasseScreen extends StatefulWidget {
  const EditMotDePasseScreen({super.key});

  @override
  State<EditMotDePasseScreen> createState() => _EditMotDePasseScreenState();
}

class _EditMotDePasseScreenState extends State<EditMotDePasseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        title: TitleWidget.setTitle("Modifier mot de passe"),
        leading: MyButtonWidget.goBack(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Les champs avec '*' sont obligatoires",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                // controller: _prenomController,
                decoration: InputDecoration(
                  labelText: 'Ancien mot de passe *',
                  labelStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder(
                    // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black54),
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
              TextField(
                // controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nouveau mot de passe *',
                  labelStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder(
                    // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black54),
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
              TextField(
                // controller: _adresseController,
                decoration: InputDecoration(
                  labelText: 'Confirmation *',
                  labelStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder(
                    // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // When focused (clicked)
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: ColorWidget.blue!.withOpacity(0.4), width: 2),
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
