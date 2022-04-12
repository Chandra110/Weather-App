import 'package:flutter/material.dart';
import 'package:mausam_app/Activity/home.dart';
import 'package:mausam_app/Activity/loading.dart';
import 'package:mausam_app/Activity/location.dart';


void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: Home(),
    routes: {
      "/home" : (context) => Home(),
      "/" : (context) => Loading(),
      "/loading" :(context) => Loading()
    },
  ));
}


// class SomeWidget extends StatelessWidget {
//   var name;
//   var age;
//   SomeWidget({this.name,this.age});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text("hello I am $name and i am $age years old"),
//     );
//   }
// }
