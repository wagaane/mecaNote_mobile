import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/mecanicien/garages/list_garage_screen.dart';
import 'package:meca_note_mobile/welcome_screen.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/color_widget.dart';
import '../client/notification_screen.dart';
import '../profile_screen.dart';
import 'home_mecano.dart';

class HomeMecanoScreen extends StatefulWidget {
  const HomeMecanoScreen({super.key});

  @override
  State<HomeMecanoScreen> createState() => _HomeMecanoScreenState();
}

class _HomeMecanoScreenState extends State<HomeMecanoScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    const Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [HomeMecano()],
    ),
    const ListGarageScreen(),
    const ProfileScreen(),
  ];

  void _confirmDisconnection(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Tap outside to dismiss
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.blue.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.white, width: 5)
          ),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 80, vertical: 200),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Se déconnecté ?",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 0.2),
                          borderRadius: BorderRadiusWidget.borderRadius05(),
                        ),
                        child: Center(
                            child: Text(
                          "Annuler",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async{
                        SharedPreferences _pref = await SharedPreferences.getInstance();
                        _pref.clear();
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const WelcomeScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 0.2),
                          color: ColorWidget.blue,
                          borderRadius: BorderRadiusWidget.borderRadius05(),
                        ),
                        child: Center(
                            child: Text(
                          "Oui",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _selectedIndex != 2
            ? PreferredSize(
                preferredSize: const Size.fromHeight(120),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                _confirmDisconnection(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Image.asset(
                                  "assets/icons/menu.png",
                                  width: 25,
                                  color: ColorWidget.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // width:
                              //     MediaQuery.of(context).size.width / 2 + 130,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ColorWidget.blue!
                                                    .withValues(alpha: 0.3),
                                                width: 5),
                                            color: Colors.blue
                                                .withValues(alpha: 0.1),
                                            borderRadius: BorderRadiusWidget
                                                .borderRadius100()),
                                        child: const Icon(
                                          Icons.person_outline,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Ablaye Faye",
                                        style: TextStyle(
                                            color: ColorWidget.blue,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  )),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push<void>(
                            //       context,
                            //       MaterialPageRoute<void>(
                            //         builder: (BuildContext context) =>
                            //             const NotificationScreen(),
                            //       ),
                            //     );
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(right: 10.0),
                            //     child: Container(
                            //       padding: const EdgeInsets.all(5),
                            //       decoration: BoxDecoration(
                            //           color: ColorWidget.blue,
                            //           borderRadius: const BorderRadius.all(
                            //               Radius.circular(100))),
                            //       child: const Icon(
                            //         Icons.notifications_none,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: SizedBox.shrink(),
              ),
        backgroundColor: Colors.white.withOpacity(0.9),
        body: SingleChildScrollView(child: _pages[_selectedIndex]),
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
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.garage_outlined),
                label: 'Mes garages',
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
