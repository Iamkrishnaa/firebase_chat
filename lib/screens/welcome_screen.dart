import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:chat/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "/welcome";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      "Flash Chat",
                      speed: const Duration(seconds: 1),
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            CustomButton(
              color: Colors.lightBlueAccent,
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              text: "Login",
            ),
            CustomButton(
              color: Colors.blueAccent,
              onTap: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: "Register",
            ),
          ],
        ),
      ),
    );
  }
}
