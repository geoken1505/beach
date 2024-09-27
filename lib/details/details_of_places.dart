import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:yui/constant/contstant.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetails extends StatefulWidget {
  const PlaceDetails({super.key, required this.title, required this.subtitle, required this.img, required this.lat, required this.long, required this.mapLink});
  final String lat;
  final String long;
  final String img;
  final String title;
  final String subtitle;
  final String mapLink;
  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  String image_path='assets/images.cloudy-day.png';
  String weather_cond='Default';
  @override
  Widget build(BuildContext context) {
    double device_width=MediaQuery.of(context).size.width;
    Future<List<Live_feeds>> ReadJsonData() async {

      var url =
          "https://api.openweathermap.org/data/2.5/onecall?lat="+widget.lat+"&lon="+widget.long+"&appid=bae28df78f81c27a2be7a7e3f1ef3c4e";

      var response = await http.post(Uri.parse(url));
      print(url);
      print(response.body);

      // Decode the response as a Map
      final Map<String, dynamic> data = json.decode(response.body.toString());

      // Access the 'hourly' list from the JSON response
      if (data.containsKey('hourly')) {

        final List<dynamic> hourlyList = data['hourly'];

        // Map the 'hourly' list to Live_feeds objects
        return hourlyList.map((e) => Live_feeds.fromJson(e)).toList();

      } else {

        throw Exception('Expected hourly list in the response');
      }
    }

    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.centerRight,
        height: 78,
        width: device_width,
        color: Colors.black.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.only(right: 18.0, bottom: 5),
          child: GestureDetector(
            onTap: () async {
              await launchUrl(Uri.parse(widget.mapLink));
              print(widget.mapLink);
            },
            child: Container(
              alignment: Alignment.center,
              height: 48,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kPrimaryColor
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.map_14, color: Colors.white,),
                  SizedBox(width: 5,),
                  Text('Map', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Poppins'),)
                ],
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (_, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            var items = snapshot.data as List<Live_feeds>;
            weather_cond=items.isNotEmpty ? items[0].title ?? "" : "assets/images.cloudy-day.png";
            if(weather_cond=='Rain'){
              image_path='assets/images/rainy-day.png';
            }
            else if(weather_cond=='Mist'){
              image_path='assets/images/fog.png';
            }
            else if(weather_cond=='Clouds'){
              image_path='assets/images/clouds.png';
            }
            else {
              image_path='assets/images/cloudy-day.png';
            }
            return Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 58.0, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 250,
                        ),
                        Positioned(
                          top: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(widget.img, height: 200, width: device_width-50, fit: BoxFit.cover,),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          child: Container(

                            height: 200, width: device_width-50,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius:  BorderRadius.circular(20),
                            ),

                          ),
                        ),
                        Positioned(
                            top: 0,
                            child: Image.asset(image_path, height: 120, width: 120,)),
                        Positioned(
                          right: 40,
                          bottom: 60,
                          child: Container(
                            child: Text(
                              items.isNotEmpty && items[0].video_id != null
                                  ? (double.tryParse(items[0].video_id!) != null
                                  ? '${(double.parse(items[0].video_id!) - 273.15).toStringAsFixed(2)}°'
                                  : "Invalid data") // Convert to Celsius if valid
                                  : "No data available",
                              style: TextStyle(color: Colors.white, fontSize: 50, fontFamily: 'Poppins'),
                            )
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.centerLeft,
                        child: Text(widget.title, style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 20),)),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.subtitle, style: TextStyle(color: Colors.grey, fontFamily: 'Poppins', fontSize: 14),)),
                    SizedBox(height: 15,),
                    Divider(),
                    SizedBox(height: 15,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Weather', style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14),)),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Wind', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Poppins'),),
                            SizedBox(height: 2,),
                            Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child: Image.asset('assets/images/wind.png', height: 40, width: 40, ),
                            ),
                            SizedBox(height: 2,),
                            Text(items.isNotEmpty ? items[0].date.toString()+" m/sec" ?? "" : "No data available", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Poppins'),),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Humidity', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Poppins'),),
                            SizedBox(height: 2,),
                            Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child: Image.asset('assets/images/humidity.png', height: 40, width: 40, ),
                            ),
                            SizedBox(height: 2,),
                            Text(items.isNotEmpty ? items[0].month.toString()+" %" ?? "" : "No data available", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Poppins'),),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Pressure', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Poppins'),),
                            SizedBox(height: 2,),
                            Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child: Image.asset('assets/images/fresh-air.png', height: 40, width: 40, ),
                            ),
                            SizedBox(height: 2,),
                            Text(items.isNotEmpty ? items[0].desc.toString()+" hPa" ?? "" : "No data available", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Poppins'),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Divider(),
                    SizedBox(height: 15,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Activities', style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14),)),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Image.asset('assets/images/surfing.png', height: 40, width: 40, ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Image.asset('assets/images/boat.png', height: 40, width: 40, ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Image.asset('assets/images/fishing.png', height: 40, width: 40, ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Image.asset('assets/images/scuba.png', height: 40, width: 40, ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
            // return Center(child: Text(items.isNotEmpty ? items[0].title ?? "" : "No data available", style: TextStyle(color: Colors.black),));

          } else {

            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}

class Live_feeds {

  String? title;
  String? subtitle;
  String? video_id;
  String? date;
  String? month;
  String? desc;

  Live_feeds(
      this.title, this.subtitle, this.date, this.video_id, this.month, this.desc);

  // Updated constructor to map the fields based on the hourly weather response
  Live_feeds.fromJson(Map<String, dynamic> json) {
    date      = json['wind_speed'].toString();           // For simplicity, using 'dt' as date
    title     = json['weather'][0]['main'];      // Access weather's 'main' field
    subtitle  = json['weather'][0]['description'];  // Access weather's description
    desc      = json['pressure'].toString();      // Using 'icon' as an example
    video_id  = json['temp'].toString();         // Using 'temp' as an example field
    month     = json['humidity'].toString();     // Using 'humidity' as an example field
  }
}
