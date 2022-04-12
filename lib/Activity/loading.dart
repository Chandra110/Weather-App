import 'package:flutter/material.dart';
import 'package:mausam_app/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


String? temp;
String? hum;
String? air_speed;
String? des;
String? main;
String? iconImg;
String? city = "Tundla";
String? description;


void startApp(String? city) async
{
  worker instance  = worker(location: city);
  await instance.getData();

  if(instance.temperature != "NA......."){
    temp = (instance.temperature - 273.15).toString();
  }else{
    temp = "NA.......";
  }
  
  hum = instance.Humidity.toString();
  air_speed = instance.airSpeed.toString();
  des = instance.desc.toString();
  main = instance.location.toString();
  iconImg = instance.iconImg.toString();
  description = instance.description.toString();

  Navigator.pushReplacementNamed(context, "/home",arguments: {
      "temp_value" : temp,
      "hum_value" : hum,
      "air_speed_value" : air_speed,
      "des_value" : des,
      "main_value" : main,
      "iconImg" : iconImg,
      "city_name": city,
      "desc" : description
      });
  }

  @override
  void initState() {
    // startApp();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    print("Loading Disposed");
  }

  @override
  Widget build(BuildContext context) {

    var cityName = ModalRoute.of(context)!.settings.arguments as dynamic;
    if(cityName?.isNotEmpty??false){
      city = cityName["search"];
    }
    startApp(city);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Image.asset("assets/images/weather_logo.png",width: 200,height: 200,),
            ),
            Text("Mausam App",style: GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 30,color: Colors.white),),
            SizedBox(height: 35,),
            
            SpinKitWave(
              color: Colors.yellow[400],
              size: 50.0,
            ),
            SizedBox(height: 35,),
            Text("Created by Chandra",style: GoogleFonts.robotoMono(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.white),)
          ],
        ),
      ),
      backgroundColor: Colors.orange[300],
    );
  }
}