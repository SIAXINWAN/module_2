

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile_wsmb2024_02_day2/services/firestoreService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rider {
  final String name;
  final String icno;
  final bool gender;
  final String phone;
  final String email;
  final String address;
  String?image;
  String?password;
  String?id;

  Rider({
    this.image,this.id,this.password,
    required this.name, required this.icno, required this.gender, required this.phone, required this.email, required this.address});

    static Future<Rider?>registerRider(Rider rider, String password,File image)async{
      
      // if(await FirestoreService.isDriverDuplicated(driver)){
      //   return null;
      // }

      var byte = utf8.encode(password);
      var hashedPassword = sha256.convert(byte).toString();

      rider.password = hashedPassword;

      String fileName = 'Rider/${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask = FirebaseStorage.instance.ref(fileName).putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      rider.image = downloadURL;

      var newRider = await FirestoreService.addRider(rider);
      if(newRider == null){
        return null;
      }

      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('rider_token', rider.id.toString());
      return newRider;
    }

  static Future<Rider?> getRiderByToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('rider_token');
    if (token == null) {
      return null;
    }

    var rider = await FirestoreService.getRider(token);
    return rider;
  }

    static Future<Rider?>loginRider(String ic, String password)async{
       var byte = utf8.encode(password);
      var hashedPassword = sha256.convert(byte).toString();

      var newRider = await FirestoreService.loginRider(ic, hashedPassword);
      if(newRider == null){
        return null;
      }
SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('rider_token', newRider.id.toString());
      return newRider;

    }

    static Future<String>getToken()async{
       SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('rider_token');
    if (token == null) {
      return '';
    }
    return token;
  }

    static Future<bool>signOut()async{
      SharedPreferences pref = await SharedPreferences.getInstance();
    var logout = pref.remove('rider_token');
    return logout;
    }

    static Future<String>saveImage(File image)async{

      String fileName = 'Rider/${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask = FirebaseStorage.instance.ref(fileName).putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    }

    factory Rider.fromJson(Map<String,dynamic>json, [String?id]){
      return Rider(
        name: json['name']??'',
         icno: json['icno']??'', 
         gender: json['gender']as bool, 
         phone: json['phone']??'', 
         email: json['email']??'',
          address: json['address']??'',
        image: json['image'],
        id:id);
    }

    toJson(){
      return{
        'name':name,
        'id':id,
        'gender':gender,
        'image':image,
        'password':password,
        'icno':icno,
        'address':address,
        'phone':phone,
        'email':email
      };
    }

    toSome(){
      return{
        'name':name,
        'gender':gender,
        'image':image,
        
        'icno':icno,
        'address':address,
        'phone':phone,
        'email':email
      };
    }
}