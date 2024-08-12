import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02_day2/models/driver.dart';
import 'package:mobile_wsmb2024_02_day2/models/rider.dart';
import 'package:mobile_wsmb2024_02_day2/models/vehicle.dart';
import 'package:mobile_wsmb2024_02_day2/widgets/driverCard.dart';
import 'package:mobile_wsmb2024_02_day2/widgets/riderCard.dart';
import 'package:mobile_wsmb2024_02_day2/widgets/vehicleCard.dart';
class ProfilePageTab extends StatelessWidget {
  const ProfilePageTab({super.key, required this.rider});
  final Rider rider;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
       return MaterialPageRoute(builder: (context)=>ProfilePage(rider :rider)) ;
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.rider});
final Rider rider;


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Edit Rider',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
         children: [
          
         RiderCard(rider: widget.rider),
        
          
         ],
        ),
      ),
    );
  }
}