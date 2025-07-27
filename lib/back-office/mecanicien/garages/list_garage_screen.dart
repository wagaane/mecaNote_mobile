import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/client/detail_garage_screen.dart';
import 'package:meca_note_mobile/back-office/mecanicien/garages/add_garage_screen.dart';
import 'package:meca_note_mobile/back-office/mecanicien/garages/details_garage_mecano_screen.dart';
import 'package:meca_note_mobile/config/api_config.dart';
import 'package:meca_note_mobile/utils/notification_helper.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';
import 'package:provider/provider.dart';

import '../../../state-manager/garage_provider.dart';
import '../../../widgets/go_back_widget.dart';
import '../../../widgets/note_garage_widget.dart';
import '../../../widgets/title_widget.dart';

class ListGarageScreen extends StatefulWidget {
  const ListGarageScreen({super.key});

  @override
  State<ListGarageScreen> createState() => _ListGarageScreenState();
}

class _ListGarageScreenState extends State<ListGarageScreen> {
  late ScrollController _scrollController;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  late int _totalGarages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GarageProvider>(context, listen: false);
      provider.fetchNextPage();
    });
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final provider = Provider.of<GarageProvider>(context, listen: false);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent  &&
          provider.hasMore &&
          !provider.isLoading) {
        provider.fetchNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withValues(alpha: 0.9),
        appBar: AppBar(
          title: TitleWidget.setTitle("Mes garages"),
          backgroundColor: Colors.white,
          leading: MyButtonWidget.goBack(context),
        ),
        body: Consumer<GarageProvider>(
          builder: (context, provider, _) {

            if (provider.isLoading) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            }

            if (provider.garages.isEmpty) {
              return Center(
                child: Image.asset(
                  "assets/icons/no-data.png",
                  width: 100,
                  color: Colors.black12,
                ),
              );
            }


            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text("Total Garages ", style:  TextStyle(color: ColorWidget.blue, fontWeight: FontWeight.w600),),
                        const SizedBox(width: 10,),
                        Container(
                          padding: const EdgeInsets.all( 10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadiusWidget.borderRadius100()
                          ),
                          child: Text("${provider.totalGarages}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                        ),
                        const SizedBox(height: 10,)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.separated(
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          if (index < provider.garages.length) {
                            var garage = provider.garages[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>  DetailGarageMecanoScreen(garageResponse: garage,),
                                  ),
                                );
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              garage.nom,
                                              style: TextStyle(
                                                  color: ColorWidget.blue,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadiusWidget
                                                .borderRadius100()),
                                        padding: const EdgeInsets.all(10),
                                        child: garage.file == null
                                            ? Center(
                                                child: Icon(
                                                  Icons.photo,
                                                  size: 150,
                                                  color: ColorWidget.blue
                                                      ?.withValues(alpha: 0.5),
                                                ),
                                              )
                                            :
                                        CachedNetworkImage(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 150,
                                                imageUrl:
                                                    "${ApiConfig.baseUrl}file/download?filename=${garage.file?.generatedName}",
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadiusWidget
                                                            .borderRadius05(),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              ColorWidget.blue,
                                                        )),
                                                  ],
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
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
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: provider.garages.length +
                            (provider.hasMore ? 1 : 0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: GestureDetector(
          onTap: () async{
            var abonnement = await ApiConfig.getAbonnement();
            if(abonnement == "FREE"){
              NotificationHelper.warning(context, "Seul les abonnés primieums  peuvent avoir plus d'un garage.");
            }else{
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddGarageScreen(),
                ),
              );
            }

          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusWidget.borderRadius100(),
                border: Border.all(color: Colors.orange, width: 0.2),
                color: ColorWidget.blue),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ));
  }
}
