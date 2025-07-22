import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meca_note_mobile/services/garage_service.dart';
import 'package:meca_note_mobile/utils/geolocation_helper.dart';
import 'package:meca_note_mobile/utils/notification_helper.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/title_widget.dart';
import '../../../widgets/color_widget.dart';

class AddGarageScreen extends StatefulWidget {
  const AddGarageScreen({super.key});

  @override
  State<AddGarageScreen> createState() => _AddGarageScreenState();
}

class _AddGarageScreenState extends State<AddGarageScreen> {
  String _imageGarage = '';
  File ? _file;
  bool _isFileSelected = false;
  final _nom = TextEditingController();
  final _description = TextEditingController();
  late String _latitude;
  late String _longitude;
  bool _loading = true;
  final _formKey = GlobalKey<FormState>();


  _setCoordinates() async{
    var response =  await GeolocationHelper.determinePosition();
    setState(() {
      _latitude = response.latitude.toString();
      _longitude = response.longitude.toString();
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setCoordinates();
  }

  Future<File?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageGarage = pickedFile.name;
      });
      return File(pickedFile.path);
    } else {
      print("No image selected");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.9),
      appBar: AppBar(
        title: TitleWidget.setTitle("Créer Garage"),
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
      body: _loading ? Center(
        child: LoadingAnimationWidget.discreteCircle(secondRingColor: ColorWidget.white, size: 70, thirdRingColor: ColorWidget.blue!, color: Colors.blue)
      ) : SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                TextFormField(

                  validator: (value) {
                    if(value == null || value.isEmpty){
                       return "Veuillez renseigner nom garage svp.";
                    }
                    return null;
                  },
                  controller: _nom,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: ColorWidget.blue,
                    ),
                    labelText: 'Nom Garage *',
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
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _description,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: ColorWidget.blue,
                    ),
                    labelText: 'Description',
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
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  children: [
                    Text(
                      "Choisir Photo",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async{
                   var file = await  _pickImage();
                   setState(() {
                     _file = file!;
                   });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadiusWidget.borderRadius05()),
                    child: _imageGarage.isEmpty
                        ? Icon(
                            Icons.photo_camera_outlined,
                            color: ColorWidget.blue,
                            size: 50,
                          )
                        : Center(child: Text("Image choisi : $_imageGarage", style: TextStyle(color: ColorWidget.blue?.withValues(alpha: 0.7)),)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      print('Formulaire valide');
                      setState(() {
                        _loading = true;
                      });
                      var res = await GarageService.saveGarage({
                        "nom": _nom.text,
                        "description": _description.text,
                        "longitude": _longitude,
                        "latitude": _latitude
                      });

                        if(_file != null){
                          print('Fichier est chargé.');
                                  await GarageService.uploadImage(_file!, res['payload'], 'profile');
                        }
                        setState(() {
                          _loading = false;
                        });
                        NotificationHelper.success(
                            context, res['message']);
                        Navigator.pop(context);

                    } else {
                      NotificationHelper.success(
                          context, "Veuillez renseigner les champs requis.");
                    }

                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: ColorWidget.blue,
                        borderRadius: BorderRadiusWidget.borderRadius05()),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          Text(
                            "Enregistrer",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
