import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:login_signup/screens/otp.dart';
import 'package:login_signup/widget/round_button.dart';
import 'package:login_signup/screens/otp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController text=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade300,
        body: Column(
          children: [
            Expanded(child: Image.asset('images/login-logo.png'),),
            Expanded(child: Container(
              height: 200,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.0)),
                color: Colors.white,
              ),
              width: 343,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 43.0),
                        child: Text("Proceed with your login", style: TextStyle(
                            fontSize: 25),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 185.0),
                        child: Text("Login", style: TextStyle(fontSize: 50,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,),),
                      ),
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset('images/enter-mobile-no-icon-box.png',
                              height: 100.0,),
                            VerticalDivider(color: Colors.grey.shade800,),
                            Expanded(
                              child: TextField(
                                controller: text,
                                decoration: InputDecoration(
                                    hintText: 'Enter mobile number'
                                ),
                              ),
                            ),
                          ],
                        )
                        ,
                      ),
                      Text("\n"),
                      Text(
                          "A 4 digits OTP will send you via SMS to verify your mobile number!"),
                      SizedBox(
                        height: 20.0,
                      ),
                      RoundButton(
                        onPressed: () {
                          nextpage(text.text.toString());
                        },
                        color: Colors.blue,
                        text: 'Send OTP',
                      ),
                    ],
                  ),
                ),
              ),

            ),
            ),

          ],
        )


    );
  }

  void nextpage(String value) async {
    Map data = {
      "mobile": value,
    };
    var jsonData = null;
    var response =
    await http.post('http://54.164.251.83:8081/user/login', body: data);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body.toString());
      print(jsonData);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>OtpPage(text:value)));
    }
    else{ print(response.body);
    print(text);}
  }
}