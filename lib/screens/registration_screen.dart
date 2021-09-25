import 'package:chat/constants.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final _auth = FirebaseAuth.instance;

class RegistrationScreen extends StatefulWidget {
  static const String id = "/registration";
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = "";
  String password = "";
  String errorText = "";
  bool isLoading = false;

  void handleRegister() async {
    setState(() {
      isLoading = true;
    });
    if (email != "" && password != "") {
      setState(() {
        errorText = "";
      });
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, ChatScreen.id);
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
          if (e.code == 'weak-password') {
            errorText = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            errorText = 'The account already exists for that email.';
          }
        });
      } catch (e) {
        print(e);
      }
    } else {
      setState(() {
        errorText = "Both fields are required.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration:
                    kInputecoration.copyWith(hintText: "Enter Your Email."),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration:
                    kInputecoration.copyWith(hintText: "Enter Your Password."),
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomButton(
                color: Colors.blueAccent,
                onTap: () {
                  handleRegister();
                },
                text: "Register",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
