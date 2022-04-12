import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var t;
    var city = ["Mumbai", "Delhi", "Agra", "Chennai", "London", "Goa"];
    final x = new Random();
    var randcity = city[x.nextInt(city.length)];
    //getting data from the loading activity in the form of map.
    var info = ModalRoute.of(context)!.settings.arguments
        as Map; //info hold the api data.
    if (info["iconImg"] == "NA.......") {
      t = "10d";
    } else {
      t = info["iconImg"];
    }
    //print(info["city_name"]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(0),
      //   child: AppBar(
      //     backgroundColor: Colors.blue,
      //   ),
      // ),Method 2 for the gradient task bar...
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: NewGradientAppBar(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Color.fromARGB(255, 144, 202, 249)])),
      ),
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue,
            Color.fromARGB(255, 149, 200, 243),
          ],
        )),
        child: Column(children: [
          Container(
            //Search container
            //color: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
                color: Color.fromARGB(125, 255, 255, 255),
                borderRadius: BorderRadius.circular(24)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    //print(searchController.text);
                    if ((searchController.text).replaceAll(" ", "") == "") {
                      print("Blank search");
                    } else {
                      Navigator.pushReplacementNamed(context, "/loading", arguments: {
                        "search": searchController.text.toString()
                      });
                    }
                  },
                  child: Container(
                    child: Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    ),
                    margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search $randcity",
                    ),
                  ),
                )
              ],
            ),
          ),
          //below search bar...
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      //Icon() instead of icon we will use image of the city provided by the api
                      Image.network(
                          "http://openweathermap.org/img/wn/${t}@2x.png"),

                      SizedBox(
                        width: 30,
                      ),

                      Column(
                        children: [
                          Text("${info["desc"]}",
                              style: GoogleFonts.acme(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("In ${info["city_name"]}",
                              style: GoogleFonts.acme(
                                  fontSize: 16, fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(WeatherIcons.thermometer),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${info["temp_value"]!.substring(0, 4)}",
                              style: GoogleFonts.acme(
                                  fontSize: 90, fontWeight: FontWeight.bold)),
                          Text("c",
                              style: GoogleFonts.acme(
                                  fontSize: 16, fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.fromLTRB(25, 0, 10, 0),
                  padding: EdgeInsets.all(22),
                  height: 150,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.day_windy),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${info["air_speed_value"]}",
                          style: GoogleFonts.acme(
                              fontSize: 35, fontWeight: FontWeight.bold)),
                      Text("mph")
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.fromLTRB(10, 0, 25, 0),
                  padding: EdgeInsets.all(22),
                  height: 150,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.humidity),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("${info["hum_value"]}",
                          style: GoogleFonts.acme(
                              fontSize: 35, fontWeight: FontWeight.bold)),
                      Text("Percent")
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: const Text(
                  "                  Made by Chandra\nData provided by openweathermap.org"))
        ]),
      )),
    );
  }
}
