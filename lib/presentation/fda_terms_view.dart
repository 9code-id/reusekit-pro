import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaTermsView extends StatefulWidget {
  const FdaTermsView({super.key});

  @override
  State<FdaTermsView> createState() => _FdaTermsViewState();
}

class _FdaTermsViewState extends State<FdaTermsView> {
  bool loading = false;
  String lastUpdated = "March 15, 2024";

  List<Map<String, dynamic>> sections = [
    {
      "title": "1. Acceptance of Terms",
      "content": "By accessing and using FoodApp, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.",
      "isExpanded": false,
    },
    {
      "title": "2. Service Description",
      "content": "FoodApp is a food delivery platform that connects users with local restaurants. We facilitate ordering and delivery services but do not prepare or handle food directly. Restaurant partners are responsible for food quality, preparation, and initial handling.",
      "isExpanded": false,
    },
    {
      "title": "3. User Account and Registration",
      "content": "To use our services, you must:\n\n• Be at least 18 years old or have parental consent\n• Provide accurate and complete registration information\n• Maintain the security of your account credentials\n• Notify us immediately of any unauthorized use\n• Accept responsibility for all activities under your account",
      "isExpanded": false,
    },
    {
      "title": "4. Ordering and Payment",
      "content": "When placing an order through FoodApp:\n\n• All orders are subject to availability and restaurant confirmation\n• Prices may vary between restaurants and can change without notice\n• You authorize us to charge your selected payment method\n• We accept credit cards, debit cards, and digital payment methods\n• Delivery fees, taxes, and tips are clearly displayed before checkout\n• Orders cannot be cancelled once preparation has begun",
      "isExpanded": false,
    },
    {
      "title": "5. Delivery Terms",
      "content": "Delivery services are subject to:\n\n• Availability in your area during operating hours\n• Weather conditions and traffic circumstances\n• Restaurant preparation times and delivery partner availability\n• Estimated delivery times are approximate and not guaranteed\n• You must be available to receive your order at the delivery address\n• Additional identification may be required for certain orders",
      "isExpanded": false,
    },
    {
      "title": "6. User Conduct and Prohibited Activities",
      "content": "You agree not to:\n\n• Use the service for any unlawful purpose\n• Impersonate any person or entity\n• Upload harmful or malicious content\n• Interfere with the proper functioning of the service\n• Attempt to gain unauthorized access to our systems\n• Harass, abuse, or threaten other users or delivery partners\n• Place fraudulent orders or dispute legitimate charges",
      "isExpanded": false,
    },
    {
      "title": "7. Intellectual Property",
      "content": "All content on FoodApp, including:\n\n• Text, graphics, logos, and images\n• Software and underlying technology\n• Trademarks and service marks\n• User interface and design elements\n\nAre protected by intellectual property laws and remain the property of FoodApp or our licensors. You may not copy, modify, or distribute any content without express written permission.",
      "isExpanded": false,
    },
    {
      "title": "8. Privacy and Data Protection",
      "content": "Your privacy is important to us. Our Privacy Policy explains:\n\n• What information we collect and how we use it\n• How we protect your personal data\n• Your rights regarding your information\n• How we share data with restaurant and delivery partners\n• Cookie usage and tracking technologies\n\nBy using our service, you consent to our data practices as described in our Privacy Policy.",
      "isExpanded": false,
    },
    {
      "title": "9. Refunds and Cancellations",
      "content": "Refund eligibility depends on various factors:\n\n• Orders can be cancelled within 2 minutes of placement\n• Refunds may be issued for order issues, quality problems, or delivery failures\n• Restaurant cancellations result in automatic full refunds\n• Refund processing typically takes 3-5 business days\n• Credits to your FoodApp account may be issued for service recovery\n• Promotional credits are non-refundable and have expiration dates",
      "isExpanded": false,
    },
    {
      "title": "10. Limitation of Liability",
      "content": "FoodApp's liability is limited as follows:\n\n• We are not responsible for food quality, allergic reactions, or food safety\n• Our maximum liability is limited to the order value\n• We disclaim liability for indirect, incidental, or consequential damages\n• Restaurant partners are solely responsible for food preparation and allergen information\n• Delivery delays due to weather, traffic, or other circumstances beyond our control are not compensable",
      "isExpanded": false,
    },
    {
      "title": "11. Dispute Resolution",
      "content": "For dispute resolution:\n\n• Contact our customer support team first for issue resolution\n• Most disputes can be resolved through our internal process\n• Binding arbitration may be required for unresolved disputes\n• Class action lawsuits are waived except where prohibited by law\n• Local jurisdiction laws apply where arbitration is not enforceable",
      "isExpanded": false,
    },
    {
      "title": "12. Service Modifications and Termination",
      "content": "FoodApp reserves the right to:\n\n• Modify or discontinue services with or without notice\n• Update these terms at any time with notification\n• Suspend or terminate accounts for terms violations\n• Change pricing, fees, or service areas\n• Require updated consent for continued service use",
      "isExpanded": false,
    },
    {
      "title": "13. Contact Information",
      "content": "For questions about these Terms of Service:\n\n• Email: legal@foodapp.com\n• Phone: 1-800-FOOD-APP\n• Mail: FoodApp Legal Department, 123 Main Street, City, State 12345\n• Support: Available 24/7 through the app or website\n\nWe will respond to legal inquiries within 5 business days.",
      "isExpanded": false,
    },
  ];

  void _toggleSection(int index) {
    sections[index]["isExpanded"] = !sections[index]["isExpanded"];
    setState(() {});
  }

  void _contactSupport() {
    // Navigate to contact support
  }

  void _openPrivacyPolicy() {
    // Navigate to privacy policy
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of Service"),
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
                          Icons.description,
                          size: 60,
                          color: primaryColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Terms of Service",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Please read these terms carefully before using our service",
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

                  // Important Notice
                  Container(
                    margin: EdgeInsets.all(spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Important Notice",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "By using FoodApp, you agree to these terms. If you don't agree, please discontinue use of our service.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Terms Sections
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Column(
                      children: sections.map((section) {
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
                    ),
                  ),

                  // Footer Actions
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: successColor,
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Text(
                                  "By continuing to use FoodApp, you acknowledge that you have read, understood, and agree to these terms.",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Privacy Policy",
                                size: bs.md,
                                onPressed: _openPrivacyPolicy,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: QButton(
                                label: "Contact Support",
                                size: bs.md,
                                onPressed: _contactSupport,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "For questions about these terms, contact legal@foodapp.com",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
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
}
