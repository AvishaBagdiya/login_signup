import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:login_signup/widget/round_button.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class OtpPage extends StatefulWidget {
  OtpPage({this.text});
  final String text;
  static const String id = 'otp_screen';
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade300,
        body: Column(
          children: [
            Expanded(child: Image.asset('images/login-logo.png')),
            Expanded(
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50.0)),
                  color: Colors.white,
                ),
                width: 343,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 150.0),
                          child: Text(
                            "Verify with OTP\n",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 200.0),
                          child: Text("Enter OTP\n"),
                        ),
                        OTPTextField(
                          length: 4,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: 40,
                          style: TextStyle(fontSize: 20),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.box,
                          onCompleted: (pin) {
                            text=pin;
                          }
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RoundButton(
                          color: Colors.blue,
                          text: 'Verify OTP',
                          onPressed: (){
                            finalScreen(text);
                          },
                          //onPressed: ,
                        ),
                      ],
                    ),
                  ),
                ),

              ),
            ),

          ],
        ));
  }

  finalScreen(String pin)async {
    Map data = {
      "mobile": widget.text.toString(),
      "otp": pin.toString(),
      "deviceToken": "ez6IQF0SByp2KY4eAQHD8KhDJpaVUoe4",
      "deviceType": "A"
    };
    var jsonData = null;
    var response =
        await http.post('http://54.164.251.83:8081/user/verifyotp', body: data);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body.toString());
      print(jsonData);
    }
    else{
      print(response.body);
    }
  }
}
