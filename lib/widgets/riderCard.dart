import 'package:flutter/material.dart';
import 'package:mobile_wsmb2024_02_day2/models/rider.dart';
import 'package:mobile_wsmb2024_02_day2/pages/profile/editRider.dart';

class RiderCard extends StatefulWidget {
  const RiderCard({super.key, required this.rider});
  final Rider rider;

  @override
  State<RiderCard> createState() => _RiderCardState();
}

class _RiderCardState extends State<RiderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.sizeOf(context).height*0.53,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 158, 215),
          border: Border.all(width: 1),
        ),
        child:  Column(
          children: [
              SizedBox(height: 15,),
            // Center(child: Text('Rider',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,decoration:TextDecoration.underline),)),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.rider.image.toString()),),
              SizedBox(height: 15,),
            Row(
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('IC',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('Gender',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('Phone',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('Email',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('Address',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                  Text(':   ${widget.rider.name}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                   Text(':   ${widget.rider.icno}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text(':   ${widget.rider.gender?'Male':'Female'}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                     Text(':   ${widget.rider.phone}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text(':   ${widget.rider.email}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                       Text(':   ${widget.rider.address}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  
                                ],
                              ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditRider(rider: widget.rider,)));
            }, child: Icon(Icons.edit))
          ],
        )
      ),
    );
  }
}