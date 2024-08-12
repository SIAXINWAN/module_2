import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02_day2/models/driver.dart';
import 'package:mobile_wsmb2024_02_day2/models/ride.dart';
import 'package:mobile_wsmb2024_02_day2/models/rider.dart';
import 'package:mobile_wsmb2024_02_day2/widgets/rideCard.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key, required this.rideList, required this.driverList});
  final List<Ride> rideList;
  final List<Driver>driverList;

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {

   int selectedSegment = 0;
  List<Ride> filteredRides = [];
  

  @override
  void initState() {
    super.initState();
    filterRides();
  }

  void filterRides() async {
    Rider? rider = await Rider.getRiderByToken();

    setState(() {
      if (selectedSegment == 0) {
        filteredRides = widget.rideList
            .where((ride) => ride.join.contains(rider?.id))
            .toList();
      } else if (selectedSegment == 1) {
        filteredRides = widget.rideList
            .where((ride) => ride.like.contains(rider?.id))
            .toList();
      }else if(selectedSegment ==2){
        filteredRides = widget.rideList
        .where((ride)=>ride.cancel.contains(rider?.id)).toList();
      }
    });
  }

  Widget buildSegmentButton(int index, String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedSegment = index;
            filterRides();
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selectedSegment == index ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selectedSegment == index ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Record')),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                buildSegmentButton(0, 'Joined'),
                SizedBox(width: 5),
                buildSegmentButton(1, 'Liked'),
                SizedBox(width: 5,),
                buildSegmentButton(2, 'Cancelled'),
                
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: filteredRides.isEmpty
                ? Center(child: Text('No rides found'))
                : ListView.builder(
                    itemCount: filteredRides.length,
                    itemBuilder: (context, index) {
                      return RideCard(ride:filteredRides[index], driver: widget.driverList[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}