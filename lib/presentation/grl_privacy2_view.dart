import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPrivacy2View extends StatefulWidget {
  @override
  State<GrlPrivacy2View> createState() => _GrlPrivacy2ViewState();
}

class _GrlPrivacy2ViewState extends State<GrlPrivacy2View> {
  int selectedSection = 0;

  List<Map<String, dynamic>> privacySections = [
    {
      "title": "Data Collection",
      "icon": Icons.data_usage,
      "content": [
        {
          "heading": "Information We Collect",
          "text": "We collect information you provide directly to us, such as when you create an account, make a purchase, or contact us for support. This includes personal information like your name, email address, phone number, and payment information."
        },
        {
          "heading": "Automatic Data Collection",
          "text": "We automatically collect certain information about your device and how you interact with our services, including IP address, browser type, operating system, and usage patterns."
        },
        {
          "heading": "Third-Party Sources",
          "text": "We may receive information about you from third-party sources, such as social media platforms, analytics providers, and advertising networks, subject to your privacy settings on those platforms."
        }
      ]
    },
    {
      "title": "Data Usage",
      "icon": Icons.settings,
      "content": [
        {
          "heading": "Service Provision",
          "text": "We use your information to provide, maintain, and improve our services, process transactions, and communicate with you about your account and our services."
        },
        {
          "heading": "Personalization",
          "text": "We use your data to personalize your experience, including customizing content and recommendations based on your preferences and usage patterns."
        },
        {
          "heading": "Analytics and Research",
          "text": "We analyze usage data to understand how our services are used, identify trends, and improve our offerings. This helps us enhance user experience and develop new features."
        }
      ]
    },
    {
      "title": "Data Sharing",
      "icon": Icons.share,
      "content": [
        {
          "heading": "Service Providers",
          "text": "We may share your information with trusted third-party service providers who assist us in operating our services, such as payment processors, hosting providers, and customer support tools."
        },
        {
          "heading": "Legal Requirements",
          "text": "We may disclose your information if required by law, court order, or government request, or if we believe disclosure is necessary to protect our rights or the safety of others."
        },
        {
          "heading": "Business Transfers",
          "text": "In the event of a merger, acquisition, or sale of assets, your information may be transferred to the acquiring entity as part of the business transaction."
        }
      ]
    },
    {
      "title": "Your Rights",
      "icon": Icons.security,
      "content": [
        {
          "heading": "Access and Portability",
          "text": "You have the right to access your personal data and request a copy of the information we have about you in a portable format."
        },
        {
          "heading": "Correction and Deletion",
          "text": "You can request correction of inaccurate information or deletion of your personal data, subject to certain legal and business requirements."
        },
        {
          "heading": "Opt-Out Rights",
          "text": "You can opt out of certain data processing activities, such as marketing communications and personalized advertising, through your account settings or by contacting us."
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.privacy_tip,
                  size: 48,
                  color: primaryColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "Your Privacy Matters",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Understanding how we protect and use your data",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Tab Selection
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spSm),
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
                    margin: EdgeInsets.symmetric(horizontal: spXs, vertical: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                      ),
                      boxShadow: isSelected ? [shadowSm] : [],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          section["icon"] as IconData,
                          color: isSelected ? Colors.white : disabledBoldColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${section["title"]}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Content Section
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Section Title
                  Row(
                    children: [
                      Icon(
                        privacySections[selectedSection]["icon"] as IconData,
                        color: primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${privacySections[selectedSection]["title"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  // Content Items
                  ...(privacySections[selectedSection]["content"] as List<Map<String, dynamic>>)
                      .map((item) => Container(
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
                                  "${item["heading"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${item["text"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          )),

                  // Additional Information
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Important Notice",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "This privacy policy was last updated on January 1, 2024. We may update this policy periodically to reflect changes in our practices or legal requirements. We will notify you of any material changes.",
                          style: TextStyle(
                            color: infoColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Contact Information
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.contact_support,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Questions or Concerns?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "If you have any questions about this privacy policy or our data practices, please contact our privacy team at privacy@company.com or call +1-800-PRIVACY.",
                          style: TextStyle(
                            color: successColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Download Policy",
                          size: bs.sm,
                          icon: Icons.download,
                          onPressed: () {
                            ss("Privacy policy download started");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.sm,
                          icon: Icons.support_agent,
                          onPressed: () {
                            si("Redirecting to support center");
                          },
                        ),
                      ),
                    ],
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
