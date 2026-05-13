import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPrivacyPolicyView extends StatefulWidget {
  const SmaPrivacyPolicyView({super.key});

  @override
  State<SmaPrivacyPolicyView> createState() => _SmaPrivacyPolicyViewState();
}

class _SmaPrivacyPolicyViewState extends State<SmaPrivacyPolicyView> {
  String searchQuery = "";
  
  List<Map<String, dynamic>> policyData = [
    {
      "section": "Information Collection",
      "content": "We collect information you provide directly to us, such as when you create an account, post content, or communicate with us.",
      "lastUpdated": "2024-06-15",
      "isExpanded": false,
    },
    {
      "section": "Information Use",
      "content": "We use the information we collect to provide, maintain, and improve our services, process transactions, and communicate with you.",
      "lastUpdated": "2024-06-10",
      "isExpanded": false,
    },
    {
      "section": "Information Sharing",
      "content": "We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy.",
      "lastUpdated": "2024-06-12",
      "isExpanded": false,
    },
    {
      "section": "Data Security",
      "content": "We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.",
      "lastUpdated": "2024-06-08",
      "isExpanded": false,
    },
    {
      "section": "Cookies and Tracking",
      "content": "We use cookies and similar technologies to enhance your experience, analyze usage patterns, and deliver personalized content.",
      "lastUpdated": "2024-06-05",
      "isExpanded": false,
    },
    {
      "section": "User Rights",
      "content": "You have the right to access, update, or delete your personal information. You may also opt-out of certain communications.",
      "lastUpdated": "2024-06-14",
      "isExpanded": false,
    },
    {
      "section": "Children's Privacy",
      "content": "Our service is not intended for children under 13. We do not knowingly collect personal information from children under 13.",
      "lastUpdated": "2024-06-07",
      "isExpanded": false,
    },
    {
      "section": "International Transfers",
      "content": "Your information may be transferred to and processed in countries other than your country of residence.",
      "lastUpdated": "2024-06-11",
      "isExpanded": false,
    },
  ];

  List<Map<String, dynamic>> get filteredPolicy {
    return policyData.where((policy) =>
        searchQuery.isEmpty ||
        (policy["section"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (policy["content"] as String).toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header Info
            Container(
              padding: EdgeInsets.all(spSm),
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
                        Icons.privacy_tip,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Effective Date: January 1, 2024",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Last Updated: June 15, 2024",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "This Privacy Policy describes how we collect, use, and share your information when you use our social media platform.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Search
            QTextField(
              label: "Search privacy policy...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Key Points Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Key Points",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• We collect information you provide and usage data",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                  Text(
                    "• We use data to improve services and personalize content", 
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                  Text(
                    "• We don't sell your personal information to third parties",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                  Text(
                    "• You can access, update, or delete your information",
                    style: TextStyle(fontSize: 14, color: disabledBoldColor),
                  ),
                ],
              ),
            ),

            // Policy Sections
            ...filteredPolicy.map((section) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    // Section Header
                    GestureDetector(
                      onTap: () {
                        section["isExpanded"] = !(section["isExpanded"] as bool);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (section["isExpanded"] as bool) 
                              ? primaryColor.withAlpha(20) 
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${section["section"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Last updated: ${section["lastUpdated"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              (section["isExpanded"] as bool) 
                                  ? Icons.expand_less 
                                  : Icons.expand_more,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Section Content
                    if (section["isExpanded"] as bool)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        child: Text(
                          "${section["content"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),

            // Contact Information
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Contact Us",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "If you have any questions about this Privacy Policy, please contact us:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "privacy@socialmedia.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "+1 (555) 123-4567",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
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
