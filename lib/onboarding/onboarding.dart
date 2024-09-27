import 'package:flutter/material.dart';
import 'package:yui/constant/contstant.dart';
import 'package:yui/login/login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 18, right: 18),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=>LoginPage()));
          },
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width-60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 3),
                  blurRadius: 6
                )
              ]
            ),
            alignment: Alignment.center,
            child: Text('Get Started', style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                fontFamily: "Poppins",
                color: Colors.white
          
            ),),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset("assets/images/image.png"),
          Text('Easy way to \nplan your travel \nwith us!', style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 36,
            fontFamily: "Poppins"

          ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8,),
          Text('Get calamities alerts, real-time recommendation and many more.', style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              fontFamily: "Poppins",
            color: Colors.grey

          ),
            textAlign: TextAlign.center,
          ),

        ],
      )
    );
  }
}
