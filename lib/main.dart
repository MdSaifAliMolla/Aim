import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iota/pages/login.dart';
import 'firebase_options.dart';
import 'components/bottomnav.dart';

final navigatorKey=GlobalKey<NavigatorState>();
void main()async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 61, 9, 165)),
        useMaterial3: true,
      ),
      // home:StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(), 
      //   builder:(BuildContext context,AsyncSnapshot snapshot){
      //     if (snapshot.hasError) {
      //       return Text(snapshot.error.toString());
      //     }
      //     if (snapshot.connectionState==ConnectionState.active) {
      //       if (snapshot.data==null) {
      //         return const LoginPage();
      //       }else{
      //         return const BottomNav();
      //       }
      //     }
      //     return const Center(child: CircularProgressIndicator());
      //   }), 
      home: BottomNav(),   
    );
  }
}

