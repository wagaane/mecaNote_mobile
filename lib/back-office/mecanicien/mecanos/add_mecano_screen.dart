import 'package:flutter/material.dart';
import 'package:meca_note_mobile/utils/notification_helper.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/button_widget.dart';
import 'package:meca_note_mobile/widgets/title_widget.dart';

import '../../../widgets/color_widget.dart';

class AddMecanoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      appBar: AppBar(
        title: TitleWidget.setTitle("Enregistrer Mécano"),
        backgroundColor: Colors.white.withValues(alpha: 0.9),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            decoration: BoxDecoration(
                border:
                    Border.all(color: ColorWidget.blue!.withValues(alpha: 0.1)),
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                color: ColorWidget.blue?.withOpacity(0.1)),
            child: const Icon(Icons.close_outlined),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline, color: ColorWidget.blue,),
                  labelText: 'Prénom',
                  labelStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder(
                    // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // When focused (clicked)
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: ColorWidget.blue!.withOpacity(0.4), width: 2),
                  ),
                ),
              ),const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline, color: ColorWidget.blue,),
                  labelText: 'Nom',
                  labelStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder(
                    // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // When focused (clicked)
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: ColorWidget.blue!.withOpacity(0.4), width: 2),
                  ),
                ),
              ),const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_outlined, color: ColorWidget.blue,),
                  labelText: 'Téléphone',
                  labelStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w100),
                  border: OutlineInputBorder(
                    // Default border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // When not focused
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // When focused (clicked)
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: ColorWidget.blue!.withOpacity(0.4), width: 2),
                  ),
                ),
              ),

              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  NotificationHelper.success(context, "Mécano enregistré avec succès.");
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorWidget.blue,
                    borderRadius: BorderRadiusWidget.borderRadius05()
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, color: Colors.white,),
                        Text("Enregistrer", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
