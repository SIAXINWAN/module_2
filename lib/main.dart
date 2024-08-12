import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02_day2/firebase_options.dart';
import 'package:mobile_wsmb2024_02_day2/pages/startPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  runApp(const MyApp(home:StartPage()));
}
 
 //whered driver_id is equal to driver_id
 //(json['like']as list<Dynamic>?)?.map((e)=>e.toString).toList??[]

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.home});
  final Widget home;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: home,
    );
  }
}

