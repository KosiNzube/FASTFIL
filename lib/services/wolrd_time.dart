import 'dart:convert';

class WorldTime{
  String location;
  String time;
  String flag;
  String url;


  WorldTime(this.location, this.time, this.flag, this.url);

  Future<void> getData() async{

    /*
   String x= await Future.delayed(Duration(seconds: 3),(){

     return "x";
    });

     */
    DateTime bow=DateTime(2010);

  }

}