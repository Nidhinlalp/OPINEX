import 'package:flutter/material.dart';
import 'package:redite_clone/resposive/resposive.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static const String routName = '/privacy-policy';

  const PrivacyPolicyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Responsive(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Last updated: ',
                style: TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Your privacy is important to us. This Privacy Policy explains how we collect, use, and disclose your personal information when you use our social media application.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Information We Collect',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'When you use our OPNIX application, we may collect the following information:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                  ' - Personal information such as your name, email address, and profile picture'),
              Text(
                  ' - User-generated content such as posts, comments, and messages'),
              SizedBox(height: 16.0),
              Text(
                'How We Use Your Information',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'We may use your information for the following purposes:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(' - To provide and personalize our social media services'),
              Text(' - To communicate with you and respond to your inquiries'),
              Text(' - To improve our application and develop new features'),
              Text(' - To analyze usage trends and optimize user experience'),
              SizedBox(height: 16.0),
              Text(
                'How We Share Your Information',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'We may share your information with the following parties:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                  ' - Other users of the social media application in accordance with your privacy settings'),
              Text(
                  ' - Service providers who assist us in operating our application'),
              Text(
                  ' - Law enforcement or government officials when required by law'),
              SizedBox(height: 16.0),
              Text(
                'Security',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'We take reasonable measures to protect your information, but please be aware that no security measures are perfect or impenetrable.',
                style: TextStyle(fontSize: 16.0),
              ),
              // SizedBox(height: 16.0),
              // Text(
              //   'Children\'s Privacy',
              //   style: TextStyle(
              //     fontSize: 20.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 8.0),
              // Text(
              //   'Our social media application is not intended for children under 13 years of age. We do not knowingly collect personal information from children.',
              //   style: TextStyle(fontSize: 16.0),
              // ),
              SizedBox(height: 16.0),
              Text(
                'Changes to This Privacy Policy',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'If you have any questions or suggestions about our Privacy Policy, please contact us at lalnidhinp02@gmail.com.',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// 