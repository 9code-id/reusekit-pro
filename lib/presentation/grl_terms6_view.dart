import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTerms6View extends StatefulWidget {
  @override
  State<GrlTerms6View> createState() => _GrlTerms6ViewState();
}

class _GrlTerms6ViewState extends State<GrlTerms6View> {
  String selectedDocument = "terms";
  Map<String, bool> documentAgreements = {
    "terms": false,
    "privacy": false,
    "cookies": false,
    "license": false,
  };

  List<Map<String, dynamic>> legalDocuments = [
    {
      "id": "terms",
      "title": "Terms of Service",
      "subtitle": "User responsibilities and service rules",
      "icon": Icons.description,
      "color": primaryColor,
      "lastUpdated": "June 15, 2024",
      "version": "v3.2",
      "sections": 12,
      "estimatedReadTime": "8 min",
    },
    {
      "id": "privacy",
      "title": "Privacy Policy",
      "subtitle": "How we collect and use your data",
      "icon": Icons.privacy_tip,
      "color": infoColor,
      "lastUpdated": "June 10, 2024",
      "version": "v2.8",
      "sections": 9,
      "estimatedReadTime": "6 min",
    },
    {
      "id": "cookies",
      "title": "Cookie Policy",
      "subtitle": "Cookie usage and preferences",
      "icon": Icons.cookie,
      "color": warningColor,
      "lastUpdated": "May 28, 2024",
      "version": "v1.5",
      "sections": 6,
      "estimatedReadTime": "4 min",
    },
    {
      "id": "license",
      "title": "Software License",
      "subtitle": "Software usage rights and restrictions",
      "icon": Icons.code,
      "color": successColor,
      "lastUpdated": "April 20, 2024",
      "version": "v4.1",
      "sections": 8,
      "estimatedReadTime": "5 min",
    },
  ];

  Map<String, String> documentContent = {
    "terms": """
TERMS OF SERVICE

1. ACCEPTANCE OF TERMS
By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement.

2. USE LICENSE
Permission is granted to temporarily download one copy of the materials on this application for personal, non-commercial transitory viewing only.

3. DISCLAIMER
The materials on this application are provided on an 'as is' basis. We make no warranties, expressed or implied.

4. LIMITATIONS
In no event shall our company or its suppliers be liable for any damages arising out of the use or inability to use the materials.

5. ACCURACY OF MATERIALS
The materials appearing on this application could include technical, typographical, or photographic errors.

6. LINKS
We have not reviewed all of the sites linked to our application and are not responsible for the contents of any such linked site.

7. MODIFICATIONS
We may revise these terms of service at any time without notice. By using this application, you are agreeing to be bound by the then current version.

8. GOVERNING LAW
These terms and conditions are governed by and construed in accordance with the laws and you irrevocably submit to the exclusive jurisdiction.
    """,
    "privacy": """
PRIVACY POLICY

1. INFORMATION WE COLLECT
We collect information you provide directly to us, such as when you create an account, make a purchase, or contact us.

2. HOW WE USE YOUR INFORMATION
We use the information we collect to provide, maintain, and improve our services.

3. SHARING OF INFORMATION
We do not sell, trade, or otherwise transfer your personal information to third parties.

4. DATA SECURITY
We implement appropriate security measures to protect your personal information.

5. COOKIES
We use cookies to enhance your experience, analyze site usage, and assist in our marketing efforts.

6. THIRD-PARTY SERVICES
Our service may contain links to third-party websites or services that are not owned or controlled by us.

7. CHILDREN'S PRIVACY
Our service does not address anyone under the age of 13.

8. CHANGES TO PRIVACY POLICY
We may update our Privacy Policy from time to time.

9. CONTACT US
If you have any questions about this Privacy Policy, please contact us.
    """,
    "cookies": """
COOKIE POLICY

1. WHAT ARE COOKIES
Cookies are small text files that are stored on your computer or mobile device when you visit our website.

2. HOW WE USE COOKIES
We use cookies to improve your browsing experience, analyze site traffic, and personalize content.

3. TYPES OF COOKIES
- Essential cookies: Required for the website to function properly
- Analytics cookies: Help us understand how visitors interact with our website
- Marketing cookies: Used to track visitors across websites

4. MANAGING COOKIES
You can control and/or delete cookies as you wish through your browser settings.

5. THIRD-PARTY COOKIES
We may use third-party services that place cookies on your device.

6. UPDATES TO THIS POLICY
We may update this Cookie Policy from time to time to reflect changes in our practices.
    """,
    "license": """
SOFTWARE LICENSE AGREEMENT

1. GRANT OF LICENSE
Subject to the terms of this Agreement, we grant you a limited, non-exclusive, non-transferable license to use the software.

2. RESTRICTIONS
You may not modify, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any software.

3. OWNERSHIP
The software is protected by copyright laws and international copyright treaties.

4. TERMINATION
This license is effective until terminated. Your rights under this license will terminate automatically without notice.

5. DISCLAIMER OF WARRANTIES
The software is provided "AS IS" without warranty of any kind.

6. LIMITATION OF LIABILITY
In no event shall we be liable for any damages arising out of the use of or inability to use the software.

7. GOVERNING LAW
This Agreement shall be governed by the laws of the jurisdiction in which the licensor is located.

8. ENTIRE AGREEMENT
This Agreement constitutes the entire agreement between you and us regarding the use of the software.
    """,
  };

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentDoc = legalDocuments.firstWhere(
      (doc) => doc["id"] == selectedDocument,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Legal Center"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: primaryColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${documentAgreements.values.where((agreed) => agreed).length}/${documentAgreements.length}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.assignment,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Documents",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    itemCount: legalDocuments.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> doc = legalDocuments[index];
                      bool isSelected = selectedDocument == doc["id"];
                      bool isAgreed = documentAgreements[doc["id"]] ?? false;

                      return GestureDetector(
                        onTap: () {
                          selectedDocument = doc["id"];
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? doc["color"].withAlpha(20) : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? doc["color"] : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: doc["color"].withAlpha(isSelected ? 30 : 10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      doc["icon"],
                                      color: doc["color"],
                                      size: 20,
                                    ),
                                  ),
                                  if (isAgreed)
                                    Positioned(
                                      top: -2,
                                      right: -2,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${doc["title"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? doc["color"] : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    spacing: spXs,
                    children: [
                      QButton(
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          si("Downloading all documents as ZIP");
                        },
                      ),
                      Text(
                        "Download All",
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

          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: currentDoc["color"].withAlpha(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: currentDoc["color"].withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          currentDoc["icon"],
                          color: currentDoc["color"],
                          size: 28,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentDoc["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: currentDoc["color"],
                              ),
                            ),
                            Text(
                              "${currentDoc["subtitle"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: currentDoc["color"].withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${currentDoc["version"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: currentDoc["color"],
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "• ${currentDoc["sections"]} sections",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "• ${currentDoc["estimatedReadTime"]} read",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (documentAgreements[selectedDocument] ?? false)
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: infoColor.withAlpha(100),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: infoColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Last updated: ${currentDoc["lastUpdated"]} • This document is legally binding once accepted",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
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
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.article,
                                    color: currentDoc["color"],
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Document Content",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: currentDoc["color"],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  documentContent[selectedDocument] ?? "",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: documentAgreements[selectedDocument] ?? false,
                            onChanged: (value) {
                              documentAgreements[selectedDocument] = value ?? false;
                              setState(() {});
                            },
                            activeColor: currentDoc["color"],
                          ),
                          Expanded(
                            child: Text(
                              "I have read and agree to the ${currentDoc["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Download PDF",
                              onPressed: () {
                                si("Downloading ${currentDoc["title"]} as PDF");
                              },
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: documentAgreements[selectedDocument] == true ? "Accepted" : "Accept Document",
                              onPressed: documentAgreements[selectedDocument] == true ? null : () {
                                documentAgreements[selectedDocument] = true;
                                setState(() {});
                                ss("${currentDoc["title"]} accepted");
                              },
                            ),
                          ),
                        ],
                      ),

                      if (documentAgreements.values.every((agreed) => agreed))
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
                                size: 32,
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
                                "You have successfully accepted all legal documents and can now proceed",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              QButton(
                                label: "Continue to Application",
                                onPressed: () {
                                  ss("All legal documents accepted - proceeding to app");
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
