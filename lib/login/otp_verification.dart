import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:yui/login/login_model_appwrite.dart';
import 'package:yui/registration/register.dart';
import 'package:yui/sreen/homeScreen.dart';
import 'package:yui/ui/button_ui.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key, required this.userId, required this.mobNumber, required this.userState});
  final String mobNumber;
  final String userId;
  final String userState;
  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController otp_entered=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                controller: otp_entered,
                obscureText: false,
                keyboardType: TextInputType.number,
                length: 6,
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () async {
                  print(widget.mobNumber);
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>HomeScreen()));
                  var result= await verifyOTP(secret: otp_entered.text, mobile: widget.mobNumber, userId: widget.userId);
                  print(result);
                  if(result){

                    if(widget.userState=='user_not_found'){
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>RegistrationScreen(mobNumber: widget.mobNumber, userId: widget.userId,)));
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>HomeScreen()));
                    }
                  }
                  else{
                    print("Invalid OTP");
                  }
                },
                child: ButtonUi(text: 'Verify'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
