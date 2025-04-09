import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'external_functions/home_setting_page.dart';

class SettingScreen extends ConsumerWidget {
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
    Icons.quick_contacts_mail_outlined,
    Icons.delete_outline,
    Icons.logout,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder:
              (context, index) => GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        listIcons[index],
                        color:
                            (index == listNames.length - 1 ||
                                    index == listNames.length - 2)
                                ? Colors.red[800]
                                : Colors.black,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        listNames[index],
                        style: TextStyle(
                          fontSize: 18,
                          color:
                              (index == listNames.length - 1 ||
                                      index == listNames.length - 2)
                                  ? Colors.red[800]
                                  : Colors.black,
                        ),
                      ),
                      Spacer(),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                onTap: () => GotoScreen(context, index, ref),
              ),
          separatorBuilder: (context, index) {
            return Container(
              color: Colors.grey,
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 15),
            );
          },
          itemCount: listNames.length,
        ),
      ),
    );
  }
}
