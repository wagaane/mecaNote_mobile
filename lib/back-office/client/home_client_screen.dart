import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/client/detail_garage_screen.dart';
import 'package:meca_note_mobile/back-office/client/search_garage_screen.dart';
import 'package:meca_note_mobile/back-office/profil/condition_utilisation_screen.dart';
import 'package:meca_note_mobile/back-office/profil/configuration/configuration_screen.dart';
import 'package:meca_note_mobile/back-office/profil/configuration/edit_mot_de_passe_screen.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';
import 'package:meca_note_mobile/widgets/garage_widget.dart';
import 'package:meca_note_mobile/widgets/padding_widget.dart';

import '../profil/profile_screen.dart';

class HomeClientScreen extends StatefulWidget {
  const HomeClientScreen({super.key});

  @override
  State<HomeClientScreen> createState() => _HomeClientScreenState();
}

class _HomeClientScreenState extends State<HomeClientScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    // SearchGarageScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _selectedIndex == 1
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         Row(
                          children: [
                            SizedBox(height: 40,),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Bonjour,',
                                style: TextStyle(
                                    color: ColorWidget.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 + 130,
                              child: const Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Bienvenue dans votre application de mécano.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: ColorWidget.blue,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                                child: const Icon(
                                  Icons.notifications_none,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
        backgroundColor: Colors.white.withOpacity(0.9),
        body: SingleChildScrollView(
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: ColorWidget.blue,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.white,
            unselectedItemColor: ColorWidget.white,
            selectedLabelStyle: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: MediaQuery.of(context).size.width / 2 - 50,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/mechanic.png",
                            fit: BoxFit.contain,
                            width: 50,
                            color: ColorWidget.blue,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Mécano",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: MediaQuery.of(context).size.width / 2 - 50,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/team.png",
                          fit: BoxFit.contain,
                          width: 50,
                          color: ColorWidget.blue,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Mes RDVs",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: MediaQuery.of(context).size.width / 2 - 50,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/mechanic.png",
                            fit: BoxFit.contain,
                            width: 50,
                            color: ColorWidget.blue,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Mécano",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: MediaQuery.of(context).size.width / 2 - 50,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/team.png",
                          fit: BoxFit.contain,
                          width: 50,
                          color: ColorWidget.blue,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Mes RDVs",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Plus proche de vous",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const SearchGarageScreen(),
                  ),
                );
              },
              child:  Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "Voir tout",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: ColorWidget.blackWithOpacityO5),
                ),
              ),
            ),
          ],
        ),
        Container(
            height: MediaQuery.of(context).size.height / 3,
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            // decoration: BoxDecoration(color: Colors.white),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const DetailGarageScreen(),
                        ),
                      );
                    },
                    child:
                        GarageWidget.garageContainer({"name": "Garage Touba"}));
              },
            )),
        // SizedBox(height: 200,)
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var W = MediaQuery.of(context).size.width;
    var H = MediaQuery.of(context).size.height;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: H / 7,
        ),
        Center(
          child: Column(
            children: [
              Container(
                width: W / 5,
                height: W / 5,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusWidget.borderRadius100()),
                child: Image.asset(
                  "assets/user.png",
                  width: 50,
                ),
              ),
              Text(
                "Ablaye Faye",
                style: TextStyle(
                    color: ColorWidget.blue, fontWeight: FontWeight.w600),
              ),
              const Text("ablayefaye9725@gmail.com"),
              const Text("221778545382"),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: W - 50,
          // height: H - 100,
          decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadiusWidget.borderRadius10()),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
                child: ListTile(
                  onTap:  () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const MyProfileScreen(),
                      ),
                    );
                  },
                    title: const Text("Mon profil"),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.person_outline,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const ConfigurationScreen(),
                      ),
                    );
                  },
                    title: const Text("Configuration"),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.settings_outlined,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                    title: const Text("Aide & Assistance"),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.help_outline,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const ConditionUtilisationScreen(),
                      ),
                    );
                  },
                    title: const Text("Condition d'utilisation"),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.info_outline,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                    title: const Text("Inviter un ami"),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.share_outlined,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: ListTile(
                    title: const Text(
                      "Se déconnecter",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    ),
                    leading: Container(
                      padding: PaddingWidget.padding5,
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO1,
                          borderRadius: BorderRadiusWidget.borderRadius100()),
                      child: Icon(
                        Icons.logout,
                        color: ColorWidget.blue,
                        size: 20,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
