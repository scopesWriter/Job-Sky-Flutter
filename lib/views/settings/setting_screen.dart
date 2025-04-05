import 'package:flutter/material.dart';
import 'package:job_sky/views/Auth/welcome_screen.dart';
import 'package:job_sky/views/settings/change_paswword_screen.dart';
import 'package:job_sky/views/settings/privacy_security_screen.dart';
import 'package:job_sky/views/settings/terms_condition_screen.dart';


class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final listNames = [
    "Change Email",
    "Change Password",
    "Privacy and Security",
    "Terms and Conditions",
    "Contact Us",
    "Delete Account",
    "Logout",
  ];

  final listIcons = [
    Icons.email_outlined,
    Icons.password_outlined,
    Icons.privacy_tip_outlined,
    Icons.bookmark_add_outlined,
    Icons.quick_contacts_mail_rounded,
    Icons.delete_outline,
    Icons.logout,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: ListView.separated(
            itemBuilder:
                (context, index) => ListTile(
                  leading: Icon(listIcons[index]),
                  title: Text(listNames[index]),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    GotoScreen(context, index);
                  },
                ),

            separatorBuilder: (context, index) {return Divider(color: Colors.grey,);},
            itemCount: listNames.length,
          ),
        ),
      ),
    );
  }
}

void GotoScreen(BuildContext context,int index) {
  switch (index) {
    case 0:
      print('change email');
      break;
    case 1:
      print('change password');
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen(),));
      break;
    case 2:
      print('privacy and security');
      Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyAndSecurityScreen(),));
      break;
    case 3:
      print('terms and conditions');
      Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsScreen(),));
      break;
    case 4:
      print('contact us');
      break;
    case 5:
      print('delete account');
      break;
    case 6:
      print('logout');
      Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage(),));
      break;
    default:
      print('default');
  }
}
