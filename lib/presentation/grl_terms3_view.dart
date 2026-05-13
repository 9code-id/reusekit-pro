import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTerms3View extends StatefulWidget {
  @override
  State<GrlTerms3View> createState() => _GrlTerms3ViewState();
}

class _GrlTerms3ViewState extends State<GrlTerms3View> {
  int currentTab = 0;
  Map<String, bool> agreementStatus = {
    "terms": false,
    "privacy": false,
    "cookies": false,
    "data": false,
  };

  List<Map<String, dynamic>> termsSections = [
    {
      "id": "terms",
      "title": "Terms of Service",
      "icon": Icons.description,
      "content": """
1. ACCEPTANCE OF TERMS

By downloading, installing, or using this mobile application, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use our application.

2. DESCRIPTION OF SERVICE

Our application provides [service description]. We reserve the right to modify, suspend, or discontinue any aspect of our service at any time.

3. USER RESPONSIBILITIES

You are responsible for:
• Providing accurate and current information
• Maintaining the security of your account
• Complying with all applicable laws and regulations
• Not using the service for any unlawful purposes

4. PROHIBITED ACTIVITIES

You may not:
• Violate any laws or regulations
• Infringe on intellectual property rights
• Transmit harmful or malicious content
• Attempt to gain unauthorized access to our systems
• Use the service for commercial purposes without permission

5. INTELLECTUAL PROPERTY

All content, features, and functionality of our application are owned by us and are protected by copyright, trademark, and other intellectual property laws.

6. LIMITATION OF LIABILITY

We shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of our service.

7. TERMINATION

We reserve the right to terminate or suspend your account at any time for violation of these terms.
      """,
    },
    {
      "id": "privacy",
      "title": "Privacy Policy",
      "icon": Icons.privacy_tip,
      "content": """
1. INFORMATION WE COLLECT

Personal Information:
• Name and contact information
• Account credentials
• Profile information
• Payment information (if applicable)

Usage Information:
• App usage statistics
• Device information
• Location data (with permission)
• Log files and analytics

2. HOW WE USE YOUR INFORMATION

We use your information to:
• Provide and maintain our service
• Process transactions
• Send notifications and updates
• Improve our application
• Comply with legal obligations

3. INFORMATION SHARING

We do not sell your personal information. We may share information:
• With service providers who assist our operations
• When required by law
• To protect our rights and safety
• With your consent

4. DATA SECURITY

We implement appropriate security measures to protect your information against unauthorized access, alteration, disclosure, or destruction.

5. YOUR RIGHTS

You have the right to:
• Access your personal information
• Correct inaccurate information
• Request deletion of your data
• Opt-out of certain data processing
• Data portability

6. DATA RETENTION

We retain your information only as long as necessary to provide our services and comply with legal obligations.
      """,
    },
    {
      "id": "cookies",
      "title": "Cookie Policy",
      "icon": Icons.cookie,
      "content": """
1. WHAT ARE COOKIES

Cookies are small text files stored on your device when you use our application. They help us provide a better user experience.

2. TYPES OF COOKIES WE USE

Essential Cookies:
• Required for basic app functionality
• Cannot be disabled

Analytics Cookies:
• Help us understand how you use our app
• Used to improve our services

Preference Cookies:
• Remember your settings and preferences
• Enhance your user experience

Marketing Cookies:
• Used to deliver relevant advertisements
• Track advertising effectiveness

3. COOKIE MANAGEMENT

You can control cookies through:
• App settings
• Device browser settings
• Third-party opt-out tools

4. THIRD-PARTY COOKIES

Our app may include third-party services that set their own cookies:
• Google Analytics
• Advertising networks
• Social media plugins

5. UPDATES TO COOKIE POLICY

We may update this policy periodically. Changes will be communicated through app notifications.
      """,
    },
    {
      "id": "data",
      "title": "Data Processing",
      "icon": Icons.storage,
      "content": """
1. LEGAL BASIS FOR PROCESSING

We process your data based on:
• Your consent
• Contractual necessity
• Legal obligations
• Legitimate interests

2. DATA CATEGORIES

Personal Data:
• Identity information
• Contact details
• Financial information

Special Categories:
• Health information (if applicable)
• Biometric data (if applicable)
• Location data

3. PROCESSING ACTIVITIES

Data Collection:
• Through app registration
• During app usage
• From third-party sources (with consent)

Data Use:
• Service provision
• Communication
• Analytics and improvement
• Legal compliance

4. INTERNATIONAL TRANSFERS

Your data may be transferred to countries outside your jurisdiction. We ensure appropriate safeguards are in place.

5. AUTOMATED DECISION MAKING

We may use automated systems to:
• Detect fraud
• Personalize content
• Provide recommendations

You have the right to request human intervention in automated decisions.

6. DATA SUBJECT RIGHTS

Under applicable data protection laws, you have rights regarding your personal data. Contact us to exercise these rights.
      """,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Legal Documents",
      selectedIndex: currentTab,
      tabs: termsSections.map((section) => Tab(
        text: "${section["title"]}",
        icon: Icon(section["icon"]),
      )).toList(),
      tabChildren: termsSections.map((section) => _buildTabContent(section)).toList(),
    );
  }

  Widget _buildTabContent(Map<String, dynamic> section) {
    String sectionId = section["id"];
    bool isAgreed = agreementStatus[sectionId] ?? false;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    section["icon"],
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
                        "${section["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Please read this document carefully",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isAgreed)
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.article,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Document Content",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                Container(
                  height: 400,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      section["content"],
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (!isAgreed)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: warningColor.withAlpha(100),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Agreement Required",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Please read the entire document and accept to continue",
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
            ),

          Row(
            children: [
              Checkbox(
                value: isAgreed,
                onChanged: (value) {
                  agreementStatus[sectionId] = value ?? false;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
              Expanded(
                child: Text(
                  "I have read and agree to the ${section["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),

          if (isAgreed)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: successColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Thank you for accepting the ${section["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Download PDF",
              onPressed: () {
                si("Downloading ${section["title"]} as PDF");
              },
            ),
          ),

          if (agreementStatus.values.every((agreed) => agreed))
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: successColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.verified,
                    color: successColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "All Documents Accepted",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "You have successfully accepted all legal documents",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Continue to App",
                    onPressed: () {
                      ss("All terms accepted - proceeding to app");
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
