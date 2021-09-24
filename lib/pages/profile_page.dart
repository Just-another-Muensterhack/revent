import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget{
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(body: Container(child: Column(children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 50, left: 50, bottom: 10),
        child: Row(children: <Widget>[

        ],),
      ),
      Container(width: size.width * 0.8,
        decoration: BoxDecoration(color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(25)),
        child: Row(children: <Widget>[
          Padding(padding: EdgeInsets.all(15), child: CircleAvatar(radius:50, backgroundImage:
          NetworkImage("https://www.appmanufacture.ch/wp-content/uploads/2016/10/2_small.png"),
          ),),
          Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 15), child: Text("Max", style:  TextStyle(
              fontSize: 18,
              color: Colors.white
            ),),),
            Padding(padding: EdgeInsets.only(bottom: 15), child: Text("Mustermann", style: TextStyle(
              fontSize: 18,
              color: Colors.white
            ),),),
          ],),
          Padding(padding: EdgeInsets.only(left: 15,), child: IconButton(onPressed: (){

            }, icon: Icon(Icons.qr_code)),)
        ],
      )),
    ])));
  }
}