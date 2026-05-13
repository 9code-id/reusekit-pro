import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaTermsConditionsView extends StatefulWidget {
  const BfaTermsConditionsView({super.key});

  @override
  State<BfaTermsConditionsView> createState() => _BfaTermsConditionsViewState();
}

class _BfaTermsConditionsViewState extends State<BfaTermsConditionsView> {
  bool acceptedTerms = false;

  List<Map<String, dynamic>> sections = [
    {
      "title": "1. Acceptance of Terms",
      "content": """By downloading, installing, accessing, or using the ReuseKit mobile application ("the App"), you agree to be bound by these Terms and Conditions ("Terms"). If you do not agree to these Terms, please do not use the App.

These Terms constitute a legally binding agreement between you and ReuseKit Company ("we," "us," or "our"). We reserve the right to modify these Terms at any time, and such modifications will be effective immediately upon posting."""
    },
    {
      "title": "2. App Description and Services",
      "content": """ReuseKit is a mobile application that provides users with tools and features for managing and organizing various activities. The App includes but is not limited to:

• User account management
• Data synchronization across devices
• Content creation and sharing features
• Analytics and reporting tools
• Customer support services

We continuously work to improve and enhance the App's functionality, and we may add, modify, or remove features at our discretion."""
    },
    {
      "title": "3. User Accounts and Registration",
      "content": """To access certain features of the App, you must create a user account. When creating an account, you agree to:

• Provide accurate, current, and complete information
• Maintain and promptly update your account information
• Keep your login credentials secure and confidential
• Accept responsibility for all activities under your account
• Notify us immediately of any unauthorized access

You are solely responsible for maintaining the confidentiality of your account and password."""
    },
    {
      "title": "4. User Conduct and Prohibited Activities",
      "content": """You agree to use the App in accordance with applicable laws and regulations. You shall not:

• Use the App for any unlawful or prohibited purposes
• Attempt to gain unauthorized access to the App or other users' accounts
• Interfere with or disrupt the App's operation or security
• Upload or transmit viruses, malware, or other harmful code
• Harass, abuse, or harm other users
• Violate any intellectual property rights
• Create multiple accounts for deceptive purposes
• Use automated systems to access the App without permission

Violation of these terms may result in account suspension or termination."""
    },
    {
      "title": "5. Privacy and Data Protection",
      "content": """Your privacy is important to us. Our data collection and use practices are outlined in our Privacy Policy, which is incorporated into these Terms by reference.

By using the App, you consent to:
• Collection and processing of your personal data as described in our Privacy Policy
• Use of cookies and similar technologies
• Transfer of data to third-party service providers as necessary for App functionality

We implement appropriate security measures to protect your personal information, but we cannot guarantee absolute security of data transmitted over the internet."""
    },
    {
      "title": "6. Intellectual Property Rights",
      "content": """The App and all content, features, and functionality are owned by ReuseKit Company and are protected by copyright, trademark, and other intellectual property laws.

You are granted a limited, non-exclusive, non-transferable license to use the App for personal, non-commercial purposes. You may not:

• Copy, modify, distribute, or create derivative works
• Reverse engineer, decompile, or disassemble the App
• Remove or alter any proprietary notices
• Use our trademarks or logos without permission

All user-generated content remains your property, but you grant us a license to use it as necessary for App functionality."""
    },
    {
      "title": "7. Third-Party Services and Links",
      "content": """The App may contain links to third-party websites, services, or applications. These links are provided for convenience and do not constitute our endorsement.

We are not responsible for:
• Content or services provided by third parties
• Privacy practices of external websites
• Any damages resulting from third-party interactions

Your use of third-party services is subject to their respective terms and conditions."""
    },
    {
      "title": "8. Disclaimers and Limitations of Liability",
      "content": """THE APP IS PROVIDED "AS IS" AND "AS AVAILABLE" WITHOUT WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED. WE DISCLAIM ALL WARRANTIES INCLUDING BUT NOT LIMITED TO MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.

TO THE MAXIMUM EXTENT PERMITTED BY LAW, WE SHALL NOT BE LIABLE FOR:
• Indirect, incidental, or consequential damages
• Loss of profits, data, or business opportunities
• Damages resulting from App unavailability or errors
• Any damages exceeding the amount paid for App services

Some jurisdictions do not allow limitation of liability, so these limitations may not apply to you."""
    },
    {
      "title": "9. Termination",
      "content": """You may terminate your account at any time by following the account deletion process in the App settings.

We may terminate or suspend your account immediately, without prior notice, if you:
• Violate these Terms
• Engage in fraudulent or illegal activities
• Pose a security risk to the App or other users

Upon termination:
• Your right to use the App will cease immediately
• We may delete your account data in accordance with our data retention policy
• Certain provisions of these Terms will survive termination"""
    },
    {
      "title": "10. Governing Law and Dispute Resolution",
      "content": """These Terms are governed by and construed in accordance with the laws of [Jurisdiction], without regard to conflict of law principles.

Any disputes arising from these Terms or your use of the App will be resolved through:
1. Good faith negotiations between the parties
2. Binding arbitration if negotiations fail
3. Courts of competent jurisdiction in [Jurisdiction] for non-arbitrable matters

You waive any right to participate in class action lawsuits or class-wide arbitration."""
    },
    {
      "title": "11. Contact Information",
      "content": """If you have any questions about these Terms and Conditions, please contact us:

Email: legal@reusekit.com
Phone: +1 (555) 123-4567
Address: 123 Legal Street, City, State 12345

For technical support, please use the in-app contact form or email support@reusekit.com."""
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions"),
        actions: [
          Icon(
            Icons.gavel,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          // Header Info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              border: Border(
                bottom: BorderSide(color: infoColor.withAlpha(40)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "ReuseKit Terms & Conditions",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Last updated: December 20, 2024",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Please read these terms carefully before using our app",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),

          // Terms Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spLg,
                children: [
                  // Introduction
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: primaryColor,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Important Notice",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "These Terms and Conditions govern your use of the ReuseKit mobile application. By using our app, you acknowledge that you have read, understood, and agree to be bound by these terms.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Terms Sections
                  ...sections.map((section) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "${section["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
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

                  // Quick Links
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Related Documents",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Privacy Policy",
                                icon: Icons.privacy_tip,
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo(PrivacyPolicyView)
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Contact Legal",
                                icon: Icons.email,
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo(ContactLegalView)
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Version History
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Version History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),

                        Column(
                          spacing: spSm,
                          children: [
                            _buildVersionItem("Version 3.0", "December 20, 2024", "Updated data protection clauses"),
                            _buildVersionItem("Version 2.1", "October 15, 2024", "Added third-party service provisions"),
                            _buildVersionItem("Version 2.0", "August 10, 2024", "Major revision for new features"),
                            _buildVersionItem("Version 1.0", "June 1, 2024", "Initial terms and conditions"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spXl),
                ],
              ),
            ),
          ),

          // Accept Terms Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QSwitch(
                  items: [
                    {
                      "label": "I have read and agree to the Terms & Conditions",
                      "value": true,
                      "checked": acceptedTerms,
                    }
                  ],
                  value: [
                    if (acceptedTerms)
                      {
                        "label": "I have read and agree to the Terms & Conditions",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    acceptedTerms = values.isNotEmpty;
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: acceptedTerms ? "Continue" : "Please Accept Terms",
                    icon: acceptedTerms ? Icons.check : Icons.warning,
                    size: bs.md,
                    onPressed: acceptedTerms ? () {
                      ss("Terms accepted successfully!");
                      back();
                    } : null,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to privacy policy
                        // navigateTo(PrivacyPolicyView)
                      },
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to support
                        // navigateTo(SupportView)
                      },
                      child: Text(
                        "Contact Support",
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionItem(String version, String date, String changes) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXxs,
        children: [
          Row(
            children: [
              Text(
                version,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            changes,
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
