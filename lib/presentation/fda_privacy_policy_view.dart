import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaPrivacyPolicyView extends StatefulWidget {
  const FdaPrivacyPolicyView({super.key});

  @override
  State<FdaPrivacyPolicyView> createState() => _FdaPrivacyPolicyViewState();
}

class _FdaPrivacyPolicyViewState extends State<FdaPrivacyPolicyView> {
  bool loading = false;
  String lastUpdated = "March 15, 2024";

  List<Map<String, dynamic>> sections = [
    {
      "title": "1. Information We Collect",
      "content": "We collect several types of information to provide and improve our service:\n\n• Personal Information: Name, email, phone number, delivery address\n• Payment Information: Credit card details, billing address (processed securely)\n• Location Data: GPS location for delivery and nearby restaurant recommendations\n• Usage Data: App interactions, order history, preferences, and search queries\n• Device Information: Device type, operating system, app version, and unique identifiers\n• Communication Records: Customer support interactions and feedback",
      "isExpanded": false,
    },
    {
      "title": "2. How We Use Your Information",
      "content": "Your information helps us provide better service:\n\n• Process and fulfill your food orders\n• Facilitate delivery to your specified address\n• Send order confirmations and delivery updates\n• Provide customer support and resolve issues\n• Personalize recommendations and improve user experience\n• Process payments and prevent fraudulent transactions\n• Send promotional offers and marketing communications (with consent)\n• Analyze usage patterns to improve our platform\n• Comply with legal obligations and enforce our terms",
      "isExpanded": false,
    },
    {
      "title": "3. Information Sharing and Disclosure",
      "content": "We may share your information in these circumstances:\n\n• Restaurant Partners: Order details and delivery address for fulfillment\n• Delivery Partners: Delivery address and contact information\n• Payment Processors: Billing information for transaction processing\n• Service Providers: Third-party vendors who assist with our operations\n• Legal Requirements: When required by law or to protect our rights\n• Business Transfers: In case of merger, acquisition, or sale of assets\n• With Consent: Any other sharing with your explicit permission\n\nWe never sell your personal information to third parties for marketing purposes.",
      "isExpanded": false,
    },
    {
      "title": "4. Data Security and Protection",
      "content": "We implement robust security measures:\n\n• Encryption of sensitive data in transit and at rest\n• Secure payment processing with PCI DSS compliance\n• Regular security audits and vulnerability assessments\n• Access controls limiting employee access to personal data\n• Secure data centers with physical and digital protections\n• Multi-factor authentication for administrative accounts\n• Regular security training for all employees\n• Incident response procedures for potential breaches\n\nDespite our efforts, no system is 100% secure. We encourage strong passwords and account security.",
      "isExpanded": false,
    },
    {
      "title": "5. Your Privacy Rights and Choices",
      "content": "You have several rights regarding your personal information:\n\n• Access: Request a copy of the personal data we hold about you\n• Correction: Update or correct inaccurate personal information\n• Deletion: Request deletion of your personal data (subject to legal requirements)\n• Portability: Receive your data in a machine-readable format\n• Restriction: Limit how we process your personal information\n• Objection: Object to certain processing activities\n• Withdraw Consent: Opt-out of marketing communications\n• Account Control: Manage privacy settings within the app\n\nTo exercise these rights, contact us through the app or email privacy@foodapp.com.",
      "isExpanded": false,
    },
    {
      "title": "6. Cookies and Tracking Technologies",
      "content": "We use various technologies to enhance your experience:\n\n• Essential Cookies: Required for basic app functionality\n• Analytics Cookies: Help us understand how you use our service\n• Advertising Cookies: Enable personalized promotional content\n• Social Media Plugins: Allow sharing and social media integration\n• Location Services: Provide location-based features and delivery\n• Push Notifications: Send order updates and promotional messages\n\nYou can manage cookie preferences in your device settings or through our privacy controls.",
      "isExpanded": false,
    },
    {
      "title": "7. Data Retention and Deletion",
      "content": "We retain your information for different periods:\n\n• Account Information: Until you request deletion or close your account\n• Order History: 7 years for financial and legal compliance\n• Communication Records: 3 years for customer service improvements\n• Marketing Data: Until you opt-out or withdraw consent\n• Location Data: 1 year unless you request earlier deletion\n• Technical Logs: 90 days for security and performance monitoring\n\nWe automatically delete data when retention periods expire, unless required by law to retain longer.",
      "isExpanded": false,
    },
    {
      "title": "8. Children's Privacy",
      "content": "FoodApp is not intended for children under 13:\n\n• We do not knowingly collect personal information from children under 13\n• Parents can contact us to review, update, or delete their child's information\n• Users between 13-18 need parental consent to use our service\n• We encourage parents to monitor their children's online activities\n• Educational institutions must have proper authorization to order for minors\n\nIf we discover we have collected information from a child under 13, we will delete it immediately.",
      "isExpanded": false,
    },
    {
      "title": "9. International Data Transfers",
      "content": "As a global service, we may transfer data internationally:\n\n• Data may be processed in countries where we operate\n• We ensure adequate protection through approved transfer mechanisms\n• Standard contractual clauses protect data transferred outside your region\n• We comply with local data protection laws in each jurisdiction\n• You can contact us for information about specific transfer safeguards\n\nYour data is always protected according to this privacy policy regardless of location.",
      "isExpanded": false,
    },
    {
      "title": "10. Updates to This Privacy Policy",
      "content": "We may update this privacy policy periodically:\n\n• Material changes will be communicated through the app or email\n• You'll be notified at least 30 days before significant changes take effect\n• Continued use of our service indicates acceptance of updates\n• Previous versions are available upon request\n• We maintain a change log documenting policy updates\n\nWe encourage you to review this policy regularly to stay informed about how we protect your privacy.",
      "isExpanded": false,
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Manage Privacy Settings",
      "description": "Control your privacy preferences",
      "icon": Icons.privacy_tip,
      "color": primaryColor,
    },
    {
      "title": "Download My Data",
      "description": "Get a copy of your personal data",
      "icon": Icons.download,
      "color": infoColor,
    },
    {
      "title": "Delete My Account",
      "description": "Permanently delete your account",
      "icon": Icons.delete_forever,
      "color": dangerColor,
    },
    {
      "title": "Contact Privacy Team",
      "description": "Questions about privacy practices",
      "icon": Icons.support_agent,
      "color": successColor,
    },
  ];

  void _toggleSection(int index) {
    sections[index]["isExpanded"] = !sections[index]["isExpanded"];
    setState(() {});
  }

  void _managePrivacySettings() {
    // Navigate to privacy settings
  }

  void _downloadData() {
    // Initiate data download
  }

  void _deleteAccount() async {
    bool confirmed = await confirm("Are you sure you want to permanently delete your account? This action cannot be undone.");
    if (confirmed) {
      // Proceed with account deletion
      ss("Account deletion request submitted. You will receive confirmation within 24 hours.");
    }
  }

  void _contactPrivacyTeam() {
    // Navigate to privacy contact
  }

  void _contactSupport() {
    // Navigate to general support
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        actions: [
          IconButton(
            icon: Icon(Icons.support_agent),
            onPressed: _contactSupport,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.privacy_tip,
                          size: 60,
                          color: primaryColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Your privacy is important to us. Learn how we collect, use, and protect your information.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Last updated: $lastUpdated",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quick Actions
                  Container(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quick Actions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 200,
                          children: quickActions.map((action) {
                            return GestureDetector(
                              onTap: () {
                                if (action["title"] == "Manage Privacy Settings") _managePrivacySettings();
                                if (action["title"] == "Download My Data") _downloadData();
                                if (action["title"] == "Delete My Account") _deleteAccount();
                                if (action["title"] == "Contact Privacy Team") _contactPrivacyTeam();
                              },
                              child: Container(
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusMd),
                                  boxShadow: [shadowSm],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: (action["color"] as Color).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Icon(
                                        action["icon"] as IconData,
                                        color: action["color"] as Color,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: spMd),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${action["title"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: spXs),
                                          Text(
                                            "${action["description"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Privacy Sections
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Privacy Policy Details",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spMd),
                        ...sections.map((section) {
                          int index = sections.indexOf(section);
                          return Container(
                            margin: EdgeInsets.only(bottom: spMd),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: Column(
                              children: [
                                // Section Header
                                GestureDetector(
                                  onTap: () => _toggleSection(index),
                                  child: Container(
                                    padding: EdgeInsets.all(spMd),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${section["title"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          section["isExpanded"] ? Icons.expand_less : Icons.expand_more,
                                          color: primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Section Content
                                if (section["isExpanded"]) ...[
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: disabledOutlineBorderColor,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(spMd),
                                    child: Text(
                                      "${section["content"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                        height: 1.6,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  // Contact Information
                  Container(
                    margin: EdgeInsets.all(spMd),
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.contact_support,
                          size: 40,
                          color: infoColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Questions About Privacy?",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Our privacy team is here to help with any questions or concerns about how we handle your personal information.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.email, size: 16, color: infoColor),
                                SizedBox(width: spXs),
                                Text(
                                  "privacy@foodapp.com",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone, size: 16, color: infoColor),
                                SizedBox(width: spXs),
                                Text(
                                  "1-800-PRIVACY",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Contact Privacy Team",
                          size: bs.md,
                          onPressed: _contactPrivacyTeam,
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
