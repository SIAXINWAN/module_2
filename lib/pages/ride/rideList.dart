import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02_day2/models/driver.dart';
import 'package:mobile_wsmb2024_02_day2/models/ride.dart';
import 'package:mobile_wsmb2024_02_day2/models/rider.dart';
import 'package:mobile_wsmb2024_02_day2/pages/filter/record.dart';

import 'package:mobile_wsmb2024_02_day2/widgets/rideCard.dart';


class RideListTab extends StatelessWidget {
  const RideListTab({super.key, required this.rideList, required this.driverList, required this.rider});
  final List<Ride> rideList;
  final List<Driver>driverList;
  final Rider rider;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context)=>RideList(rideList: rideList, driverList: driverList,));
      },
    );
  }
}

class RideList extends StatefulWidget {
  const RideList({super.key, required this.rideList, required this.driverList});
  final List<Ride>rideList;
  final List<Driver>driverList;

  @override
  State<RideList> createState() => _RideListState();
}

class _RideListState extends State<RideList> {

   int selectedSegment = 0;
  List<Ride> filteredRides = [];

   @override
  void initState() {
    super.initState();
    filterRides();
  }

  void filterRides() async {
   

    setState(() {
  final now = DateTime.now();
  
  if (selectedSegment == 0) {
    filteredRides = widget.rideList
        .where((ride) {
          final rideDate = DateTime.parse(ride.date);
          return rideDate.isAfter(now);
        })
        .toList();
  } else if (selectedSegment == 1) {
    filteredRides = widget.rideList
        .where((ride) {
          final rideDate = DateTime.parse(ride.date);
          return rideDate.isBefore(now);
        })
        .toList();
  }});}


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
  
String keyword = '';
final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var filterList = filteredRides
        .where((e) =>
            e.origin.toLowerCase().contains(keyword.toLowerCase()) ||
            e.destination.toLowerCase().contains(keyword.toLowerCase())||e.fare.toString().toLowerCase().contains(keyword.toLowerCase())||e.date.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
    

    var list = widget.driverList.where((e)=>e.name.toLowerCase().contains(keyword.toLowerCase())||e.gender.toString().toLowerCase().contains(keyword.toLowerCase())||
    e.phone.toLowerCase().contains(keyword.toLowerCase())).toList();

    

    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex:3,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      
                      label: Text('Search'),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: searchController.text.isNotEmpty?IconButton(onPressed: (){
                  
                    searchController.clear();
                  
                           
                        
                       
                      }, icon: Icon(Icons.clear)):null
                    ),
                    onChanged: (String? value){
                     setState(() {
                        keyword = value!.trim();
                     });
                    },
                  )),
                Expanded(
                  flex:2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                    onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RecordPage(rideList: widget.rideList,driverList: widget.driverList,)));
                  }, child: Text('Record',style: TextStyle(color: Colors.white),),),
                )
              ],
            ),
            SizedBox(height: 40,),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  buildSegmentButton(0, 'Active'),
                   SizedBox(width: 5,),
                  buildSegmentButton(1, 'Inactive'),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: filteredRides.isEmpty
                  ? Center(child: Text('No rides found'))
                  : ListView.builder(
                      itemCount: (filterList.length>list.length)?list.length:filterList.length,
                      itemBuilder: (context, index) {
                        return RideCard(ride:filterList[index], driver: list[index]);
                      },
                    ),
            ),
            // Expanded(child: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ListView.builder(
            //     itemCount: (filterList.length>=widget.driverList.length)?widget.driverList.length:filterList.length,
            //     itemBuilder: (context,index){
            //       return RideCard(ride: filterList[index],
                  
            //       driver: widget.driverList[index],);
            //     }),
            // ))
          ],
        ),
      
    ));
  }
}