import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02_day2/models/ride.dart';
import 'package:mobile_wsmb2024_02_day2/pages/ride/rideDetails.dart';

class FareCard extends StatefulWidget {
  const FareCard({super.key, required this.rideList});
  final List<Ride>rideList;

  @override
  State<FareCard> createState() => _FareCardState();
}

class _FareCardState extends State<FareCard> {

  int totalFare = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalFare();
  }

  void getTotalFare()async{
    totalFare = widget.rideList.fold(0, (sum, ride) => sum + ride.fare);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 171, 221, 245),
        border: Border.all(width: 1),
      ),
      child:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text('Fare',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            Expanded(
              child: Container(
                height:330,
                width: double.infinity,
                child: 
              ListView.builder(
                itemCount: widget.rideList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ride ${index+1} : From ${widget.rideList[index].origin} To ${widget.rideList[index].destination}'),
                            Text('Fare : RM ${widget.rideList[index].fare}.00',style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),),
            ),
            Text('Total Fare : RM '+totalFare.toString() +'.00',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
          
          ])));}
}