import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_sky/views/auth/login_screen.dart';
import 'package:job_sky/views/auth/signup_screen.dart';
import 'package:job_sky/widgets/custom_buttons.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(systemOverlayStyle: SystemUiOverlayStyle.dark,backgroundColor: Colors.transparent,),
      body: SafeArea(
        child: Padding(

          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Title
              Text(
                'JobSky',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Spacer(),
              //Message
              Text(
                'Connecting people through shared opportunities.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
              ),
              SizedBox(height: 30),
              //Login Button
              CustomButton(
                buttonName: 'Continue with email',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen(),
                    ),
                  );

                },
              ),
              SizedBox(height: 15),
              //Signup Button
              CustomButton(
                buttonName: 'Sign up with email',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ),
                  );
                },
              ),
              Spacer(),
              //Button Text
              Text(
                'By signing up, you agree to our Terms of Service and Privacy Policy',
                style: TextStyle(color: Color(0xFF9E9E9E)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

