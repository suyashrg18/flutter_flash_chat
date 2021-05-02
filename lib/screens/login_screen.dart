import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/customwidgets/flashbutton.dart';
import 'package:flutter_flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flash_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email,password;
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showProgress,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Hero(
          tag: 'flashimage',
            child: Container(
            height: 200.0,
            child: Image.asset('images/logo.png'),
          ),
        ),
        SizedBox(
          height: 48.0,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.center,
          onChanged: (value) {
            email = value;
          },
          decoration:kTextFieldDecoration.copyWith(
            hintText: 'Enter email'
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        TextField(
          textAlign: TextAlign.center,
          obscureText: true,
          onChanged: (value) {
          password = value;
          },
          decoration: kTextFieldDecoration.copyWith(
              hintText: 'Enter password'
          ),
        ),
        SizedBox(
          height: 24.0,
        ),
        Hero(
          tag: 'loginbtn',
          child: FlashButton(color:Colors.lightBlueAccent,function: () async{
            try {
              setState(() {
                showProgress = true;
              });
              final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
              if(user != null){
                setState(() {
                  showProgress = false;
                });
                Navigator.pushNamed(context, ChatScreen.id);

              }
            }catch(e){
              print(e);
            }

          },text:'Log In') ,
        ),
        ],
    ),),
      )
    ,
    );
  }
}