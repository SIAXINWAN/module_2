import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02_day2/models/ride.dart';
import 'package:mobile_wsmb2024_02_day2/widgets/fareCard.dart';

class FarePageTab extends StatelessWidget {
  const FarePageTab({super.key, required this.rideList});
  final List<Ride>rideList;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context)=>FarePage(rideList:rideList));
      },
    );
  }
}

class FarePage extends StatefulWidget {
  const FarePage({super.key, required this.rideList});
  final List<Ride>rideList;

  @override
  State<FarePage> createState() => _FarePageState();
}

class _FarePageState extends State<FarePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Total Fare',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: FareCard(rideList:widget.rideList))
          ],
        ),
      ),
    );
  }
}