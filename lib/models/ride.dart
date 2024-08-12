
import 'package:mobile_wsmb2024_02_day2/models/driver.dart';
import 'package:mobile_wsmb2024_02_day2/models/vehicle.dart';
import 'package:mobile_wsmb2024_02_day2/services/firestoreService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ride {
  final String date;
  final String origin;
  final String destination;
  final int fare;
  String? vehicle_id;
  String? driver_id;
  String?id;
  List<String>join;
  List<String>like;
  List<String>cancel;

  Ride({
    List<String>?join,
    List<String>?like,
    List<String>?cancel,
    this.driver_id,this.id,
    
    required this.date, required this.origin, required this.destination, required this.fare, this.vehicle_id}):join = join ?? [],like = like??[],cancel = cancel??[];

    static Future<bool> registerRide(String masa, int money, String tempat,
      String sampai, ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    if (token == null) {
      return false;
    }
    Ride ride = Ride(
        driver_id: token,
        origin: tempat,
        destination: sampai,
        fare: money,
        date: masa,
        );

    var res = await FirestoreService.addRide(ride);
    return res;
  }

  Future<Driver?> getDriver() async {
    if (driver_id == null) {
      return null;
    }
    var human = await FirestoreService.getDriver(driver_id!);
    return human;
  }

  Future<Vehicle?>getVehicle()async{
    
    var vv = await FirestoreService.getShortVehicle(vehicle_id!);
    return vv;
  }

    factory Ride.fromJson(Map<String,dynamic>json,[String?id]){
      return Ride(
        driver_id: json['driver_id']??'',
        date: json['date']??'', 
        origin: json['origin']??'', 
        destination: json['destination']??'', 
        fare: json['fare']??0.0, 
        vehicle_id: json['vehicle_id']??'',
        join: (json['join'] as List<dynamic>?)?.map((e)=>e.toString()).toList(),
         like: (json['like'] as List<dynamic>?)?.map((e)=>e.toString()).toList(),
         cancel: (json['cancel'] as List<dynamic>?)?.map((e)=>e.toString()).toList(),
        id:id);
    }

    toJson(){
      return{
        'date':date,
        'origin':origin,
        'destination':destination,
        'id':id,
        'driver_id':driver_id,
        'vehicle_id':vehicle_id,
        'fare':fare,
        'join':join,
        'like':like,
        'cancel':cancel
      };
    }
}