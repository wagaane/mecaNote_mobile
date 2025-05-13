import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/mecanicien/dashboard_mecano_screen.dart';
import 'package:meca_note_mobile/models/domaine_mecano_model.dart';

import '../../services/domaine_mecano_service.dart';
import '../../utils/notification_helper.dart';
import '../../widgets/color_widget.dart';

class AddRemoveDomainActivityScreen extends StatefulWidget {
  final List<DomaineMecanoModel> services;
  const AddRemoveDomainActivityScreen({super.key, required this.services});

  @override
  State<AddRemoveDomainActivityScreen> createState() =>
      _AddRemoveDomainActivityScreenState();
}

class _AddRemoveDomainActivityScreenState
    extends State<AddRemoveDomainActivityScreen> {
   List<DomaineMecanoModel> _domaineMecanos = [];

  _updateList(id) {
    var newList = _domaineMecanos;
    var service = _domaineMecanos
        .where(
          (element) => element.id == id,
        )
        .first;
    var index = _domaineMecanos.indexOf(service);
    service.selected = !service.selected;
    newList[index] = service;
    setState(() {
      _domaineMecanos = newList;
    });
  }

  _getDomainesMecanos() async{
    var response = await DomaineMecanoService.list();
    List<DomaineMecanoModel> tempList = [];
    if(response['status'] == 'OK'){
      setState(() {
        _domaineMecanos = DomaineMecanoModel.fromList(response['payload']);
      });
      for (var element in _domaineMecanos) {
        if(widget.services.where((el) => el.id == element.id,).isNotEmpty){
          element.selected = true;
        }
        tempList.add(element);
      }

      setState(() {
        _domaineMecanos = tempList;
      });
    }else{
      NotificationHelper.error(context, response['message']);
    }

  }


  @override
  void initState() {
    super.initState();
    _getDomainesMecanos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: () {
             Navigator.push<void>(
               context,
               MaterialPageRoute<void>(
                 builder: (BuildContext context) => const DashboardMecanoScreen(),
               ),
             );          }, icon: Container(
            decoration:  BoxDecoration(
                color: ColorWidget.white,
                borderRadius: const  BorderRadius.all(Radius.circular(10))
            ),
              child: const Center(child: const Icon(Icons.arrow_back_ios, color: Colors.blue,)))),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Domaines d'activité",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async{
                  List<String> domaines = [];
                  var selectedDomaines = _domaineMecanos.where((element) => element.selected == true,);
                  if(selectedDomaines.isNotEmpty){
                    for (var element in selectedDomaines) {
                      domaines.add(element.id.toString());
                    }

                    print(domaines.length);

                    var response = await DomaineMecanoService.updateMyList(domaines);
                    print(response);
                    if(response['status'] == "OK"){
                      NotificationHelper.success(context, response['message']);

                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const DashboardMecanoScreen(),
                        ),
                      );                    }else{
                      NotificationHelper.error(context, response['message']);
                    }
                  }else{
                    NotificationHelper.error(context, "Veuillez choisir au moins un domaine d'activité");
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorWidget.black12),
                          color: ColorWidget.white,
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),
                        child: const Row(
                          children: [
                             Text("Enregistrer", style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),),
                            SizedBox(width: 5,),
                            Icon(Icons.save_outlined,color: Colors.blue,)
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _domaineMecanos.length,
                  itemBuilder: (context, index) {
                    var service = _domaineMecanos[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _updateList(service.id);
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 15,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorWidget.black12),
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2 + 100,
                                        child: AutoSizeText(
                                          service.label,
                                          style: TextStyle(
                                              color: ColorWidget.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                      child: Icon(
                                    service.selected
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: ColorWidget.blue,
                                  ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
