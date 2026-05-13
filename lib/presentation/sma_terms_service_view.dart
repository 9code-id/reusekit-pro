import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaTermsServiceView extends StatefulWidget {
  const SmaTermsServiceView({super.key});

  @override
  State<SmaTermsServiceView> createState() => _SmaTermsServiceViewState();
}

class _SmaTermsServiceViewState extends State<SmaTermsServiceView> {
  String searchQuery = "";
  int selectedSection = 0;

  List<Map<String, dynamic>> sections = [
    {
      "title": "1. Acceptance of Terms",
      "content": """By accessing and using SocialConnect ("the Service"), you accept and agree to be bound by the terms and provision of this agreement.

If you do not agree to abide by the above, please do not use this service.

These Terms of Service may be updated from time to time. We will notify you of any significant changes through the app or via email. Your continued use of the Service after such changes constitutes your acceptance of the new terms.""",
    },
    {
      "title": "2. Use License",
      "content": """Permission is granted to temporarily access and use SocialConnect for personal, non-commercial transitory viewing only.

This is the grant of a license, not a transfer of title, and under this license you may not:
• Modify or copy the materials
• Use the materials for any commercial purpose or for any public display
• Attempt to reverse engineer any software contained on the Service
• Remove any copyright or other proprietary notations from the materials

This license shall automatically terminate if you violate any of these restrictions and may be terminated by us at any time. Upon terminating your viewing of these materials or upon the termination of this license, you must destroy any downloaded materials in your possession whether in electronic or printed format.""",
    },
    {
      "title": "3. User Accounts",
      "content": """To access certain features of the Service, you must create an account. You are responsible for:
• Maintaining the confidentiality of your account credentials
• All activities that occur under your account
• Immediately notifying us of any unauthorized use of your account

You must provide accurate, current, and complete information during registration and keep your account information updated.

We reserve the right to suspend or terminate accounts that violate our terms or engage in prohibited activities.""",
    },
    {
      "title": "4. Content and Conduct",
      "content": """You are solely responsible for any content you post, upload, or share through the Service. By posting content, you grant us a non-exclusive, worldwide, royalty-free license to use, display, and distribute your content in connection with the Service.

You agree not to post content that:
• Is illegal, harmful, threatening, abusive, harassing, tortious, defamatory, vulgar, obscene, libelous, invasive of another's privacy, hateful, or racially or ethnically objectionable
• Infringes any patent, trademark, trade secret, copyright, or other proprietary rights
• Contains software viruses or any other computer code designed to interrupt, destroy, or limit functionality
• Promotes illegal activities or conduct

We reserve the right to remove any content that violates these terms or is otherwise objectionable.""",
    },
    {
      "title": "5. Privacy Policy",
      "content": """Your privacy is important to us. Our Privacy Policy explains how we collect, use, and protect your information when you use our Service.

Key points include:
• We collect minimal data necessary to provide the Service
• We use industry-standard encryption to protect your data
• We never sell your personal information to third parties
• You can download or delete your data at any time
• We comply with GDPR, CCPA, and other privacy regulations

By using our Service, you consent to the collection and use of information in accordance with our Privacy Policy.""",
    },
    {
      "title": "6. Disclaimers",
      "content": """The information on this Service is provided on an 'as is' basis. To the fullest extent permitted by law, this Company:
• Excludes all representations and warranties relating to this Service and its contents
• Excludes all liability for damages arising out of or in connection with your use of this Service

The Service is provided without warranties of any kind, whether express or implied, including but not limited to implied warranties of merchantability, fitness for a particular purpose, or non-infringement.

We do not warrant that the Service will be uninterrupted, secure, or error-free.""",
    },
    {
      "title": "7. Limitations",
      "content": """In no event shall SocialConnect or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the Service, even if SocialConnect or an authorized representative has been notified orally or in writing of the possibility of such damage.

Some jurisdictions do not allow limitations on implied warranties or the exclusion or limitation of certain damages, so these limitations may not apply to you.""",
    },
    {
      "title": "8. Accuracy of Materials",
      "content": """The materials appearing on SocialConnect could include technical, typographical, or photographic errors. We do not warrant that any of the materials on the Service are accurate, complete, or current.

We may make changes to the materials contained on the Service at any time without notice. However, we do not make any commitment to update the materials.

Users are responsible for verifying the accuracy of any information before relying on it.""",
    },
    {
      "title": "9. Modifications",
      "content": """We may revise these Terms of Service at any time without notice. By using this Service, you are agreeing to be bound by the then-current version of these terms.

Material changes to these terms will be communicated through:
• In-app notifications
• Email notifications to registered users
• Website announcements

Your continued use of the Service after changes are posted constitutes acceptance of the revised terms.""",
    },
    {
      "title": "10. Governing Law",
      "content": """These terms and conditions are governed by and construed in accordance with the laws of the State of California, United States, and you irrevocably submit to the exclusive jurisdiction of the courts in that state or location.

Any disputes arising under these terms shall be resolved through binding arbitration in accordance with the rules of the American Arbitration Association.

If any provision of these terms is found to be invalid or unenforceable, the remaining provisions will remain in full force and effect.""",
    },
    {
      "title": "11. Termination",
      "content": """We may terminate or suspend your account and access to the Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.

Upon termination:
• Your right to use the Service will cease immediately
• You may request a copy of your data within 30 days
• We may delete your account and associated data after 90 days

You may also terminate your account at any time through your account settings.""",
    },
    {
      "title": "12. Contact Information",
      "content": """If you have any questions about these Terms of Service, please contact us at:

Email: legal@socialconnect.com
Address: 123 Innovation Drive, Tech Valley, CA 94000
Phone: +1 (555) 123-4567

For technical support, please use: support@socialconnect.com

We aim to respond to all legal inquiries within 5 business days.""",
    },
  ];

  List<Map<String, dynamic>> get filteredSections {
    if (searchQuery.isEmpty) return sections;
    return sections.where((section) {
      return "${section["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${section["content"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of Service"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(Icons.gavel, color: primaryColor, size: 32),
                  Text(
                    "Terms of Service",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Last Updated: December 15, 2024",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Please read these terms carefully before using our service. By using SocialConnect, you agree to be bound by these terms.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Search
            QTextField(
              label: "Search terms",
              value: searchQuery,
              hint: "Search for specific terms or sections...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Quick Navigation
            if (searchQuery.isEmpty)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Text(
                        "Quick Navigation",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...sections.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> section = entry.value;
                      bool isSelected = selectedSection == index;
                      
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            selectedSection = index;
                            setState(() {});
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(10) : Colors.transparent,
                              border: Border(
                                left: BorderSide(
                                  color: isSelected ? primaryColor : Colors.transparent,
                                  width: 4,
                                ),
                                top: BorderSide(
                                  color: disabledOutlineBorderColor,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${section["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                      color: isSelected ? primaryColor : Colors.black,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

            // Content Sections
            if (searchQuery.isEmpty && selectedSection < sections.length)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "${sections[selectedSection]["title"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${sections[selectedSection]["content"]}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          height: 1.6,
                        ),
                      ),
                      
                      // Navigation buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (selectedSection > 0)
                            QButton(
                              label: "Previous",
                              icon: Icons.arrow_back,
                              size: bs.sm,
                              onPressed: () {
                                selectedSection--;
                                setState(() {});
                              },
                            )
                          else
                            SizedBox(),
                          
                          if (selectedSection < sections.length - 1)
                            QButton(
                              label: "Next",
                              icon: Icons.arrow_forward,
                              size: bs.sm,
                              onPressed: () {
                                selectedSection++;
                                setState(() {});
                              },
                            )
                          else
                            SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            else if (searchQuery.isNotEmpty)
              // Search Results
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "${filteredSections.length} ${filteredSections.length == 1 ? 'section' : 'sections'} found",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  if (filteredSections.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXl),
                      child: Column(
                        spacing: spMd,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: disabledColor,
                          ),
                          Text(
                            "No sections found",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search terms",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredSections.map((section) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Text(
                                "${section["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${section["content"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                ],
              ),

            // Important Notice
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(40)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Important Notice",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "These terms may change from time to time. We'll notify you of significant changes via email or in-app notification. Continued use of the service constitutes acceptance of updated terms.",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Contact & Help
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    Text(
                      "Questions about these terms?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "If you have any questions about these Terms of Service, please don't hesitate to contact our legal team.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Contact Legal",
                            icon: Icons.email,
                            size: bs.sm,
                            onPressed: () {
                              ss("Opening legal contact form...");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Help Center",
                            icon: Icons.help,
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(HelpCenterView());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Text(
                "© 2024 SocialConnect. All rights reserved. These terms are effective as of December 15, 2024.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
