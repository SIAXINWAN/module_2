import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02_day2/models/driver.dart';
import 'package:mobile_wsmb2024_02_day2/models/ride.dart';
import 'package:mobile_wsmb2024_02_day2/models/rider.dart';
import 'package:mobile_wsmb2024_02_day2/pages/fare/farePage.dart';
import 'package:mobile_wsmb2024_02_day2/pages/profile/profilePage.dart';
import 'package:mobile_wsmb2024_02_day2/pages/ride/rideList.dart';
import 'package:mobile_wsmb2024_02_day2/pages/startPage.dart';
import 'package:mobile_wsmb2024_02_day2/services/firestoreService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.rideList, required this.rider, required this.driverList, });
  final Rider rider;
  final List<Ride>rideList;
  final List<Driver>driverList;
  
 

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
late List<Widget>tabs = [];





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getRideList();
    tabs= [
      
      RideListTab(rideList: widget.rideList,driverList: widget.driverList,rider:widget.rider),
      FarePageTab(rideList: widget.rideList,),
      ProfilePageTab(rider: widget.rider,)

    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
           backgroundColor: Colors.greenAccent,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('KONGSI KERETA'),
              GestureDetector(
                onTap: ()async{
                  await showDialog(context: context, builder: (context)=>AlertDialog(
                    title: Center(child: Text('Log Out?')),
                    content: Text('Do you want to log out?'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text('No')),
                      TextButton(onPressed: ()async{
                        await Driver.signOut();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StartPage()));
                      }, child: Text('Yes')),
                    ],
                  ));
                },
                child: CircleAvatar(backgroundImage: NetworkImage(widget.rider.image!),))
            ],
          ),
        ),
        body: IndexedStack(
          children: tabs,
          index: currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.car_rental), label: 'Ride'),
                   BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money), label: 'Fare'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.edit), label: 'Edit Profile'),
            ]),
      ),
    );
  }
}
