import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yui/details/details_of_places.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List images=[
    "assets/images/juhu-1.jpg",
    "assets/images/baga.jpg",
    "assets/images/kovalam.jpg",
    "assets/images/rhada.jpg",
  ];
  List lat=[
    "19.1048",
    "15.5553",
    "8.3838",
    "11.9845",
  ];
  List long=[
    "72.8267",
    "73.7517",
    "76.9804",
    "92.9508",
  ];
  List mapping=[
    "https://maps.app.goo.gl/P674taUjwBKX1JD66",
    "https://maps.app.goo.gl/zVuHuWXnenJjLaZFA",
    "https://maps.app.goo.gl/YfguDuHHnaUvu9hY9",
    "https://maps.app.goo.gl/jHK5Yii2msc4e97VA",
  ];
  List title=[
    "Juhu Beach",
    "Baga Beach",
    "Kovalam Beach",
    "Radhanagar Beach",
  ];
  List subtitle=[
    "Mumbai",
    "Goa",
    "Kerala",
    "Andaman",
  ];
  List ratings=[
    "Rating 4.5",
    "Rating 4.3",
    "Rating 4.4",
    "Rating 4.6",
  ];
  @override
  Widget build(BuildContext context) {
    double devie_width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Morning'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 50,
                width: devie_width-40,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Iconsax.search_normal, color: Colors.black,),
                    hintText: 'Search',
                  ),
                )
              ),
              SizedBox(height: 8,),
              Container(
                width: devie_width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>PlaceDetails(
                            title: title[index],
                            subtitle: subtitle[index],
                            img: images[index],
                            lat: lat[index],
                            long: long[index],
                            mapLink: mapping[index],
                          )));
                        },
                        child: Container(
                          height: 120,
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(images[index], height: 100, width: 100, fit: BoxFit.cover,),
                              ),
                              SizedBox(width: 10,),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(title[index], style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poppins'),),
                                    Text(subtitle[index],style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Poppins'),),
                                    Text(ratings[index], style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Poppins'),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
