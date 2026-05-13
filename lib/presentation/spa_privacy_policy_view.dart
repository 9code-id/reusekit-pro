import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaPrivacyPolicyView extends StatefulWidget {
  const SpaPrivacyPolicyView({super.key});

  @override
  State<SpaPrivacyPolicyView> createState() => _SpaPrivacyPolicyViewState();
}

class _SpaPrivacyPolicyViewState extends State<SpaPrivacyPolicyView> {
  bool hasAcceptedPolicy = false;
  String selectedSection = "Overview";

  final List<Map<String, dynamic>> sections = [
    {
      "title": "Overview",
      "icon": Icons.info_outline,
      "color": primaryColor,
    },
    {
      "title": "Data Collection",
      "icon": Icons.data_usage,
      "color": infoColor,
    },
    {
      "title": "Data Usage",
      "icon": Icons.settings,
      "color": warningColor,
    },
    {
      "title": "Data Sharing",
      "icon": Icons.share,
      "color": successColor,
    },
    {
      "title": "Data Security",
      "icon": Icons.security,
      "color": dangerColor,
    },
    {
      "title": "Your Rights",
      "icon": Icons.gavel,
      "color": primaryColor,
    },
    {
      "title": "Cookies",
      "icon": Icons.cookie,
      "color": infoColor,
    },
    {
      "title": "Contact",
      "icon": Icons.contact_support,
      "color": successColor,
    },
  ];

  final Map<String, Map<String, dynamic>> sectionContent = {
    "Overview": {
      "subtitle": "Our Commitment to Your Privacy",
      "content": [
        "At Spa Paradise, we are committed to protecting your privacy and personal information.",
        "This privacy policy explains how we collect, use, and safeguard your information when you use our services.",
        "We believe in transparency and want you to understand your rights regarding your personal data.",
        "This policy applies to all our services, including our mobile app, website, and in-person spa treatments.",
        "By using our services, you agree to the collection and use of information in accordance with this policy.",
      ],
      "highlights": [
        "We never sell your personal information",
        "Your health data is encrypted and secure",
        "You can request data deletion at any time",
        "We only collect necessary information",
      ]
    },
    "Data Collection": {
      "subtitle": "What Information We Collect",
      "content": [
        "Personal Information: Name, email address, phone number, date of birth, and billing address.",
        "Health Information: Medical conditions, allergies, medications, and treatment preferences.",
        "Usage Data: How you interact with our app and services, including appointment history.",
        "Device Information: Device type, operating system, and unique device identifiers.",
        "Location Data: Your location when using location-based features (with your permission).",
      ],
      "highlights": [
        "Health data is collected only for treatment purposes",
        "Location data is optional and can be disabled",
        "We don't collect unnecessary personal information",
        "All data collection is transparent and consensual",
      ]
    },
    "Data Usage": {
      "subtitle": "How We Use Your Information",
      "content": [
        "Service Delivery: To provide and personalize your spa treatments and wellness services.",
        "Communication: To send appointment reminders, service updates, and promotional offers.",
        "Health & Safety: To ensure treatments are safe and appropriate for your health conditions.",
        "Business Operations: To manage bookings, process payments, and improve our services.",
        "Legal Compliance: To comply with applicable laws and regulations in the wellness industry.",
      ],
      "highlights": [
        "Data is used only for stated purposes",
        "You can opt out of promotional communications",
        "Health data is used solely for your safety",
        "We don't use data for unauthorized purposes",
      ]
    },
    "Data Sharing": {
      "subtitle": "Who We Share Information With",
      "content": [
        "Service Providers: Trusted third parties who help us deliver services (payment processors, appointment systems).",
        "Healthcare Partners: Licensed healthcare providers when necessary for your treatment.",
        "Legal Authorities: When required by law or to protect our rights and safety.",
        "Business Transfers: In the event of a merger, acquisition, or asset sale.",
        "With Your Consent: Any other sharing will be done only with your explicit permission.",
      ],
      "highlights": [
        "We never sell your data to third parties",
        "Partners are bound by confidentiality agreements",
        "Health information sharing is strictly controlled",
        "You can revoke consent for data sharing",
      ]
    },
    "Data Security": {
      "subtitle": "How We Protect Your Information",
      "content": [
        "Encryption: All sensitive data is encrypted both in transit and at rest using industry-standard methods.",
        "Access Controls: Only authorized personnel have access to your information on a need-to-know basis.",
        "Regular Audits: We conduct regular security audits and vulnerability assessments.",
        "Staff Training: All employees receive privacy and security training.",
        "Incident Response: We have procedures in place to respond quickly to any security incidents.",
      ],
      "highlights": [
        "Bank-level encryption for all sensitive data",
        "24/7 security monitoring",
        "Regular security updates and patches",
        "Immediate incident response procedures",
      ]
    },
    "Your Rights": {
      "subtitle": "Your Privacy Rights and Controls",
      "content": [
        "Access: You can request a copy of all personal information we have about you.",
        "Correction: You can request correction of any inaccurate or incomplete information.",
        "Deletion: You can request deletion of your personal information (subject to legal requirements).",
        "Portability: You can request transfer of your data to another service provider.",
        "Restriction: You can request that we limit how we use your information.",
      ],
      "highlights": [
        "Easy data access through your account",
        "Quick response to privacy requests",
        "No charge for most privacy requests",
        "Clear process for exercising your rights",
      ]
    },
    "Cookies": {
      "subtitle": "Cookies and Tracking Technologies",
      "content": [
        "Essential Cookies: Required for basic functionality like login and appointment booking.",
        "Analytics Cookies: Help us understand how you use our services to improve them.",
        "Preference Cookies: Remember your settings and preferences for a better experience.",
        "Marketing Cookies: Used to show you relevant offers and promotions (with your consent).",
        "Third-party Cookies: Some features may use cookies from trusted partners (like payment processors).",
      ],
      "highlights": [
        "You can control cookie preferences",
        "Essential cookies cannot be disabled",
        "Analytics data is anonymized",
        "Marketing cookies require explicit consent",
      ]
    },
    "Contact": {
      "subtitle": "Contact Us About Privacy",
      "content": [
        "Privacy Officer: Contact our dedicated privacy officer for any privacy-related questions.",
        "Email: privacy@spaparadise.com for privacy inquiries and requests.",
        "Phone: Call our privacy hotline at 1-800-SPA-PRIVACY (1-800-772-7748).",
        "Mail: Send written requests to our Privacy Department at our main office.",
        "Response Time: We respond to privacy requests within 30 days as required by law.",
      ],
      "highlights": [
        "Dedicated privacy support team",
        "Multiple ways to contact us",
        "Fast response to privacy concerns",
        "Clear escalation process for complaints",
      ]
    },
  };

  @override
  Widget build(BuildContext context) {
    final currentContent = sectionContent[selectedSection]!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        actions: [
          if (hasAcceptedPolicy)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "✓ Accepted",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar Navigation
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
                    color: primaryColor.withAlpha(10),
                  ),
                  child: Text(
                    "Sections",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: sections.length,
                    itemBuilder: (context, index) {
                      final section = sections[index];
                      final isSelected = selectedSection == section["title"];
                      
                      return GestureDetector(
                        onTap: () {
                          selectedSection = section["title"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                            border: Border(
                              left: BorderSide(
                                width: 3,
                                color: isSelected ? primaryColor : Colors.transparent,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                section["icon"] as IconData,
                                size: 20,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${section["title"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (sections.firstWhere((s) => s["title"] == selectedSection)["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          sections.firstWhere((s) => s["title"] == selectedSection)["icon"] as IconData,
                          color: sections.firstWhere((s) => s["title"] == selectedSection)["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedSection,
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${currentContent["subtitle"]}",
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

                  SizedBox(height: spLg),

                  // Key Highlights
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (sections.firstWhere((s) => s["title"] == selectedSection)["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: (sections.firstWhere((s) => s["title"] == selectedSection)["color"] as Color).withAlpha(30),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Key Points:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        ...((currentContent["highlights"] as List).map((highlight) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: spXs),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "$highlight",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList()),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Detailed Content
                  Column(
                    children: ((currentContent["content"] as List).asMap().entries.map((entry) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: (sections.firstWhere((s) => s["title"] == selectedSection)["color"] as Color).withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${entry.key + 1}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: sections.firstWhere((s) => s["title"] == selectedSection)["color"] as Color,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${entry.value}",
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
                    }).toList()),
                  ),

                  SizedBox(height: spLg),

                  // Privacy Actions
                  if (selectedSection == "Your Rights")
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withAlpha(20),
                            primaryColor.withAlpha(5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Exercise Your Privacy Rights",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Download Data",
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Data download request submitted");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Delete Account",
                                  size: bs.sm,
                                  onPressed: () {
                                    sw("This action cannot be undone");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  // Contact Section
                  if (selectedSection == "Contact")
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.contact_support,
                                size: 48,
                                color: primaryColor,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Have Privacy Questions?",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Email Us",
                                      size: bs.md,
                                      onPressed: () {
                                        si("Opening email client...");
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QButton(
                                      label: "Call Us",
                                      size: bs.md,
                                      onPressed: () {
                                        si("Calling privacy hotline...");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spLg),
                      ],
                    ),

                  // Acceptance Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: hasAcceptedPolicy ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: hasAcceptedPolicy ? successColor.withAlpha(30) : warningColor.withAlpha(30),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          hasAcceptedPolicy ? Icons.check_circle : Icons.policy,
                          size: 40,
                          color: hasAcceptedPolicy ? successColor : warningColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          hasAcceptedPolicy ? "Privacy Policy Accepted" : "Privacy Policy Agreement",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: hasAcceptedPolicy ? successColor : warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          hasAcceptedPolicy 
                              ? "You have accepted our privacy policy. You can review or change your preferences anytime."
                              : "By accepting, you agree to our privacy practices as described in this policy.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (!hasAcceptedPolicy) ...[
                          SizedBox(height: spSm),
                          QButton(
                            label: "Accept Privacy Policy",
                            size: bs.md,
                            onPressed: () {
                              hasAcceptedPolicy = true;
                              setState(() {});
                              ss("Privacy policy accepted successfully!");
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
