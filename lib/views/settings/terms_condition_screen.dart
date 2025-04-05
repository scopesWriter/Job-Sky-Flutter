import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  TermsAndConditionsScreen({super.key});

  final termsTitles = [
    'Notice',
    '1. Acceptance of Terms',
    '2. Provision of Services',
    '3. Use of Services',
    '4. Content',
    '5. Termination',
    '6. Changes to the Terms'
  ];

  final termsContents = [
    'Welcome to [Your App Name]. By using our services, you agree to comply with and be bound by the following terms of use. Please review the terms carefully.',
    'By accessing and using [Your App Name], you accept and agree to be bound by the terms and provision of this agreement. In addition, when using these particular services, you shall be subject to any posted guidelines or rules applicableto such services. Any participation in this service will constitute acceptance of this agreement. If you do not agree to abide by the above, please do not use this service.',
    '[Your Company Name] is continually innovating in order to provide the best possible experience for its users. You acknowledge and agree that the form and nature of the services which [Your Company Name] provides may change from time to time without prior notice to you. ',
    'You agree to use the services only for purposes that are permitted by (a) the Terms and (b) any applicable law, regulation or generally accepted practices or guidelines in the relevant jurisdictions.',
    'You understand that all information (such as data files, written text, computer software, music, audio files or other sounds, photographs, videos or other images) which you may have access to as part of, or through your use of, the services are the sole responsibility of the person from which such content originated.',
    '[Your Company Name] may at any time, terminate its legal agreement with you if you have breached any provision of the Terms (or have acted in manner which clearly shows that you do not intend to, or are unable to comply with the provisions of the Terms).',
    '[Your Company Name] may make changes to the Terms from time to time. When these changes are made, [Your Company Name] will make a new copy of the Terms available at [Your App Name].'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Terms and Conditions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      )),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0 , horizontal: 10),

          child: ListView.separated(
            itemBuilder:
                (context, index) => ListTile(

              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(termsTitles[index],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text(termsContents[index],style: TextStyle(fontSize: 14)),
                ],
              ),
            ),

            separatorBuilder: (context, index) {return SizedBox(height: 0,);},
            itemCount: termsTitles.length,
          ),
        ),
      ),
    );
  }
}
