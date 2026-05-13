import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsPrivacyPolicyView extends StatefulWidget {
  const BrsPrivacyPolicyView({super.key});

  @override
  State<BrsPrivacyPolicyView> createState() => _BrsPrivacyPolicyViewState();
}

class _BrsPrivacyPolicyViewState extends State<BrsPrivacyPolicyView> {
  int selectedSection = 0;
  
  final List<Map<String, dynamic>> privacySections = [
    {
      "title": "Data Collection",
      "icon": Icons.data_usage,
      "content": "We collect information you provide directly to us, such as when you create an account, book services, or contact us for support. This includes your name, email address, phone number, and service preferences.",
      "details": [
        "Personal identification information",
        "Service booking history",
        "Payment information",
        "Location data for service delivery",
        "Communication preferences"
      ]
    },
    {
      "title": "Information Usage",
      "icon": Icons.info,
      "content": "We use the information we collect to provide, maintain, and improve our services, process transactions, send notifications, and respond to your requests.",
      "details": [
        "Service booking and management",
        "Payment processing",
        "Customer support",
        "Marketing communications",
        "Service improvement"
      ]
    },
    {
      "title": "Information Sharing",
      "icon": Icons.share,
      "content": "We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy.",
      "details": [
        "Service providers and partners",
        "Legal compliance requirements",
        "Business transfers",
        "With your explicit consent",
        "Aggregated non-personal data"
      ]
    },
    {
      "title": "Data Security",
      "icon": Icons.security,
      "content": "We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.",
      "details": [
        "Encryption of sensitive data",
        "Secure payment processing",
        "Regular security audits",
        "Access controls and monitoring",
        "Data backup and recovery"
      ]
    },
    {
      "title": "Cookies & Tracking",
      "icon": Icons.cookie,
      "content": "We use cookies and similar tracking technologies to enhance your experience, analyze usage patterns, and provide personalized content.",
      "details": [
        "Essential cookies for functionality",
        "Analytics cookies for improvement",
        "Preference cookies for personalization",
        "Third-party tracking pixels",
        "Cookie management options"
      ]
    },
    {
      "title": "Your Rights",
      "icon": Icons.account_circle,
      "content": "You have certain rights regarding your personal information, including the right to access, update, delete, or restrict the processing of your data.",
      "details": [
        "Access your personal data",
        "Correct inaccurate information",
        "Delete your account and data",
        "Restrict data processing",
        "Data portability rights"
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to search
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.privacy_tip,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Last updated: December 2024",
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
                  SizedBox(height: spSm),
                  Text(
                    "We are committed to protecting your privacy and ensuring the security of your personal information. This policy explains how we collect, use, and safeguard your data.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Section Tabs
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: privacySections.length,
                itemBuilder: (context, index) {
                  final section = privacySections[index];
                  final isSelected = selectedSection == index;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedSection = index;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                        boxShadow: isSelected ? [shadowSm] : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            section["icon"] as IconData,
                            size: 18,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${section["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Selected Section Content
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          privacySections[selectedSection]["icon"] as IconData,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${privacySections[selectedSection]["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "${privacySections[selectedSection]["content"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.6,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Key Points:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  ...(privacySections[selectedSection]["details"] as List).map((detail) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "$detail",
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
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Contact Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Questions or Concerns?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "If you have any questions about this Privacy Policy or our data practices, please contact us:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "privacy@barbershopapp.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "+1 (555) 123-4567",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Action Buttons
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Download Privacy Policy",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      ss("Privacy policy downloaded successfully");
                    },
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Contact Support",
                        icon: Icons.support_agent,
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to contact support
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Manage Data",
                        icon: Icons.settings,
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to data management
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
