import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yui/constant/contstant.dart';
import 'package:yui/login/login_model_appwrite.dart';
import 'package:yui/login/otp_verification.dart';
import 'package:yui/ui/button_ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mobNumber=TextEditingController();
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
                    TextSpan(text: "Welcome", style: TextStyle(color: kPrimaryColor, fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 42) ),
                    TextSpan(text: "\nback!!!", style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 42) ),
                  ]
                )
            ),
            Text('Sign in to access your tavel plans and get real-time updates', style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),),
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
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text('+91', style: TextStyle(fontSize: 18, color: Colors.black, ),),
                  SizedBox(width: 10,),
                  Text('|', style: TextStyle(fontSize: 33, color: kPrimaryColor),),
                  SizedBox(width: 10,),
                  Expanded(
                      child: TextFormField(
                        controller: _mobNumber,
                          decoration: InputDecoration(border: InputBorder.none, hintText: 'Phone', hintStyle: TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Proxima", fontWeight: FontWeight.w300)),
                          keyboardType: TextInputType.phone,
                          onChanged: (value){
                            if(value.length>=10){
                              FocusScope.of(context).unfocus();
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ]
                      )
                  )
                ],
              ),
            ),
            SizedBox(height: 8,),
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
                print(_mobNumber.text);
                var result = await checkUserExist(mobile: "+91"+_mobNumber.text);
                var userId= await sendOTPToVerify(mobile: "+91"+_mobNumber.text, userstate: result);
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>OTPVerificationScreen(userId: userId, mobNumber: '91'+_mobNumber.text, userState: result,)));
                print("got result is "+result);  // This will print the returned value from sendOTPToVerify()
              },
              child: ButtonUi(text: 'Submit'),
            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
