import 'package:flutter/material.dart';
import 'package:meca_note_mobile/utils/utilis.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';
import 'package:meca_note_mobile/widgets/go_back_widget.dart';
import 'package:meca_note_mobile/widgets/title_widget.dart';

import '../../../widgets/border_radius_widget.dart';
import 'add_mecano_screen.dart';
class ListMecanosScreen extends StatefulWidget {
  const ListMecanosScreen({super.key});

  @override
  State<ListMecanosScreen> createState() => _ListMecanosScreenState();
}

class _ListMecanosScreenState extends State<ListMecanosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget.setTitle("Mes Mécanos"),
        backgroundColor: Colors.white.withValues(alpha: 0.0),
        leading: MyButtonWidget.goBack(context),
      ),
        backgroundColor: Colors.white.withValues(alpha: 0.9),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(color: Colors.white),
                  child:  ListTile(
                    leading: Utils.ProfilWidget(),
                    title: const Text("Ablaye Faye"),
                    trailing: Icon(Icons.arrow_forward_ios, color: ColorWidget.blue,),
                  ),
                );
              }, separatorBuilder: (context, index) {
                return const SizedBox(height: 1.0,);
              }, itemCount: 8),
            )
          ],
        ),
      ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => AddMecanoScreen(),
              ),
            );
          },
          child: Container(

            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusWidget.borderRadius100(),
                border: Border.all(color: Colors.orange, width: 0.2),
                color: ColorWidget.blue
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 30,),

          ),
        )
    );
  }
}
