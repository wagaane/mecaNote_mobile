import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/mecanicien/add_remove_domain_activity_screen.dart';
import 'package:meca_note_mobile/models/demand_model.dart';
import 'package:meca_note_mobile/models/domaine_mecano_model.dart';
import 'package:meca_note_mobile/models/enums/StatusEnum.dart';
import 'package:meca_note_mobile/services/domaine_mecano_service.dart';
import 'package:meca_note_mobile/utils/date_utili.dart';
import 'package:meca_note_mobile/utils/notification_helper.dart';
import 'package:meca_note_mobile/welcome_screen.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/demande_service.dart';

class DashboardMecanoScreen extends StatefulWidget {
  const DashboardMecanoScreen({super.key});

  @override
  State<DashboardMecanoScreen> createState() => _DashboardMecanoScreenState();
}

class _DashboardMecanoScreenState extends State<DashboardMecanoScreen> {
  List<DomaineMecanoModel> _domaineMecanos = [];
  List<DemandModel> _demands = [];
  int _selectedPage = 0;
  String _title = 'Domaines d\'activités';
  final _searchController = TextEditingController();
  late int _notReadedDemands = 0;

  @override
  void initState() {
    super.initState();
    _getDomainesMecanos();
    _getLenDemands();
  }

  final ScrollController _scrollController = ScrollController();

  bool _loading = false;
  Future<void> _fetchData() async {
    setState(() {
      _loading = true;
    });
    if (_page < _totalPages) {
      var response =
          await DemandService.listDemands(_page, 10, '', '', '', '', '', '');
      setState(() {
        _demands.addAll(DemandModel.fromList(response['payload']));
        _page = _page + 1;
      });
      setState(() {
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
      NotificationHelper.success(context, "Liste demandes à terme..");
    }
  }

  _getDemands(
      {int page = 0,
      int size = 10,
      String prenom = '',
      String nom = '',
      String status = "SOUMIS",
      String filter = '',
      String date = '',
      String adresse = ''}) async {
    setState(() {
      _loading = true;
    });
    var response = await DemandService.listDemands(
        page, size, prenom, nom, status, filter, date, adresse);
    print(response);
    setState(() {
      _demands =DemandModel.fromList(response['payload']);
      _totalPages = response['metadata']['totalPages'];
      _loading = false;
    });
  }

  int _totalPages = 0;
  int _page = 1;
  _getLenDemands() async {
    setState(() {
      _loading = true;
    });
    var res = await DemandService.getLenDemands();
    setState(() {
      _notReadedDemands = res['payload'];
      _loading = false;
    });
  }

  _getDomainesMecanos() async {
    setState(() {
      _loading = true;
    });
    var response = await DomaineMecanoService.myList();
    if (response['status'] == 'OK') {
      setState(() {
        _domaineMecanos = DomaineMecanoModel.fromList(response['payload']);
      });
    } else {
      NotificationHelper.error(context, response['message']);
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _selectedPage == 2 ? Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: DropdownButton<String>(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              dropdownColor: Colors.white,
              icon: const Icon(Icons.more_vert),
              underline: const SizedBox(), // pour retirer la ligne sous le bouton
              onChanged: (String? newValue) async {
                if(newValue != _seletedDemande){
                  setState(() {
                    _page = 0;
                  });
                  switch (newValue) {
                    case 'rejeter':
                      setState(() {
                        _seletedDemande = "rejeter";
                      });
                      await _getDemands(status: StatusEnum.REJETER.name);
                      break;
                    case 'valider':
                      setState(() {
                        _seletedDemande = "valider";
                      });
                      await _getDemands(status: StatusEnum.VALIDER.name);
                      break;
                    case 'soumis':
                      setState(() {
                        _seletedDemande = "soumis";
                      });
                      await _getDemands(status: StatusEnum.SOUMIS.name);
                      break;
                  }
                }

              },
              items: [
                const DropdownMenuItem(
                  value: 'rejeter',
                  child: Text('rejeter'),
                ),
                const DropdownMenuItem(
                  value: 'valider',
                  child: Text('valider'),
                ),
                DropdownMenuItem(
                  value: 'soumis',
                  child: Row(
                    children: [
                      const Text('à valider'),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            color: Colors.red[400]),
                        child: Text(
                          '$_notReadedDemands',
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ) : const SizedBox.shrink()
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(_title),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: _drawer(context),
      floatingActionButton: _selectedPage == 0
          ? FloatingActionButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: ColorWidget.white, width: 1),
                borderRadius: BorderRadius.circular(100),
              ),
              elevation: 10,
              backgroundColor: ColorWidget.white,
              child: Icon(
                Icons.add,
                color: ColorWidget.blue,
                size: 30,
              ),
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        AddRemoveDomainActivityScreen(
                            services: _domaineMecanos),
                  ),
                );
              },
            )
          : const Center(),
      body: _loading ? Center(child: CircularProgressIndicator(color: ColorWidget.blue,),) : SingleChildScrollView(
        child: _selectedPageScreen(_selectedPage),
      ),
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 20,),
                Image.asset(
                  'assets/user.png',
                  fit: BoxFit.contain,
                  width: 100,
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Ablaye Faye",
                      style: TextStyle(
                          color: ColorWidget.blackWithOpacityO5,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "ablayefaye9725@gmail.com",
                      style: TextStyle(
                          color: ColorWidget.blackWithOpacityO5,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorWidget.orange,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.star,
                      color: ColorWidget.orange,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.star,
                      color: ColorWidget.orange,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.star,
                        color: ColorWidget.orange?.withOpacity(0.2)),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.star,
                        color: ColorWidget.orange?.withOpacity(0.2)),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),

                GestureDetector(
                  child: Container(
                    width: 100,
                    // height: 20,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: ColorWidget.orange),
                    child: Center(
                      child: Row(
                        children: [
                          const Text(
                            "Booster",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            "assets/icons/startup.png",
                            width: 15,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPage = 1;
                _title = 'Mon compte';
              });
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(color: ColorWidget.blue),
              child: ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  "Mon compte",
                  style: TextStyle(
                      color: ColorWidget.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorWidget.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 0.5,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPage = 0;
                _title = 'Domaines d\'activités';
              });
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(color: ColorWidget.blue),
              child: ListTile(
                leading: const Icon(
                  Icons.local_activity,
                  color: Colors.white,
                ),
                title: Text(
                  "Domaines d'activités",
                  style: TextStyle(
                      color: ColorWidget.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorWidget.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 0.5,
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                _searchController.text = '';
                _selectedPage = 2;
                _title = 'Mes demandes';
              });
              _scrollController.addListener(() async {
                if (_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent) {
                  await _fetchData();
                }
              });
              setState(() {
                _seletedDemande = '';
              });
              if (_demands.isEmpty) {

                await _getDemands();
              }
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(color: ColorWidget.blue),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
                title: Row(
                  children: [
                    Text(
                      "Mes demandes",
                      style: TextStyle(
                          color: ColorWidget.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100))),
                      child: Center(
                          child: Text(
                        _notReadedDemands.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                    )
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorWidget.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 0.5,
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences _pref = await SharedPreferences.getInstance();
              _pref.clear();
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const WelcomeScreen(),
                ),
              );
              // @
              NotificationHelper.success(
                  context, "Déconnexion éffectuée avec succès.");
            },
            child: Container(
              decoration: BoxDecoration(color: ColorWidget.blue),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  "Se déconnecter",
                  style: TextStyle(
                      color: ColorWidget.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorWidget.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _selectedPageScreen(int page) {
    switch (page) {
      case 0:
        return _domainOfActivities(context);
      case 1:
        return _profileInfos(context);
      case 2:
        return _myDemands(context);
    }
  }

  Container _domainOfActivities(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(color: Colors.white),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        margin: const EdgeInsets.only(bottom: 100.0),
        child: ListView.builder(
          itemCount: _domaineMecanos.length,
          itemBuilder: (context, index) {
            var service = _domaineMecanos[index];
            return GestureDetector(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 7,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorWidget.black12),
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          service.img != ''
                              ? Image.asset(service.img,
                                  fit: BoxFit.contain,
                                  width:
                                      MediaQuery.of(context).size.height / 11,
                                  color: ColorWidget.blue)
                              : const Center(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.orange, width: 5),
                                color: ColorWidget.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100))),
                            child: Text(
                              '12',
                              style: TextStyle(
                                  color: ColorWidget.blue,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
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
    );
  }

  SingleChildScrollView _profileInfos(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }

  String _seletedDemande = "soumis";

  SingleChildScrollView _myDemands(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        setState(() {
                          _demands = [];
                          _page = 0;
                        });
                        await _getDemands(filter: _searchController.text);
                      },
                      icon: const Icon(Icons.search_outlined)),
                  hintText: 'Rechercher ...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            _demands.isEmpty
                ? const Text(
                    "Pas de données",
                    style: TextStyle(color: Colors.black38, fontSize: 18),
                  )
                : const Center(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _demands.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _demands.length) {
                      return _loading
                          ? const CircularProgressIndicator()
                          : const SizedBox.shrink();
                    }
                    var demand = _demands[index];
                    return GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 10,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              color: Colors.white70,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                '${demand.client.prenom.toUpperCase()} ${demand.client.nom.toUpperCase()}',
                                style: TextStyle(
                                    color: ColorWidget.blue,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(demand.domaine.label,
                                      style: TextStyle(
                                          color: ColorWidget.black54,
                                          fontWeight: FontWeight.w600,
                                        fontSize: 12
                                          )),
                                  Text("${DateUtil.timeAgo(demand.dateCreation)}")
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person_outline,
                                  color: ColorWidget.blue,
                                  size: 35,
                                ),
                              ),
                              onLongPress: () {
                                _showDemandModal(context, demand);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDemandModal(BuildContext context, DemandModel demand) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // utile si tu veux un modal plus grand
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: AutoSizeText(
                    "Demandeur : ${demand.client.prenom} ${demand.client.nom}\nDomaine : ${demand.domaine.label}\nDistance: à 2.5 km\n",
                    style: const TextStyle(fontSize: 18),
                    maxLines: 5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Row(
                        children: [
                          Text(
                            "Fermer",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.close, color: Colors.white)
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: const Row(
                        children: [
                          Text(
                            "Valider",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.check_circle_outline, color: Colors.white)
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.red[600],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: const Row(
                        children: [
                          Text(
                            "Rejeter",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.remove_circle_outline, color: Colors.white)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
