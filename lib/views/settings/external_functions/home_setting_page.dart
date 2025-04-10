import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_sky/views/auth/external_functions/uid_functions.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/profile_provider.dart';
import '../../../viewmodels/chat/chat_list_viewmodel.dart';
import '../../Auth/welcome_screen.dart';
import '../change_email_screen.dart';
import '../change_paswword_screen.dart';
import '../contact_us_screen.dart';
import '../privacy_security_screen.dart';
import '../terms_condition_screen.dart';

void GotoScreen(BuildContext context, int index, WidgetRef ref) {
  switch (index) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChangeEmailScreen()),
      );
      print('change email');
      break;
    case 1:
      print('change password');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
      );
      break;
    case 2:
      print('privacy and security');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PrivacyAndSecurityScreen()),
      );
      break;
    case 3:
      print('terms and conditions');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()),
      );
      break;
    case 4:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContactUsScreen()),
      );
      print('contact us');
      break;
    case 5:
      print('delete account');
      clearUid();
      ref.read(bottomIndexProvider.notifier).state = 0;
      ref.invalidate(chatListProvider);
      ref.read(imagePathProvider.notifier).state = '';
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomePage() )  , (route) => false);
      break;
    case 6:
      print('logout');
      clearUid();
      ref.read(bottomIndexProvider.notifier).state = 0;
      ref.invalidate(chatListProvider);
      ref.read(imagePathProvider.notifier).state = '';
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomePage() )  , (route) => false);
      break;
    default:
      print('default');
  }
}
