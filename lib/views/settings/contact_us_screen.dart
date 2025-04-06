import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_textfield.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final message = 'Got questios, feedback, or just want to say hi? we\'re here to help,chat or even debate the best pizza toppings (spoiler: it\'s pinapple). Don\'t be stranger!';
  final title = TextEditingController();
  final feedback = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Contact Us",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(color: Color(0xFF9E9E9E)),
                  ),
                  const Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    label: "title",
                    controller: title,
                    keyboardType: TextInputType.text,
                  ),
                  const Text(
                    'Message',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    label: "your Message",
                    controller: feedback,
                    maxLines: 6,
                    minLines: 3,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15),
                  CustomButton(
                    buttonName: 'Send feedback',
                    backgroundColor: AppColors.authButtonColor,
                    foregroundColor: Colors.white,
                    onTap: () {
                      print('email is: ${title.text}');
                      print('message is: ${feedback.text}');
                    },
                  ),

                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
