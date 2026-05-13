import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaPrivacyPolicyView extends StatefulWidget {
  const BfaPrivacyPolicyView({super.key});

  @override
  State<BfaPrivacyPolicyView> createState() => _BfaPrivacyPolicyViewState();
}

class _BfaPrivacyPolicyViewState extends State<BfaPrivacyPolicyView> {
  List<Map<String, dynamic>> sections = [
    {
      "title": "1. Information We Collect",
      "content": """We collect information you provide directly to us, such as when you:

• Create an account and provide your name, email address, and other contact information
• Use our services and provide content, messages, or other information
• Contact us for customer support
• Participate in surveys, contests, or promotional activities

We also automatically collect certain information when you use our app:
• Device information (model, operating system, unique device identifiers)
• Usage data (features used, time spent, interactions)
• Location data (with your permission)
• Log data (IP address, browser type, referring/exit pages)

We may receive information from third parties:
• Social media platforms when you connect your accounts
• Analytics providers
• Advertising partners
• Other users when they provide information about you""",
      "icon": Icons.info
    },
    {
      "title": "2. How We Use Your Information",
      "content": """We use the information we collect to:

• Provide, maintain, and improve our services
• Process transactions and send related information
• Send technical notices, updates, and support messages
• Respond to your comments, questions, and customer service requests
• Communicate with you about products, services, and events
• Monitor and analyze trends, usage, and activities
• Personalize and improve your experience
• Facilitate contests, sweepstakes, and promotions
• Detect, investigate, and prevent fraudulent transactions and other illegal activities
• Comply with legal obligations

We may also use your information for other purposes with your consent or as permitted by law.""",
      "icon": Icons.settings
    },
    {
      "title": "3. Information Sharing and Disclosure",
      "content": """We may share your information in the following situations:

• With vendors, consultants, and other service providers who need access to such information to carry out work on our behalf
• In response to legal requests or to comply with applicable laws, regulations, or legal processes
• To protect the rights, property, and safety of ReuseKit, our users, or others
• In connection with or during negotiation of any merger, sale of assets, financing, or acquisition
• With your consent or at your direction

We do not sell, trade, or otherwise transfer your personal information to third parties for their marketing purposes without your explicit consent.

For analytics and advertising:
• We may use third-party analytics providers
• We may show you personalized advertisements
• You can opt out of targeted advertising through your device settings""",
      "icon": Icons.share
    },
    {
      "title": "4. Data Security",
      "content": """We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction.

Our security measures include:
• Encryption of data in transit and at rest
• Regular security assessments and updates
• Access controls and authentication requirements
• Employee training on data protection
• Secure development practices

However, no internet or electronic storage system is 100% secure. We cannot guarantee absolute security of your information.

If we become aware of a security breach that affects your personal information, we will notify you and relevant authorities as required by law.""",
      "icon": Icons.security
    },
    {
      "title": "5. Data Retention",
      "content": """We retain your personal information for as long as necessary to:

• Provide you with our services
• Comply with legal obligations
• Resolve disputes
• Enforce our agreements

Specific retention periods:
• Account information: Retained while your account is active and for 3 years after deactivation
• Usage data: Retained for 2 years for analytics purposes
• Support communications: Retained for 5 years
• Legal compliance data: Retained as required by applicable laws

You can request deletion of your personal information at any time, subject to certain exceptions for legal compliance, ongoing disputes, or security purposes.""",
      "icon": Icons.schedule
    },
    {
      "title": "6. Your Rights and Choices",
      "content": """Depending on your location, you may have certain rights regarding your personal information:

• Access: Request a copy of the personal information we have about you
• Correction: Request correction of inaccurate information
• Deletion: Request deletion of your personal information
• Portability: Request transfer of your data to another service
• Objection: Object to processing of your information for certain purposes
• Restriction: Request restriction of processing in certain circumstances

You can exercise these rights by:
• Using in-app privacy settings
• Contacting us through the app's support section
• Emailing us at privacy@reusekit.com

We will respond to your requests within 30 days, or as required by applicable law.""",
      "icon": Icons.account_circle
    },
    {
      "title": "7. Cookies and Tracking Technologies",
      "content": """We use cookies and similar tracking technologies to:

• Remember your preferences and settings
• Understand how you use our services
• Improve our services and user experience
• Provide personalized content and advertisements

Types of cookies we use:
• Essential cookies: Required for basic app functionality
• Analytics cookies: Help us understand usage patterns
• Preference cookies: Remember your settings and preferences
• Marketing cookies: Deliver relevant advertisements

You can control cookies through:
• Your device settings
• Browser settings (for web components)
• In-app privacy controls
• Third-party opt-out tools

Please note that disabling certain cookies may affect app functionality.""",
      "icon": Icons.cookie
    },
    {
      "title": "8. International Data Transfers",
      "content": """Your information may be transferred to and processed in countries other than your country of residence. These countries may have different data protection laws.

When we transfer your information internationally, we:
• Ensure adequate protection through appropriate safeguards
• Use standard contractual clauses approved by relevant authorities
• Rely on adequacy decisions where available
• Obtain your consent when required

Countries where your data may be processed:
• United States (our primary servers)
• European Union (for EU users)
• Other countries where our service providers operate

We take steps to ensure your information receives adequate protection regardless of where it is processed.""",
      "icon": Icons.public
    },
    {
      "title": "9. Children's Privacy",
      "content": """Our services are not intended for children under 13 years of age. We do not knowingly collect personal information from children under 13.

If we become aware that a child under 13 has provided us with personal information, we will:
• Delete such information from our servers
• Notify the child's parent or guardian
• Take steps to prevent future collection

Parents and guardians can:
• Review their child's information
• Request deletion of their child's information
• Refuse to permit further collection of their child's information

For users between 13 and 18, we recommend parental guidance when using our services.""",
      "icon": Icons.child_care
    },
    {
      "title": "10. Third-Party Services",
      "content": """Our app may contain links to third-party websites, services, or applications. We are not responsible for the privacy practices of these third parties.

Third-party services we may use:
• Analytics providers (Google Analytics, Firebase)
• Cloud storage providers (AWS, Google Cloud)
• Payment processors
• Social media platforms
• Advertising networks

We encourage you to read the privacy policies of any third-party services you use. This Privacy Policy does not apply to information collected by third parties.

We may update our list of third-party providers. Check this policy regularly for updates.""",
      "icon": Icons.link
    },
    {
      "title": "11. Contact Information",
      "content": """If you have any questions about this Privacy Policy or our privacy practices, please contact us:

Email: privacy@reusekit.com
Phone: +1 (555) 123-4567
Address: 123 Privacy Street, City, State 12345

Data Protection Officer: dpo@reusekit.com

For EU residents:
EU Representative: eu-representative@reusekit.com

We will respond to your inquiries within 30 days or as required by applicable law.""",
      "icon": Icons.contact_mail
    }
  ];

  List<Map<String, dynamic>> dataTypes = [
    {
      "type": "Personal Information",
      "description": "Name, email, phone number, address",
      "purpose": "Account management and communication",
      "retention": "Active account + 3 years",
      "sharing": "Service providers only"
    },
    {
      "type": "Usage Data",
      "description": "App interactions, features used, time spent",
      "purpose": "Analytics and service improvement",
      "retention": "2 years",
      "sharing": "Analytics providers"
    },
    {
      "type": "Device Information",
      "description": "Device model, OS, unique identifiers",
      "purpose": "Technical support and optimization",
      "retention": "Active account + 1 year",
      "sharing": "Technical service providers"
    },
    {
      "type": "Location Data",
      "description": "GPS coordinates, IP-based location",
      "purpose": "Location-based features",
      "retention": "Active use + 6 months",
      "sharing": "Map service providers"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        actions: [
          Icon(
            Icons.privacy_tip,
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
              color: primaryColor.withAlpha(20),
              border: Border(
                bottom: BorderSide(color: primaryColor.withAlpha(40)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "ReuseKit Privacy Policy",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Last updated: December 20, 2024",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "We are committed to protecting your privacy and personal data",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Content
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
                              Icons.privacy_tip,
                              color: primaryColor,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Your Privacy Matters",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "This Privacy Policy explains how ReuseKit collects, uses, and protects your personal information when you use our mobile application. We are committed to transparency and giving you control over your data.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Data Summary Table
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
                      spacing: spMd,
                      children: [
                        Text(
                          "Data Collection Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),

                        ...dataTypes.map((data) {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            margin: EdgeInsets.only(bottom: spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${data["type"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${data["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Kept for: ${data["retention"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Shared with: ${data["sharing"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Policy Sections
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
                          Row(
                            children: [
                              Icon(
                                section["icon"] as IconData,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${section["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
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

                  // Privacy Controls
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
                          "Privacy Controls",
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
                                label: "Manage Data",
                                icon: Icons.settings,
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo(PrivacySettingsView)
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Download Data",
                                icon: Icons.download,
                                size: bs.sm,
                                onPressed: () {
                                  // Handle data download
                                  si("Preparing your data for download...");
                                },
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Delete Account",
                                icon: Icons.delete_forever,
                                size: bs.sm,
                                onPressed: () {
                                  // Handle account deletion
                                  // navigateTo(DeleteAccountView)
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Contact Privacy Team",
                                icon: Icons.support_agent,
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo(ContactPrivacyView)
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Compliance Information
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(40)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.verified,
                              color: successColor,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Compliance & Certifications",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "• GDPR compliant for EU users\n• CCPA compliant for California users\n• SOC 2 Type II certified\n• ISO 27001 certified for information security\n• Regular third-party security audits",
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spXl),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
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
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Terms",
                    icon: Icons.gavel,
                    size: bs.sm,
                    onPressed: () {
                      // navigateTo(TermsConditionsView)
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Privacy Settings",
                    icon: Icons.tune,
                    size: bs.sm,
                    onPressed: () {
                      // navigateTo(PrivacySettingsView)
                    },
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
