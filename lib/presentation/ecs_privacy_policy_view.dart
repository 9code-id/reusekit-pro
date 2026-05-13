import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsPrivacyPolicyView extends StatefulWidget {
  const EcsPrivacyPolicyView({super.key});

  @override
  State<EcsPrivacyPolicyView> createState() => _EcsPrivacyPolicyViewState();
}

class _EcsPrivacyPolicyViewState extends State<EcsPrivacyPolicyView> {
  List<Map<String, dynamic>> privacySections = [
    {
      "title": "1. Information We Collect",
      "content": "We collect information you provide directly to us, such as when you:\n\n• Create an account\n• Make a purchase\n• Contact customer support\n• Subscribe to newsletters\n• Participate in surveys or promotions\n\n**Personal Information:**\n• Name, email address, phone number\n• Billing and shipping addresses\n• Payment information (encrypted)\n• Account preferences and settings\n\n**Automatic Information:**\n• Device information and identifiers\n• IP address and location data\n• App usage and interaction data\n• Purchase history and preferences",
      "icon": Icons.info,
      "color": infoColor,
    },
    {
      "title": "2. How We Use Your Information",
      "content": "We use the information we collect to:\n\n**Provide Services:**\n• Process and fulfill orders\n• Manage your account\n• Provide customer support\n• Send transactional communications\n\n**Improve Experience:**\n• Personalize content and recommendations\n• Analyze usage patterns\n• Develop new features\n• Optimize app performance\n\n**Marketing & Communications:**\n• Send promotional offers (with consent)\n• Share product updates\n• Conduct market research\n• Administer contests and surveys",
      "icon": Icons.settings,
      "color": primaryColor,
    },
    {
      "title": "3. Information Sharing",
      "content": "We may share your information with:\n\n**Service Providers:**\n• Payment processors\n• Shipping and logistics partners\n• Cloud storage providers\n• Analytics services\n\n**Business Partners:**\n• Merchant partners (for order fulfillment)\n• Marketing partners (with consent)\n• Technology integrators\n\n**Legal Requirements:**\n• When required by law\n• To protect our rights\n• In case of business transfers\n• For fraud prevention\n\n**We never sell your personal information to third parties.**",
      "icon": Icons.share,
      "color": warningColor,
    },
    {
      "title": "4. Data Security",
      "content": "We implement comprehensive security measures:\n\n**Technical Safeguards:**\n• SSL/TLS encryption for data transmission\n• AES-256 encryption for stored data\n• Secure data centers and servers\n• Regular security audits and testing\n\n**Access Controls:**\n• Multi-factor authentication\n• Role-based access restrictions\n• Employee background checks\n• Regular security training\n\n**Monitoring:**\n• 24/7 security monitoring\n• Incident response procedures\n• Vulnerability assessments\n• Compliance certifications",
      "icon": Icons.security,
      "color": successColor,
    },
    {
      "title": "5. Your Privacy Rights",
      "content": "You have the following rights regarding your personal data:\n\n**Access & Control:**\n• View your personal information\n• Update or correct data\n• Delete your account\n • Export your data\n\n**Communication Preferences:**\n• Opt-out of marketing emails\n• Manage notification settings\n• Control personalized advertising\n• Unsubscribe from newsletters\n\n**Regional Rights:**\n• GDPR rights (EU residents)\n• CCPA rights (California residents)\n• Other applicable privacy laws",
      "icon": Icons.account_circle,
      "color": primaryColor,
    },
    {
      "title": "6. Cookies and Tracking",
      "content": "We use cookies and similar technologies:\n\n**Essential Cookies:**\n• Required for app functionality\n• Remember login status\n• Maintain shopping cart\n• Ensure security\n\n**Analytics Cookies:**\n• Understand user behavior\n• Improve app performance\n• Track feature usage\n• Measure marketing effectiveness\n\n**Marketing Cookies:**\n• Personalize advertisements\n• Track campaign performance\n• Retarget website visitors\n• Social media integration\n\n**You can manage cookie preferences in your browser settings.**",
      "icon": Icons.cookie,
      "color": warningColor,
    },
    {
      "title": "7. Data Retention",
      "content": "We retain your information for different periods:\n\n**Account Information:**\n• While your account is active\n• Up to 3 years after closure\n• As required by law\n\n**Transaction Data:**\n• 7 years for tax purposes\n• As required by payment processors\n• For fraud prevention\n\n**Marketing Data:**\n• Until you opt-out\n• Maximum of 5 years\n• Aggregated data may be kept longer\n\n**Log Data:**\n• 12 months for security logs\n• 6 months for analytics data\n• Immediately for sensitive logs",
      "icon": Icons.schedule,
      "color": infoColor,
    },
    {
      "title": "8. International Transfers",
      "content": "Your information may be transferred to and processed in countries other than your own:\n\n**Safeguards:**\n• Standard Contractual Clauses\n• Adequacy decisions\n• Privacy Shield (where applicable)\n• Binding Corporate Rules\n\n**Locations:**\n• United States (primary)\n• European Union\n• Canada\n• Other countries with adequate protection\n\n**We ensure appropriate safeguards are in place for all international transfers.**",
      "icon": Icons.public,
      "color": primaryColor,
    },
    {
      "title": "9. Children's Privacy",
      "content": "We are committed to protecting children's privacy:\n\n• Our service is not intended for children under 13\n• We do not knowingly collect information from children\n• Parents can request deletion of child's information\n• We comply with COPPA requirements\n\n**If you believe a child has provided information:**\n• Contact us immediately\n• We will investigate and take action\n• Information will be deleted promptly\n• Account access will be restricted",
      "icon": Icons.child_care,
      "color": dangerColor,
    },
    {
      "title": "10. Changes to Privacy Policy",
      "content": "We may update this Privacy Policy periodically:\n\n• Changes will be posted on this page\n• You'll be notified of significant changes\n• Continued use constitutes acceptance\n• Previous versions available upon request\n\n**Types of changes:**\n• Legal or regulatory requirements\n• New features or services\n• Business practice updates\n• Clarity improvements\n\n**We encourage you to review this policy regularly.**",
      "icon": Icons.update,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spSm),
            child: GestureDetector(
              onTap: () {
                _showPrivacySettings();
              },
              child: Icon(
                Icons.tune,
                color: primaryColor,
              ),
            ),
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
                          Icons.privacy_tip,
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
                              "Privacy Policy",
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
                    "ShopEase respects your privacy and is committed to protecting your personal information. This policy explains how we collect, use, and safeguard your data.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Privacy Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: successColor.withAlpha(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.verified_user,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Privacy at a Glance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "We never sell your personal information",
                          style: TextStyle(fontSize: 12, color: successColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "You control your data and privacy settings",
                          style: TextStyle(fontSize: 12, color: successColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "All data is encrypted and securely stored",
                          style: TextStyle(fontSize: 12, color: successColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Privacy Sections
            ...privacySections.map((section) {
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
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (section["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            section["icon"] as IconData,
                            color: section["color"] as Color,
                            size: 20,
                          ),
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

            // Data Request Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Manage Your Data",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "You have full control over your personal information. Use the options below to manage your data.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spXs,
                    children: [
                      _buildActionChip("Download My Data", Icons.download),
                      _buildActionChip("Delete My Account", Icons.delete),
                      _buildActionChip("Privacy Settings", Icons.settings),
                      _buildActionChip("Contact Privacy Team", Icons.support),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Contact Information
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
                    "Questions About Your Privacy?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Contact our Privacy Team:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.email, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "privacy@shopease.com",
                        style: TextStyle(fontSize: 14, color: primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.phone, color: primaryColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "+1 (800) 123-PRIVACY",
                        style: TextStyle(fontSize: 14, color: primaryColor),
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
                    "ShopEase Privacy Policy",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Version 3.0 • Effective December 13, 2024",
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

  Widget _buildActionChip(String label, IconData icon) {
    return GestureDetector(
      onTap: () {
        ss("$label feature coming soon!");
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXs,
        ),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: primaryColor.withAlpha(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: primaryColor,
            ),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPrivacySettings() {
    showDialog(
      context: context,
      builder: (context) {
        bool marketingEmails = true;
        bool pushNotifications = true;
        bool personalizedAds = false;
        bool analytics = true;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Privacy Settings"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: Text("Marketing Emails"),
                    subtitle: Text("Receive promotional offers"),
                    value: marketingEmails,
                    onChanged: (value) {
                      setDialogState(() => marketingEmails = value);
                    },
                  ),
                  SwitchListTile(
                    title: Text("Push Notifications"),
                    subtitle: Text("Order updates and alerts"),
                    value: pushNotifications,
                    onChanged: (value) {
                      setDialogState(() => pushNotifications = value);
                    },
                  ),
                  SwitchListTile(
                    title: Text("Personalized Ads"),
                    subtitle: Text("Tailored advertising"),
                    value: personalizedAds,
                    onChanged: (value) {
                      setDialogState(() => personalizedAds = value);
                    },
                  ),
                  SwitchListTile(
                    title: Text("Usage Analytics"),
                    subtitle: Text("Help improve our app"),
                    value: analytics,
                    onChanged: (value) {
                      setDialogState(() => analytics = value);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                QButton(
                  label: "Save Settings",
                  size: bs.sm,
                  onPressed: () {
                    Navigator.pop(context);
                    ss("Privacy settings updated!");
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
