import 'dart:io';


import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02_day2/models/driver.dart';
import 'package:mobile_wsmb2024_02_day2/models/ride.dart';
import 'package:mobile_wsmb2024_02_day2/models/rider.dart';
import 'package:mobile_wsmb2024_02_day2/services/firestoreService.dart';

class RideDetails extends StatefulWidget {
  const RideDetails({
    super.key,
    required this.ride,
    required this.driver,
  });
  final Ride ride;
  final Driver driver;

  @override
  State<RideDetails> createState() => _RideDetailsState();
}

class _RideDetailsState extends State<RideDetails> {
  Rider? rider;
  bool inactive = false;

  @override
  void initState() {
    super.initState();
    getRider();
    checkStatus();
  }

  void getRider() async {
    rider = await Rider.getRiderByToken();
  }

  bool joined = false;
  bool liked = false;
  bool cancelled = false;

  void checkStatus() async {
    rider = await Rider.getRiderByToken();
    joined = widget.ride.join.contains(rider?.id ?? '');
    liked = widget.ride.like.contains(rider?.id ?? '');
    cancelled = widget.ride.cancel.contains(rider?.id ?? '');
    setState(() {});
    final now = DateTime.now();
    final rideDate = DateTime.parse(widget.ride.date);
        if(rideDate.isBefore(now)){
          setState(() {
            inactive = true;
          });
    
  }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Center(
            child: Column(children: [
          Text('Ride Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(width: 1)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Origin',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Destination',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Fare',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Date Time',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.start,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              ': ${widget.ride.origin}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ': ${widget.ride.destination}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ': RM${widget.ride.fare}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ': ${widget.ride.date.toString().replaceRange(16, null, '')}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: InteractiveViewer(
                                      panEnabled: true,
                                      minScale: 0.5,
                                      maxScale: 3.0,
                                      child: Image.network(
                                          widget.driver.image.toString()),
                                    ),
                                  ),
                                );
                              },
                              child: Center(
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      widget.driver.image.toString()),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text('<< Click me to see driver image',style: TextStyle(fontSize: 16),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
              Container(
                width: 280,
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Driver',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Gender',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Phone',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Address',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ': ${widget.driver.name}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ': ${widget.driver.gender ? 'Male' : 'Female'}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ': ${widget.driver.phone}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ': ${widget.driver.email}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ': ${widget.driver.address}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: 
            
            (inactive == false)?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: (cancelled != false )
                        ? Center(
                            child: ElevatedButton(
                                onPressed: () async {
                                  var res = await FirestoreService.uncancelRide(
                                      widget.ride, rider!);
                                  if (!res) {
                                    return;
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.cancel)),
                          )
                        : Center(
                            child: ElevatedButton(
                                onPressed: () async {
                                  var res = await FirestoreService.cancelRide(
                                      widget.ride, rider!);
                                  if (!res) {
                                    return;
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.cancel_outlined)))),
                Container(
                    child: (liked != false )
                        ? ElevatedButton(
                            onPressed: () async {
                              var res = await FirestoreService.unlikeRide(
                                  widget.ride, rider!);
                              if (!res) {
                                return;
                              }
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.favorite))
                        : ElevatedButton(
                            onPressed: () async {
                              var res = await FirestoreService.likeRide(
                                  widget.ride, rider!);
                              if (!res) {
                                return;
                              }
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.favorite_border))),
              ],
            ):Container(),
          ),
          (inactive == false)?
          (joined != false )
              ? Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        var res = await FirestoreService.unjoinRide(
                            widget.ride, rider!);
                        if (!res) {
                          return;
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text('Unjoin')),
                )
              : Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        var res = await FirestoreService.joinRide(
                            widget.ride, rider!);
                        if (!res) {
                          return;
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text('Join')),
                )
        :Container()])));
  }
}
