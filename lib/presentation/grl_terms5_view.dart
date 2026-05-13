import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTerms5View extends StatefulWidget {
  @override
  State<GrlTerms5View> createState() => _GrlTerms5ViewState();
}

class _GrlTerms5ViewState extends State<GrlTerms5View> {
  bool hasReadTerms = false;
  bool hasReadPrivacy = false;
  int scrollPercentage = 0;
  ScrollController scrollController = ScrollController();
  bool showScrollIndicator = false;

  List<Map<String, dynamic>> legalUpdates = [
    {
      "date": "2024-06-15",
      "title": "Privacy Policy Update",
      "type": "privacy",
      "description": "Updated data retention policies and user rights section",
      "icon": Icons.privacy_tip,
      "color": infoColor,
      "isNew": true,
    },
    {
      "date": "2024-05-20",
      "title": "Terms of Service Amendment",
      "type": "terms",
      "description": "Added new user responsibilities and service limitations",
      "icon": Icons.description,
      "color": primaryColor,
      "isNew": false,
    },
    {
      "date": "2024-04-10",
      "title": "Cookie Policy Revision",
      "type": "cookies",
      "description": "Enhanced cookie categorization and user controls",
      "icon": Icons.cookie,
      "color": warningColor,
      "isNew": false,
    },
    {
      "date": "2024-03-01",
      "title": "Data Processing Agreement",
      "type": "data",
      "description": "New data processing procedures for international users",
      "icon": Icons.storage,
      "color": successColor,
      "isNew": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    
    if (maxScroll > 0) {
      int percentage = ((currentScroll / maxScroll) * 100).round();
      if (percentage != scrollPercentage) {
        scrollPercentage = percentage;
        setState(() {});
        
        if (percentage >= 80 && !hasReadTerms) {
          hasReadTerms = true;
          setState(() {});
          si("Terms document fully read - agreement unlocked");
        }
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Legal Agreement"),
        actions: [
          if (scrollPercentage > 0)
            Container(
              margin: EdgeInsets.only(right: spMd),
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: scrollPercentage >= 80 ? successColor : primaryColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "$scrollPercentage%",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          if (scrollPercentage > 0)
            Container(
              height: 4,
              child: LinearProgressIndicator(
                value: scrollPercentage / 100,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  scrollPercentage >= 80 ? successColor : primaryColor,
                ),
              ),
            ),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: scrollPercentage >= 80 ? successColor.withAlpha(20) : primaryColor.withAlpha(20),
            ),
            child: Row(
              children: [
                Icon(
                  scrollPercentage >= 80 ? Icons.check_circle : Icons.visibility,
                  color: scrollPercentage >= 80 ? successColor : primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        scrollPercentage >= 80 ? "Document Fully Read" : "Reading Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: scrollPercentage >= 80 ? successColor : primaryColor,
                        ),
                      ),
                      Text(
                        scrollPercentage >= 80 
                          ? "You can now accept the terms and continue"
                          : "Please read the entire document to continue",
                        style: TextStyle(
                          fontSize: 14,
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
            child: SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
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
                              Icons.new_releases,
                              color: dangerColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Recent Legal Updates",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        
                        ...legalUpdates.map((update) {
                          return Container(
                            margin: EdgeInsets.only(top: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: update["color"].withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: update["color"].withAlpha(50),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: update["color"].withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    update["icon"],
                                    color: update["color"],
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${update["title"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: update["color"],
                                            ),
                                          ),
                                          if (update["isNew"])
                                            Container(
                                              margin: EdgeInsets.only(left: spXs),
                                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: dangerColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "NEW",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Text(
                                        "${update["description"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Updated: ${update["date"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
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
                        Text(
                          "MASTER SERVICE AGREEMENT",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        Text(
                          "Last Updated: June 15, 2024",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),

                        _buildSection("1. DEFINITIONS AND INTERPRETATION", """
1.1 In this Agreement, unless the context otherwise requires:

"Agreement" means this Master Service Agreement and all schedules, appendices, and amendments thereto;

"Applicable Law" means all applicable laws, statutes, regulations, and codes from time to time in force;

"Confidential Information" means any information marked or identified as confidential or proprietary;

"Data" means all data, information, and materials provided by or on behalf of the Customer;

"Services" means the services described in the applicable Service Schedule;

"Intellectual Property Rights" means all intellectual property rights worldwide including patents, copyrights, trademarks, trade secrets, and moral rights.
                        """),

                        _buildSection("2. SERVICES AND SUPPORT", """
2.1 Service Provision
We will provide the Services in accordance with this Agreement and the applicable Service Schedule. Services will be performed with professional skill and care.

2.2 Service Levels
We will use commercially reasonable efforts to meet any service levels specified in the Service Schedule.

2.3 Support Services
Support services will be provided as described in the applicable Service Schedule during normal business hours.

2.4 Modifications
We reserve the right to modify the Services with thirty (30) days' prior written notice, provided such modifications do not materially reduce the functionality of the Services.
                        """),

                        _buildSection("3. CUSTOMER RESPONSIBILITIES", """
3.1 Cooperation
Customer will provide reasonable cooperation and assistance as required for the provision of Services.

3.2 Accurate Information
Customer warrants that all information provided is accurate, complete, and up-to-date.

3.3 Compliance
Customer will comply with all Applicable Laws and this Agreement in its use of the Services.

3.4 Security
Customer is responsible for maintaining appropriate security measures for its systems and data.
                        """),

                        _buildSection("4. DATA PROTECTION AND PRIVACY", """
4.1 Data Processing
We will process personal data in accordance with applicable data protection laws and our Privacy Policy.

4.2 Data Security
We implement appropriate technical and organizational measures to protect personal data against unauthorized access, alteration, disclosure, or destruction.

4.3 Data Retention
Personal data will be retained only for as long as necessary to provide the Services or as required by law.

4.4 Data Subject Rights
We will assist Customer in responding to data subject requests as required by applicable data protection laws.
                        """),

                        _buildSection("5. INTELLECTUAL PROPERTY", """
5.1 Our IP Rights
We retain all right, title, and interest in and to our intellectual property, including the Services and any modifications or enhancements thereto.

5.2 Customer IP Rights
Customer retains all right, title, and interest in and to its intellectual property, including Customer Data.

5.3 License to Customer
Subject to this Agreement, we grant Customer a non-exclusive, non-transferable license to use the Services during the term.

5.4 Feedback
Customer grants us a royalty-free license to use any feedback provided regarding the Services.
                        """),

                        _buildSection("6. WARRANTIES AND DISCLAIMERS", """
6.1 Mutual Warranties
Each party warrants that it has the authority to enter into this Agreement and that the execution and performance of this Agreement will not violate any other agreement.

6.2 Service Warranties
We warrant that the Services will be performed with professional skill and care and will substantially conform to the applicable Service Schedule.

6.3 Disclaimer
EXCEPT AS EXPRESSLY SET FORTH HEREIN, THE SERVICES ARE PROVIDED "AS IS" WITHOUT WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED.
                        """),

                        _buildSection("7. LIMITATION OF LIABILITY", """
7.1 Limitation
IN NO EVENT WILL EITHER PARTY'S LIABILITY EXCEED THE TOTAL FEES PAID OR PAYABLE UNDER THIS AGREEMENT IN THE TWELVE (12) MONTHS PRECEDING THE CLAIM.

7.2 Excluded Damages
NEITHER PARTY WILL BE LIABLE FOR INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES.

7.3 Exceptions
The limitations in this Section do not apply to breaches of confidentiality, violations of intellectual property rights, or gross negligence.
                        """),

                        _buildSection("8. TERM AND TERMINATION", """
8.1 Term
This Agreement commences on the Effective Date and continues until terminated in accordance with its terms.

8.2 Termination for Convenience
Either party may terminate this Agreement with thirty (30) days' written notice.

8.3 Termination for Cause
Either party may terminate this Agreement immediately upon written notice if the other party materially breaches this Agreement.

8.4 Effect of Termination
Upon termination, all rights and obligations will cease except those that by their nature should survive termination.
                        """),

                        _buildSection("9. GENERAL PROVISIONS", """
9.1 Governing Law
This Agreement will be governed by and construed in accordance with the laws of [Jurisdiction].

9.2 Dispute Resolution
Any disputes will be resolved through binding arbitration in accordance with the rules of [Arbitration Body].

9.3 Entire Agreement
This Agreement constitutes the entire agreement between the parties and supersedes all prior agreements and understandings.

9.4 Amendment
This Agreement may only be amended by written agreement signed by both parties.

9.5 Severability
If any provision of this Agreement is held invalid or unenforceable, the remainder will remain in full force and effect.
                        """),
                      ],
                    ),
                  ),

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning_amber,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
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
                        Text(
                          "By clicking 'I Accept' below, you acknowledge that you have read, understood, and agree to be bound by the terms of this Master Service Agreement. This is a legally binding contract.",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 100), // Extra space to ensure full scroll
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
                      value: hasReadTerms && hasReadPrivacy,
                      onChanged: hasReadTerms ? (value) {
                        hasReadPrivacy = value ?? false;
                        setState(() {});
                      } : null,
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "I have read and agree to the Master Service Agreement",
                        style: TextStyle(
                          fontSize: 14,
                          color: hasReadTerms ? disabledBoldColor : disabledColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                if (!hasReadTerms)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
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
                            "Please scroll through the entire document to enable acceptance",
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
                  width: double.infinity,
                  child: QButton(
                    label: hasReadTerms && hasReadPrivacy ? "Accept Agreement" : "Please Read Terms First",
                    onPressed: hasReadTerms && hasReadPrivacy ? () {
                      ss("Master Service Agreement accepted successfully");
                    } : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
