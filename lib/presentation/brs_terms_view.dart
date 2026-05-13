import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsTermsView extends StatefulWidget {
  const BrsTermsView({super.key});

  @override
  State<BrsTermsView> createState() => _BrsTermsViewState();
}

class _BrsTermsViewState extends State<BrsTermsView> {
  final List<Map<String, dynamic>> sections = [
    {
      "title": "1. Introduction and Acceptance",
      "content": "Welcome to BarberBook. These Terms of Service (\"Terms\") govern your use of our mobile application and services. By downloading, accessing, or using our app, you agree to be bound by these Terms.\n\nIf you do not agree with any part of these terms, you may not use our service. These Terms apply to all visitors, users, and others who access or use the service."
    },
    {
      "title": "2. Service Description",
      "content": "BarberBook is a platform that connects customers with professional barbers and barbershops. Our services include:\n\n• Booking appointments with verified barbers\n• Payment processing for services\n• Customer reviews and ratings\n• Location-based barber discovery\n• Appointment management and reminders\n\nWe act as an intermediary between customers and service providers and do not directly provide barbering services."
    },
    {
      "title": "3. User Account and Registration",
      "content": "To use our services, you must:\n\n• Be at least 18 years old or have parental consent\n• Provide accurate and complete registration information\n• Maintain the security of your account credentials\n• Notify us immediately of any unauthorized use\n• Accept responsibility for all activities under your account\n\nYou may not create multiple accounts or use our service for illegal purposes."
    },
    {
      "title": "4. Booking and Payment Terms",
      "content": "When you book services through our platform:\n\n• All bookings are subject to barber availability\n• Payment is processed at the time of booking\n• Cancellations must be made at least 24 hours in advance for full refund\n• Late cancellations may incur fees as specified\n• No-shows may result in full charge and account restrictions\n• All prices include applicable taxes and fees\n\nWe reserve the right to modify pricing and payment terms with notice."
    },
    {
      "title": "5. User Conduct and Responsibilities",
      "content": "You agree to:\n\n• Use the service only for lawful purposes\n• Treat service providers with respect and professionalism\n• Arrive on time for scheduled appointments\n• Provide accurate information in reviews and ratings\n• Not misuse or abuse the platform or its features\n• Comply with all applicable laws and regulations\n\nProhibited activities include harassment, fraud, spam, or any behavior that disrupts the service."
    },
    {
      "title": "6. Service Provider Terms",
      "content": "For barbers and service providers:\n\n• Must maintain valid licenses and certifications\n• Required to provide services as advertised\n• Responsible for maintaining professional standards\n• Must comply with health and safety regulations\n• Subject to customer feedback and platform policies\n• Commission fees apply to completed bookings\n\nWe reserve the right to suspend or terminate provider accounts for policy violations."
    },
    {
      "title": "7. Intellectual Property Rights",
      "content": "The BarberBook platform, including all content, features, and functionality, is owned by us and protected by intellectual property laws.\n\nYou may not:\n• Copy, modify, or distribute our content\n• Use our trademarks without permission\n• Reverse engineer our application\n• Create derivative works\n\nUser-generated content remains your property but you grant us license to use it for platform operations."
    },
    {
      "title": "8. Privacy and Data Protection",
      "content": "Your privacy is important to us. Our Privacy Policy explains how we collect, use, and protect your information.\n\nBy using our service, you consent to:\n• Collection of necessary personal information\n• Use of location data for service matching\n• Communication for service-related purposes\n• Data sharing with service providers as needed\n\nWe implement appropriate security measures to protect your data."
    },
    {
      "title": "9. Disclaimers and Limitations",
      "content": "Our service is provided \"as is\" without warranties of any kind. We disclaim all warranties, express or implied.\n\nWe are not liable for:\n• Quality of services provided by barbers\n• Direct, indirect, or consequential damages\n• Service interruptions or technical issues\n• Actions of third-party service providers\n• Loss of data or business\n\nOur total liability is limited to the amount paid for services in the past 12 months."
    },
    {
      "title": "10. Dispute Resolution",
      "content": "For any disputes or claims:\n\n• First attempt resolution through our customer support\n• Mediation may be required before legal action\n• Arbitration clause may apply to certain disputes\n• Class action waivers may be enforced\n• Governing law and jurisdiction clauses apply\n\nWe encourage good faith efforts to resolve issues amicably."
    },
    {
      "title": "11. Account Termination",
      "content": "We may suspend or terminate accounts for:\n\n• Violation of these Terms\n• Fraudulent or illegal activity\n• Abuse of platform or other users\n• Extended inactivity\n• Non-payment of fees\n\nYou may terminate your account at any time through the app settings. Termination does not affect existing booking obligations."
    },
    {
      "title": "12. Changes to Terms",
      "content": "We reserve the right to modify these Terms at any time. Changes will be:\n\n• Posted in the app with effective date\n• Communicated via email or in-app notification\n• Effective immediately upon posting\n• Binding upon continued use of the service\n\nMaterial changes may require your explicit acceptance. Your continued use constitutes acceptance of updated Terms."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of Service"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.gavel,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Terms of Service",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Last Updated: January 15, 2024",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Please read these terms carefully before using our service. By using BarberBook, you agree to these terms and conditions.",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Terms Sections
            ...List.generate(sections.length, (index) {
              final section = sections[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  childrenPadding: EdgeInsets.all(spSm),
                  title: Text(
                    "${section["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${section["content"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: spLg),

            // Important Notice
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: warningColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Important Notice",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "These terms constitute a legally binding agreement. By continuing to use our service, you acknowledge that you have read, understood, and agree to be bound by these terms.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Contact Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Questions About These Terms?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "If you have any questions about these Terms of Service, please contact us:",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "legal@barberbook.com",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "+1 (555) 123-4567",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QButton(
                    label: "Contact Legal Team",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Bottom Notice
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "By continuing to use BarberBook, you acknowledge that you have read and understood these Terms of Service and agree to be bound by them.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
