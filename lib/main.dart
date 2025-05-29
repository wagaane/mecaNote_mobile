import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meca_note_mobile/auth/login_screen.dart';
import 'package:meca_note_mobile/auth/register_screen.dart';
import 'package:meca_note_mobile/back-office/client/dashboard_client_screen.dart';
import 'package:meca_note_mobile/back-office/mecanicien/dashboard_mecano_screen.dart';
import 'package:meca_note_mobile/back-office/unknow_user_screen.dart';
import 'package:meca_note_mobile/config/api_config.dart';
import 'package:meca_note_mobile/services/push_notification_service.dart';
import 'package:meca_note_mobile/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService.initialize();
  runApp(const MyApp());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);



}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();



  @override
  void initState() {
    super.initState();
    _initApp();
  }

  String _user = '';
  bool _isOk = false;
  bool _isMecano = true;
  _initApp() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    var token = await ApiConfig.getToken();
    var user = await ApiConfig.getRole();
    setState(() {
      _user = user;
    });
    if (token.isNotEmpty) {
      setState(() {
        _isOk = true;
      });
      if (user == 'MECANO') {
        setState(() {
          _isMecano = true;
        });
      } else {
        setState(() {
          _isMecano = false;
        });
        print('CLIENT');
      }
    } else {
      setState(() {
        _isOk = false;
      });
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'MecaNote',
        theme: ThemeData(
          fontFamily: 'Inter',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          hintColor: Colors.black,
          useMaterial3: true,
        ),
        navigatorKey: navigatorKey,
        // initialRoute: '/',
        routes: {
          '/dashboard-mecano-demands': (context) => const DashboardMecanoScreen(),
          // '/demands': (context) => DetailsPage(),
        },
        home:
        // RegisterScreen());
        _isLoading
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png', width: 200,height: 200,),
                    ],
                  ),
                ))
            : _user == 'UNKNOW'  ? const UnknowUserScreen() : ( _isOk
                ? (_isMecano ? const DashboardMecanoScreen() : const DashboardClientScreen())
                : const WelcomeScreen()));
  }
}
