import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02_day2/models/driver.dart';
import 'package:mobile_wsmb2024_02_day2/models/ride.dart';
import 'package:mobile_wsmb2024_02_day2/models/rider.dart';
import 'package:mobile_wsmb2024_02_day2/pages/ride/rideDetails.dart';
import 'package:mobile_wsmb2024_02_day2/services/firestoreService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RideCard extends StatefulWidget {
  const RideCard({super.key, required this.ride, required this.driver,});
  final Ride ride;
  final Driver driver;
 

  @override
  State<RideCard> createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {
  Rider?rider;
  bool joined = false;
  bool liked = false;
  bool cancelled = false;
 

void updateIsJoin()async{
    var id = await Rider.getRiderByToken();
    
    joined = widget.ride.join.contains(id?.id??'');
    
        
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateIsJoin();
  }

  

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: MediaQuery.sizeOf(context).height *0.385,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 227, 184, 235),
          border: Border.all(width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Origin',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Destination',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Fare',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Date Time',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                       
                       Text(
                        'Driver',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Gender',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Phone',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ': ${widget.ride.origin}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ': ${widget.ride.destination}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ': RM${widget.ride.fare}.00',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ': ${widget.ride.date.toString().replaceRange(16, null, '')}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                     
                      Text(
                        ': ${widget.driver.name}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ': ${widget.driver.gender?'Male':'Female'}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ': ${widget.driver.phone}',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    // Container(
      
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30),
                    //     color: Colors.white),
                    //   child: MaterialButton(
                    //       onPressed: () async {
                    //         await FirestoreService.deleteRide(widget.ride.id ?? '');
                    //       },
                    //       child: Text('Cancle')),
                    // ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      RideDetails(ride: widget.ride,driver: widget.driver,)));
                            },
                            child: Text("Details")),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
