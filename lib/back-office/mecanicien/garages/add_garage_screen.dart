import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meca_note_mobile/models/service_modele.dart';
import 'package:meca_note_mobile/services/domaine_mecano_service.dart';
import 'package:meca_note_mobile/services/reference_service.dart';
import 'package:meca_note_mobile/utils/geolocation_helper.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/title_widget.dart';
import 'package:provider/provider.dart';
import '../../../state-manager/garage_provider.dart';
import '../../../utils/utilis.dart';
import '../../../widgets/color_widget.dart';

class AddGarageScreen extends StatefulWidget {
  const AddGarageScreen({super.key});

  @override
  State<AddGarageScreen> createState() => _AddGarageScreenState();
}

class _AddGarageScreenState extends State<AddGarageScreen> {
  String _imageGarage = '';
  File? _file;
  final _nom = TextEditingController();
  final _description = TextEditingController();
  final _latitude = TextEditingController();
  final _longitude = TextEditingController();
  bool _loading = true;
  final _formKey = GlobalKey<FormState>();
  List<ServiceModele> _services = [];
  String _dynamicText = "Cliquer pour choisir service";

  // RENSEIGNER LES COORDONNEES
  _setCoordinates() async {
    var response = await GeolocationHelper.determinePosition();
    setState(() {
      _latitude.text = response.latitude.toString();
      _longitude.text = response.longitude.toString();
    });
  }

  _getServices() async {
    var res = await GarageService.listGarages();
    print('$res');
    setState(() {
      _services = ServiceModele.fromList(res['payload']);
    });
  }

  _initData() async {
    await _setCoordinates();
    await _getServices();
    setState(() {
      _loading = false;
    });
  }

  bool _checkAllService = false;
  // choix services garage
  void _selectService(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Makes it possible to take full screen
      backgroundColor: Colors.transparent, // To make the corners customizable
      builder: (context) => DraggableScrollableSheet(
        expand: true,
        builder: (context, scrollController) {
          return StatefulBuilder(
           builder: (context, setStateModel) {
             return Container(
               decoration: const BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
               ),
               padding: const EdgeInsets.all(16),
               child: SingleChildScrollView(
                 controller: scrollController,
                 child:  Column(
                   children: [
                      SizedBox(
                       width: 100,
                       child: Divider(
                         thickness: 2,
                         color: Colors.black,
                         indent: 20,   // marge à gauche
                         endIndent: 20, // marge à droite
                         radius: BorderRadiusWidget.borderRadius100(),
                       ),
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         GestureDetector(
                           onTap: () {
                             Navigator.pop(context);
                           },
                           child: Container(
                             padding: const EdgeInsets.all(10),
                             child: const Icon(Icons.close_outlined,),
                             decoration: BoxDecoration(
                               color: ColorWidget.blue!.withValues(alpha: 0.2),
                               borderRadius: BorderRadiusWidget.borderRadius100(),
                             ),
                           ),
                         ),

                         _services.where((element) => element.selected,).isEmpty ? 
                         Text("Séléctionner les services", style: TextStyle(color: ColorWidget.blue, fontWeight: FontWeight.w600),) : Text("Service(s) séléctionné(s) : ${_services.where((element) => element.selected,).length}"),
                         GestureDetector(
                           onTap: () {
                             List<ServiceModele> services = [];
                             if(_checkAllService){
                               _services.forEach((e) {
                                 e.selected = false;
                                 services.add(e);
                               },);
                             }else{

                               _services.forEach((e) {
                                 e.selected = true;
                                 services.add(e);
                               },);
                               setState(() {
                                 _dynamicText = "${services.length} service(s) choisi(s)";
                               });
                             }
                             setStateModel(() {
                               _services = services;
                             });
                             setStateModel(() {
                               _checkAllService = !_checkAllService;
                             });
                           },
                           child: Icon( !_checkAllService ? Icons.check_box_outline_blank : Icons.check_box, color: ColorWidget.blue,),
                         )
                       ],

                     ),
                     const SizedBox(height: 10,),
                     Wrap(
                       // direction: Axis.horizontal,
                       spacing: 8, // Espace horizontal entre les éléments
                       runSpacing: 8, // Espace vertical entre les lignes
                       children: List.generate(_services.length, (index) {
                         var service = _services[index];
                         return GestureDetector(
                           onTap: () {

                             var services = _services;
                             List<ServiceModele> newList = [];
                             for (var element in services) {
                               if(service.id == element.id){
                                 element.selected = !element.selected;
                               }
                               newList.add(element);
                             }
                             setStateModel(() {
                               _services = newList;
                             });
                             var numberOfSelectedService = _services.where((element) => element.selected,).length;
                             setState(() {
                               _dynamicText = "$numberOfSelectedService service(s) choisi(s)";
                             });
                           },
                           child: Container(
                             height: 70,
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                                 color: service.selected ? Colors.blueAccent : Colors.white,
                                 border: Border.all(color: ColorWidget.blue!),
                                 borderRadius: BorderRadiusWidget.borderRadius100()
                             ),
                             child: Center(
                               child: ListTile(
                                 leading: Image.asset(service.img, width: 30, color: service.selected ? Colors.white : ColorWidget.blue,),
                                 title: Text(
                                   service.label,
                                   style: TextStyle(color: service.selected ? Colors.white : ColorWidget.blue, fontSize: 16),
                                 ),
                               )

                             ),
                           ),
                         );
                       }),
                     )
                     // Add more widgets here
                   ],
                 ),
               ),
             );
           },

          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
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
    final provider = Provider.of<GarageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: _loading
          ? Utils.loading()
          : SingleChildScrollView(
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
                          if (value == null || value.isEmpty) {
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
                                color: ColorWidget.blue!.withOpacity(0.4),
                                width: 2),
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
                                color: ColorWidget.blue!.withOpacity(0.4),
                                width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuilles renseigner latitude svp.';
                          }
                          return null;
                        },
                        controller: _latitude,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.edit_location_alt_outlined,
                            color: ColorWidget.blue,
                          ),
                          labelText: 'Latitude *',
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
                                color: ColorWidget.blue!.withOpacity(0.4),
                                width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez renseigner longitude svp.';
                          }
                          return null;
                        },
                        controller: _longitude,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.edit_location_alt_outlined,
                            color: ColorWidget.blue,
                          ),
                          labelText: 'Longitude *',
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
                                color: ColorWidget.blue!.withOpacity(0.4),
                                width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Services",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          _selectService(context);
                        },
                        child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius:
                                    BorderRadiusWidget.borderRadius05()),
                            child: Center(child: Text(_dynamicText, style: const TextStyle(fontWeight: FontWeight.w600),))),
                      ),
                      const SizedBox(
                        height: 10,
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
                        onTap: () async {
                          var file = await _pickImage();
                          setState(() {
                            _file = file!;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:
                                  BorderRadiusWidget.borderRadius05()),
                          child: _imageGarage.isEmpty
                              ? Icon(
                                  Icons.photo_camera_outlined,
                                  color: ColorWidget.blue,
                                  size: 50,
                                )
                              : Center(
                                  child: Text(
                                  "Image choisi : $_imageGarage",
                                  style: TextStyle(
                                      color: ColorWidget.blue
                                          ?.withValues(alpha: 0.7)),
                                )),
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
                            var dataService = _services.where((element) => element.selected,).toList();
                            var list = [];
                            for (var element in dataService) {
                              list.add(element.id);
                            }

                            print(list.join(','));
                            var data = {
                              "nom": _nom.text,
                              "description": _description.text,
                              "longitude": _longitude.text,
                              "latitude": _latitude.text,
                              "services": list.join(',')
                            };
                            await provider.createGarage(data, _file, context);
                            setState(() {
                              _loading = false;
                            });
                          } else {
                            setState(() {
                              _loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: ColorWidget.red,
                                  content: const Text(
                                      'Veuillez renseigner les champs requis.')),
                            );
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: ColorWidget.blue,
                              borderRadius:
                                  BorderRadiusWidget.borderRadius05()),
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
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
