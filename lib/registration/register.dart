import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yui/login/login_model_appwrite.dart';
import 'package:yui/sreen/homeScreen.dart';

import '../constant/contstant.dart';
import '../ui/button_ui.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key, required this.mobNumber, required this.userId});
  final String mobNumber;
  final String userId;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _name=TextEditingController();
  TextEditingController _email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 80, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text:TextSpan(
                    children: [
                      TextSpan(text: "Sign up", style: TextStyle(color: kPrimaryColor, fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 42) ),
                    ]
                )
            ),
            Text('Sign up to access your tavel plans and get real-time updates', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),),
            SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              height: 55,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: TextFormField(
                  controller: _name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name', hintStyle:
                    TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Proxima", fontWeight: FontWeight.w300)),
                    keyboardType: TextInputType.name,
                ),
              ),
            ),
            SizedBox(height: 8,),
            Container(
              alignment: Alignment.center,
              height: 55,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: kPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email', hintStyle:
                  TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Proxima", fontWeight: FontWeight.w300)),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            SizedBox(height: 10,),
            RichText(
              maxLines: 2,
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: "By continuing, you agree to our ",
                      style: TextStyle(color: Colors.black,fontFamily: 'Poppins', fontSize: 14, overflow: TextOverflow.ellipsis,),
                    ),
                    TextSpan(
                      text: "Terms and Conditions",
                      style: TextStyle(color: Colors.blue,fontFamily: 'Poppins', fontSize: 14, overflow: TextOverflow.ellipsis,),
                      // recognizer: TapGestureRecognizer()..onTap = ()  {
                      //   // Single tapped.
                      //   Navigator.push(context, MaterialPageRoute(builder: (builder)=>TermsAndConditions()));
                      // },
                    ),
                    TextSpan(
                      text: " & ",
                      style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14,  overflow: TextOverflow.ellipsis,),
                    ),
                    TextSpan(
                      text: "Privacy policy",
                      style: TextStyle(color: Colors.blue, fontFamily: 'Poppins', fontSize: 14,  overflow: TextOverflow.ellipsis,),
                      // recognizer: TapGestureRecognizer()..onTap = () {
                      //   // Single tapped.
                      //   Navigator.push(context, MaterialPageRoute(builder: (builder)=>PrivacyPolicy()));
                      // },
                    ),
                  ]
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () async {
                var result= await saveUserDataToDB(
                  userId: widget.userId,
                  mobile: widget.mobNumber,
                  name: _name.text,
                  emailAddress: _email.text, );
                if(result){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>HomeScreen()));
                }
                print(result);
              },
              child: ButtonUi(text: 'Sign Up'),
            ),

          ],
        ),
      ),
    );
  }
}
