import 'package:flutter/material.dart';
import 'package:job_sky/views/Auth/create_account_page.dart';
import 'package:job_sky/views/Auth/login_page.dart';
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
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('JobSky', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                SizedBox(height: 220,),
                Text(
                  'Connecting people through shared opportunities.', 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 28),
                ),
                SizedBox(height: 30),
                CustomButton(buttonName: 'Continue with email', onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                }), 
                CustomButton(buttonName: 'Sign up with email', onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage(),));
                }),
                Spacer(),
                Text(
                  'By signing up, you agree to our Terms of Service and Privacy Policy',
                  style: TextStyle(
                    color: Color(0xFF9E9E9E)
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
        )
        ),
    );
  }
}