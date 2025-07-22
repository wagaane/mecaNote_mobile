import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meca_note_mobile/back-office/client/detail_garage_screen.dart';
import 'package:meca_note_mobile/back-office/mecanicien/garages/add_garage_screen.dart';
import 'package:meca_note_mobile/config/api_config.dart';
import 'package:meca_note_mobile/models/garage_response.dart';
import 'package:meca_note_mobile/services/garage_service.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';

import '../../../widgets/go_back_widget.dart';
import '../../../widgets/note_garage_widget.dart';
import '../../../widgets/title_widget.dart';

class ListGarageScreen extends StatefulWidget {
  const ListGarageScreen({super.key});

  @override
  State<ListGarageScreen> createState() => _ListGarageScreenState();
}

class _ListGarageScreenState extends State<ListGarageScreen> {


  List<GarageResponse> _garages = [];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getListGarages();
  }


  // LISTE DES GARAGES
  _getListGarages() async{
    var res = await GarageService.listGarages();
    setState(() {
      _garages = GarageResponse.jsonList(res['payload']);
      _loading = false;
    });
    print('la liste des garages : $res');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withValues(alpha: 0.9),
        appBar: AppBar(
          title: TitleWidget.setTitle("Mes garages"),
          backgroundColor: Colors.white.withValues(alpha: 0.0),
          leading: MyButtonWidget.goBack(context),
        ),
        body:  _loading ? Center(
            child: LoadingAnimationWidget.discreteCircle(secondRingColor: ColorWidget.white, size: 70, thirdRingColor: ColorWidget.blue!, color: Colors.blue)
        ) : SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var garage = _garages[index];
                        return GestureDetector(
                          onLongPress: () {
                            Navigator.pushNamed(context, "/details-garage");
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:  Row(
                                      children: [
                                        Text(garage.nom, style: TextStyle(color: ColorWidget.blue, fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadiusWidget
                                            .borderRadius100()),
                                    padding: const EdgeInsets.all(10),
                                    child:
                                    garage.file == null ? Center(child: Icon(Icons.photo, size: 150, color: ColorWidget.blue?.withValues(alpha: 0.5),),) :CachedNetworkImage(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      imageUrl: "${ApiConfig.baseUrl}file/download?filename=${garage.file?.generatedName}",
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadiusWidget.borderRadius05(),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => const SizedBox(width: 70, height: 70,child: const CircularProgressIndicator(value: 2,)),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [


                                        NoteGarage.noteGarage(1),

                                      ],
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: _garages.length),
                ),
              ),
            ],
          ),
        ),
    floatingActionButton: GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const AddGarageScreen(),
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
