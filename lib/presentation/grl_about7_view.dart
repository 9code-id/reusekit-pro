import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAbout7View extends StatefulWidget {
  @override
  State<GrlAbout7View> createState() => _GrlAbout7ViewState();
}

class _GrlAbout7ViewState extends State<GrlAbout7View> {
  String selectedPolicyType = 'privacy';
  
  List<Map<String, dynamic>> policyTypes = [
    {
      "id": "privacy",
      "title": "Privacy Policy",
      "icon": Icons.privacy_tip,
      "color": primaryColor,
    },
    {
      "id": "terms",
      "title": "Terms of Service",
      "icon": Icons.description,
      "color": infoColor,
    },
    {
      "id": "cookies",
      "title": "Cookie Policy",
      "icon": Icons.cookie,
      "color": warningColor,
    },
    {
      "id": "security",
      "title": "Security Policy",
      "icon": Icons.security,
      "color": successColor,
    },
  ];

  Map<String, Map<String, dynamic>> policyContent = {
    "privacy": {
      "title": "Privacy Policy",
      "lastUpdated": "December 2024",
      "sections": [
        {
          "title": "Information We Collect",
          "content": "We collect information you provide directly to us, such as when you create an account, make a purchase, or contact us for support. This includes your name, email address, phone number, and payment information."
        },
        {
          "title": "How We Use Your Information",
          "content": "We use the information we collect to provide, maintain, and improve our services, process transactions, send you communications, and comply with legal obligations."
        },
        {
          "title": "Information Sharing",
          "content": "We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy or as required by law."
        },
        {
          "title": "Data Security",
          "content": "We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction."
        },
        {
          "title": "Your Rights",
          "content": "You have the right to access, update, or delete your personal information. You may also object to certain processing of your data or request data portability."
        },
      ]
    },
    "terms": {
      "title": "Terms of Service",
      "lastUpdated": "December 2024",
      "sections": [
        {
          "title": "Acceptance of Terms",
          "content": "By accessing and using our services, you accept and agree to be bound by the terms and provision of this agreement."
        },
        {
          "title": "Use License",
          "content": "Permission is granted to temporarily download one copy of our materials for personal, non-commercial transitory viewing only."
        },
        {
          "title": "Disclaimer",
          "content": "The materials on our website are provided on an 'as is' basis. We make no warranties, expressed or implied, and hereby disclaim all other warranties."
        },
        {
          "title": "Limitations",
          "content": "In no event shall our company or its suppliers be liable for any damages arising out of the use or inability to use the materials on our website."
        },
        {
          "title": "Modifications",
          "content": "We may revise these terms of service at any time without notice. By using this website, you are agreeing to be bound by the current version of these terms."
        },
      ]
    },
    "cookies": {
      "title": "Cookie Policy",
      "lastUpdated": "December 2024",
      "sections": [
        {
          "title": "What Are Cookies",
          "content": "Cookies are small text files that are placed on your computer or mobile device when you visit our website. They are widely used to make websites work more efficiently."
        },
        {
          "title": "How We Use Cookies",
          "content": "We use cookies to understand how you use our website, remember your preferences, and improve your experience. We also use cookies for analytics and advertising purposes."
        },
        {
          "title": "Types of Cookies",
          "content": "We use both session cookies (which expire when you close your browser) and persistent cookies (which stay on your device until deleted or expired)."
        },
        {
          "title": "Managing Cookies",
          "content": "You can control and manage cookies in your browser settings. However, disabling cookies may affect the functionality of our website."
        },
        {
          "title": "Third-Party Cookies",
          "content": "We may allow third-party companies to place cookies on our website for analytics, advertising, and social media functionality."
        },
      ]
    },
    "security": {
      "title": "Security Policy",
      "lastUpdated": "December 2024",
      "sections": [
        {
          "title": "Data Encryption",
          "content": "All data transmitted between you and our servers is encrypted using industry-standard SSL/TLS protocols to ensure your information remains secure."
        },
        {
          "title": "Access Controls",
          "content": "We implement strict access controls to ensure that only authorized personnel can access your personal information, and all access is logged and monitored."
        },
        {
          "title": "Regular Security Audits",
          "content": "We conduct regular security audits and penetration testing to identify and address potential vulnerabilities in our systems."
        },
        {
          "title": "Incident Response",
          "content": "In the event of a security breach, we have procedures in place to quickly respond, contain the incident, and notify affected users as required by law."
        },
        {
          "title": "Employee Training",
          "content": "All employees receive regular security training to ensure they understand their role in protecting customer data and maintaining security standards."
        },
      ]
    },
  };

  List<Map<String, dynamic>> legalContacts = [
    {
      "title": "Privacy Officer",
      "name": "Jane Smith",
      "email": "privacy@company.com",
      "phone": "+1 (555) 123-4567",
      "icon": Icons.privacy_tip,
    },
    {
      "title": "Legal Counsel",
      "name": "Robert Johnson",
      "email": "legal@company.com",
      "phone": "+1 (555) 123-4568",
      "icon": Icons.gavel,
    },
    {
      "title": "Data Protection Officer",
      "name": "Maria Garcia",
      "email": "dpo@company.com",
      "phone": "+1 (555) 123-4569",
      "icon": Icons.security,
    },
  ];

  List<Map<String, dynamic>> certifications = [
    {
      "name": "ISO 27001 Certified",
      "description": "Information Security Management",
      "icon": Icons.verified,
      "color": successColor,
    },
    {
      "name": "SOC 2 Type II",
      "description": "Security & Availability Controls",
      "icon": Icons.security,
      "color": infoColor,
    },
    {
      "name": "GDPR Compliant",
      "description": "European Data Protection",
      "icon": Icons.privacy_tip,
      "color": primaryColor,
    },
    {
      "name": "CCPA Compliant",
      "description": "California Consumer Privacy",
      "icon": Icons.shield,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedPolicy = policyContent[selectedPolicyType]!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Legal & Privacy"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.policy,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          "Legal Information",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Our commitment to transparency and your privacy. Review our policies and understand how we protect your data and respect your rights.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Policy Type Selector
            Text(
              "Policy Documents",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: policyTypes.map((type) {
                final isSelected = selectedPolicyType == type["id"];
                return GestureDetector(
                  onTap: () {
                    selectedPolicyType = type["id"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? (type["color"] as Color).withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: isSelected ? (type["color"] as Color) : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: (type["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            type["icon"] as IconData,
                            color: type["color"] as Color,
                            size: 32,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${type["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? (type["color"] as Color) : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Selected Policy Content
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        policyTypes.firstWhere((type) => type["id"] == selectedPolicyType)["icon"] as IconData,
                        color: policyTypes.firstWhere((type) => type["id"] == selectedPolicyType)["color"] as Color,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${selectedPolicy["title"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: policyTypes.firstWhere((type) => type["id"] == selectedPolicyType)["color"] as Color,
                              ),
                            ),
                            Text(
                              "Last updated: ${selectedPolicy["lastUpdated"]}",
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
                  
                  SizedBox(height: spMd),
                  
                  // Policy Sections
                  ...(selectedPolicy["sections"] as List<Map<String, dynamic>>).map((section) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${section["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
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
                  )).toList(),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Download PDF",
                      size: bs.md,
                      icon: Icons.download,
                      onPressed: () {
                        ss("PDF download started");
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Certifications
            Text(
              "Compliance & Certifications",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: certifications.map((cert) => Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (cert["color"] as Color).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        cert["icon"] as IconData,
                        color: cert["color"] as Color,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${cert["name"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${cert["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Data Protection Summary
            Container(
              width: double.infinity,
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
                        Icons.shield,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Data Protection Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "We never sell your personal data to third parties",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "All data is encrypted in transit and at rest",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "You have full control over your data and privacy settings",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Regular security audits and compliance monitoring",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Legal Contacts
            Text(
              "Legal Contacts",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...legalContacts.map((contact) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      contact["icon"] as IconData,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${contact["title"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${contact["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${contact["email"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${contact["phone"]}",
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
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Questions CTA
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, infoColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.help_outline,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Have Questions?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "If you have any questions about our policies or how we handle your data, don't hesitate to contact our legal team.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Legal Team",
                          size: bs.md,
                          onPressed: () {},
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
