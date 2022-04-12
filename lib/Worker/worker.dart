import 'dart:convert';
import 'package:http/http.dart';
class worker{
  var location;
  worker({this.location});
  var temperature;//We will get it in double but while writing it to the display it needs to be in String
  var Humidity;
  var airSpeed;
  var desc;
  var lat,lon;
  var iconImg;
  var description;
/*
from loading we will call getData() wait for it to execute completely.
*/
  Future<void> getData() async{

    try{
      Response coordinates = await get(Uri.parse("http://api.openweathermap.org/geo/1.0/direct?q=$location&limit=5&appid=100486518fadd9c5aa1e331bcdfed8fc"));
    var data = jsonDecode(coordinates.body);
    // print("Location data");
    // print(data);
    lat = data[0]["lat"];
    lon = data[0]["lon"];
    //var localName = data[0]["local_names"];
    //location = localName["hi"];
    Response currentClimate = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=100486518fadd9c5aa1e331bcdfed8fc"));
    var climateData = jsonDecode(currentClimate.body);
    // print("Climate Data\n");
    // print(climateData);
    temperature = climateData["main"]["temp"];
    Humidity = climateData["main"]["humidity"];
    airSpeed = climateData["wind"]["speed"];
    desc = climateData["weather"][0]["description"];
    iconImg = climateData["weather"][0]["icon"];
    description = climateData["weather"][0]["description"];
    }catch(e){
      temperature = "NA.......";
    Humidity ="NA.......";
    airSpeed = "NA.......";
    desc = "NA.......";
    iconImg = "NA.......";
    description = "NA......";
    }


    
  }
}

