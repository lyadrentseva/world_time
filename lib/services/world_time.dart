import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime{

  String location; // location name for the UI
  String time = 'could not get date' ; // the time in the location
  String flag; // urk to an assets flag icon
  String url; //location url for api endpoint
  bool isDayTime = true; //true - if day, false if night

  WorldTime({required this.location, required this.flag, required this.url});


  Future <void> getTime() async {

    try{

      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get property from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);

      //create datetme object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDayTime =  now.hour>6 && now.hour <20 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch(e){
      print('an error $e');
      time = 'could not get date';


    }


  }


}





