import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsTermsView extends StatefulWidget {
  const EcsTermsView({super.key});

  @override
  State<EcsTermsView> createState() => _EcsTermsViewState();
}

class _EcsTermsViewState extends State<EcsTermsView> {
  List<Map<String, dynamic>> termsSection = [
    {
      "title": "1. Acceptance of Terms",
      "content": "By accessing and using ShopEase mobile application and website, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.\n\nThese Terms of Service (\"Terms\") apply to your access and use of ShopEase (the \"Service\") provided by ShopEase Inc. (\"we\", \"us\", or \"our\").",
    },
    {
      "title": "2. Description of Service",
      "content": "ShopEase provides an e-commerce platform that allows users to browse, search, and purchase products from various merchants and sellers. Our service includes:\n\n• Product catalog and search functionality\n• Shopping cart and checkout process\n• Order tracking and management\n• Customer support services\n• Account management features\n\nWe reserve the right to modify, suspend, or discontinue any aspect of the service at any time.",
    },
    {
      "title": "3. User Accounts",
      "content": "To access certain features of our service, you must create an account. When creating an account, you agree to:\n\n• Provide accurate and complete information\n• Maintain the security of your account credentials\n• Accept responsibility for all activities under your account\n• Notify us immediately of any unauthorized use\n\nYou are responsible for maintaining the confidentiality of your account and password. We reserve the right to terminate accounts that violate these terms.",
    },
    {
      "title": "4. Product Information and Pricing",
      "content": "We strive to provide accurate product descriptions, images, and pricing information. However:\n\n• Product availability is subject to change\n• Prices may vary and are subject to change without notice\n• We reserve the right to correct pricing errors\n• Colors and appearance may vary from actual products\n\nAll prices are listed in USD unless otherwise specified and include applicable taxes where required by law.",
    },
    {
      "title": "5. Orders and Payment",
      "content": "When you place an order through our service:\n\n• You represent that you are authorized to use the payment method\n• We reserve the right to refuse or cancel orders\n• Payment must be received before order processing\n• You agree to pay all charges incurred\n\nWe accept major credit cards, debit cards, and other payment methods as displayed during checkout. All transactions are processed securely.",
    },
    {
      "title": "6. Shipping and Delivery",
      "content": "Shipping and delivery terms include:\n\n• Delivery times are estimates and not guaranteed\n• Risk of loss passes to you upon delivery\n• We are not liable for shipping delays beyond our control\n• Additional charges may apply for expedited shipping\n\nPlease review our shipping policy for detailed information about delivery options and timeframes.",
    },
    {
      "title": "7. Returns and Refunds",
      "content": "Our return and refund policy provides:\n\n• 30-day return window for most items\n• Items must be in original condition\n• Return shipping costs may apply\n• Refunds processed within 5-10 business days\n\nCertain items may be excluded from returns. Please review our return policy for complete details and restrictions.",
    },
    {
      "title": "8. User Conduct",
      "content": "You agree not to:\n\n• Use the service for illegal purposes\n• Interfere with service operations\n• Attempt to gain unauthorized access\n• Submit false or misleading information\n• Violate intellectual property rights\n• Harass other users or staff\n\nViolation of these terms may result in account suspension or termination.",
    },
    {
      "title": "9. Intellectual Property",
      "content": "All content on ShopEase, including:\n\n• Text, graphics, logos, and images\n• Software and source code\n• Trademarks and service marks\n• Product descriptions and reviews\n\nAre protected by intellectual property laws. You may not reproduce, distribute, or create derivative works without our written permission.",
    },
    {
      "title": "10. Privacy and Data Protection",
      "content": "Your privacy is important to us. Our Privacy Policy explains:\n\n• What information we collect\n• How we use your information  \n• Data sharing practices\n• Security measures in place\n• Your rights regarding personal data\n\nBy using our service, you consent to our privacy practices as outlined in our Privacy Policy.",
    },
    {
      "title": "11. Disclaimers and Limitation of Liability",
      "content": "Our service is provided \"as is\" without warranties of any kind. We disclaim all warranties, express or implied, including merchantability and fitness for a particular purpose.\n\nWe shall not be liable for any indirect, incidental, special, or consequential damages arising from your use of the service. Our total liability shall not exceed the amount paid by you for the service.",
    },
    {
      "title": "12. Indemnification",
      "content": "You agree to indemnify and hold harmless ShopEase Inc., its officers, directors, employees, and agents from any claims, damages, losses, or expenses arising from:\n\n• Your use of the service\n• Your violation of these terms\n• Your violation of any third-party rights\n• Any content you submit or transmit",
    },
    {
      "title": "13. Modifications to Terms",
      "content": "We reserve the right to modify these terms at any time. Changes will be effective immediately upon posting to our website or app. Your continued use of the service after changes constitutes acceptance of the new terms.\n\nWe encourage you to review these terms periodically for any updates or changes.",
    },
    {
      "title": "14. Termination",
      "content": "Either party may terminate this agreement at any time:\n\n• You may close your account at any time\n• We may suspend or terminate accounts for violations\n• Termination does not affect completed transactions\n• Certain provisions survive termination\n\nUpon termination, you must cease all use of the service.",
    },
    {
      "title": "15. Governing Law and Dispute Resolution",
      "content": "These terms are governed by the laws of [State/Country] without regard to conflict of law principles.\n\nAny disputes shall be resolved through:\n\n• First, good faith negotiation\n• If unsuccessful, binding arbitration\n• Arbitration conducted under applicable rules\n• Class action waivers apply\n\nYou agree to resolve disputes individually, not as part of a class action.",
    },
    {
      "title": "16. Contact Information",
      "content": "If you have questions about these Terms of Service, please contact us:\n\nShopEase Inc.\n123 Commerce Street\nDigital City, DC 12345\n\nEmail: legal@shopease.com\nPhone: +1 (800) 123-4567\n\nOur customer service team is available Monday through Friday, 9 AM to 8 PM EST.",
    },
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.gavel,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Terms of Service",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Last updated: December 13, 2024",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Please read these Terms of Service carefully before using ShopEase. These terms govern your use of our mobile application and website services.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: infoColor.withAlpha(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.download,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Download PDF Version",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: successColor.withAlpha(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.print,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Print Terms",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Terms Sections
            ...termsSection.map((section) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${section["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${section["content"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Important Notice
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: warningColor.withAlpha(30),
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
                      SizedBox(width: spSm),
                      Text(
                        "Important Notice",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "By using ShopEase, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service. If you do not agree with any part of these terms, you must not use our service.",
                    style: TextStyle(
                      fontSize: 14,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Contact for Questions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
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
                    "If you have any questions about these Terms of Service, please contact our legal team at legal@shopease.com or call us at +1 (800) 123-4567.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      QButton(
                        label: "Contact Legal Team",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to contact
                        },
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "View Privacy Policy",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to privacy policy
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Footer
            Center(
              child: Column(
                children: [
                  Text(
                    "ShopEase Terms of Service",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Version 2.1 • Effective December 13, 2024",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "© 2024 ShopEase Inc. All rights reserved.",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
