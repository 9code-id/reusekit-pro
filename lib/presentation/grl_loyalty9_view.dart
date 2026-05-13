import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLoyalty9View extends StatefulWidget {
  @override
  State<GrlLoyalty9View> createState() => _GrlLoyalty9ViewState();
}

class _GrlLoyalty9ViewState extends State<GrlLoyalty9View> {
  String selectedSubject = "General Inquiry";
  String message = "";
  String email = "";
  String fullName = "";
  
  List<Map<String, dynamic>> faqItems = [
    {
      "question": "How do I earn points?",
      "answer": "You can earn points by making purchases (1 point per \$1), writing reviews (50 points), referring friends (500 points), and completing daily check-ins (5-25 points).",
      "category": "Points",
      "expanded": false,
    },
    {
      "question": "When do my points expire?",
      "answer": "Points expire 2 years from the date they were earned. You'll receive email reminders 60 days and 30 days before expiration.",
      "category": "Points",
      "expanded": false,
    },
    {
      "question": "How do I redeem rewards?",
      "answer": "Go to the Rewards section, browse available rewards, and tap 'Redeem Now' on any reward you can afford with your points balance.",
      "category": "Rewards",
      "expanded": false,
    },
    {
      "question": "Can I transfer points to another account?",
      "answer": "Points cannot be transferred between accounts. However, you can gift certain rewards to friends and family members.",
      "category": "Points",
      "expanded": false,
    },
    {
      "question": "What are the membership tiers?",
      "answer": "We have 5 tiers: Bronze (0-999 pts), Silver (1000-2499 pts), Gold (2500-3999 pts), Platinum (4000-7499 pts), and Diamond (7500+ pts). Each tier unlocks additional benefits.",
      "category": "Membership",
      "expanded": false,
    },
    {
      "question": "How do I update my profile?",
      "answer": "Go to Profile Settings, tap 'Edit Profile' or 'Update Information', make your changes, and save. Some changes may require email verification.",
      "category": "Account",
      "expanded": false,
    },
    {
      "question": "Why didn't I receive points for my purchase?",
      "answer": "Points are usually credited within 24-48 hours. Make sure you're logged in when making purchases and that the merchant participates in our program.",
      "category": "Points",
      "expanded": false,
    },
    {
      "question": "How do I delete my account?",
      "answer": "Go to Profile Settings > Account Actions > Delete Account. Note that this action is permanent and all points will be lost.",
      "category": "Account",
      "expanded": false,
    },
  ];

  List<Map<String, dynamic>> supportChannels = [
    {
      "title": "Live Chat",
      "description": "Get instant help from our support team",
      "icon": Icons.chat,
      "color": Colors.blue,
      "available": true,
      "responseTime": "Usually responds in minutes",
    },
    {
      "title": "Email Support",
      "description": "Send us a detailed message",
      "icon": Icons.email,
      "color": Colors.green,
      "available": true,
      "responseTime": "Usually responds within 24 hours",
    },
    {
      "title": "Phone Support",
      "description": "Call us directly for urgent issues",
      "icon": Icons.phone,
      "color": Colors.orange,
      "available": false,
      "responseTime": "Available Mon-Fri 9AM-5PM",
    },
    {
      "title": "Community Forum",
      "description": "Connect with other members",
      "icon": Icons.forum,
      "color": Colors.purple,
      "available": true,
      "responseTime": "Community moderated",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSupportChannels(),
            SizedBox(height: spLg),
            _buildQuickHelp(),
            SizedBox(height: spLg),
            _buildFAQ(),
            SizedBox(height: spLg),
            _buildContactForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportChannels() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Support",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: supportChannels.map((channel) {
              bool isAvailable = channel["available"] == true;
              
              return GestureDetector(
                onTap: isAvailable ? () {
                  _openSupportChannel(channel["title"]);
                } : null,
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isAvailable ? (channel["color"] as Color).withAlpha(10) : Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isAvailable ? (channel["color"] as Color).withAlpha(50) : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            channel["icon"] as IconData,
                            color: isAvailable ? (channel["color"] as Color) : disabledBoldColor,
                            size: 24,
                          ),
                          Spacer(),
                          if (!isAvailable)
                            Icon(
                              Icons.schedule,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${channel["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isAvailable ? (channel["color"] as Color) : disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${channel["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${channel["responseTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickHelp() {
    List<Map<String, dynamic>> quickHelp = [
      {
        "title": "Track Points",
        "description": "View your points history",
        "icon": Icons.history,
        "action": "points_history",
      },
      {
        "title": "Redeem Rewards",
        "description": "Browse available rewards",
        "icon": Icons.redeem,
        "action": "rewards",
      },
      {
        "title": "Update Profile",
        "description": "Edit your account information",
        "icon": Icons.person,
        "action": "profile",
      },
      {
        "title": "Refer Friends",
        "description": "Earn points by referring",
        "icon": Icons.group_add,
        "action": "referrals",
      },
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Help",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickHelp.map((item) {
              return GestureDetector(
                onTap: () {
                  _handleQuickAction(item["action"]);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: primaryColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item["icon"] as IconData,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${item["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: primaryColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQ() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Frequently Asked Questions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: faqItems.map((faq) {
              bool isExpanded = faq["expanded"] == true;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: isExpanded ? primaryColor.withAlpha(10) : Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isExpanded ? primaryColor.withAlpha(50) : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            faq["expanded"] = !isExpanded;
                          });
                        },
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${faq["category"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${faq["question"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isExpanded ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                              ),
                              Icon(
                                isExpanded ? Icons.expand_less : Icons.expand_more,
                                color: isExpanded ? primaryColor : disabledBoldColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (isExpanded)
                      Container(
                        padding: EdgeInsets.fromLTRB(spMd, 0, spMd, spMd),
                        child: Text(
                          "${faq["answer"]}",
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
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Us",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Can't find what you're looking for? Send us a message and we'll get back to you.",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Full Name",
            value: fullName,
            hint: "Enter your full name",
            onChanged: (value) {
              fullName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Email Address",
            value: email,
            hint: "Enter your email address",
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Subject",
            items: [
              {"label": "General Inquiry", "value": "General Inquiry"},
              {"label": "Points & Rewards", "value": "Points & Rewards"},
              {"label": "Account Issues", "value": "Account Issues"},
              {"label": "Technical Support", "value": "Technical Support"},
              {"label": "Feedback", "value": "Feedback"},
              {"label": "Other", "value": "Other"},
            ],
            value: selectedSubject,
            onChanged: (value, label) {
              selectedSubject = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Message",
            value: message,
            hint: "Describe your issue or question in detail...",
            onChanged: (value) {
              message = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Send Message",
              size: bs.md,
              onPressed: () {
                _sendMessage();
              },
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: infoColor.withAlpha(50),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "We typically respond to messages within 24 hours during business days.",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openSupportChannel(String channel) {
    ss("Opening $channel...");
  }

  void _handleQuickAction(String action) {
    ss("Navigating to $action...");
  }

  void _sendMessage() {
    if (fullName.isEmpty || email.isEmpty || message.isEmpty) {
      se("Please fill in all required fields");
      return;
    }
    
    ss("Message sent successfully! We'll get back to you soon.");
    
    // Clear form
    setState(() {
      fullName = "";
      email = "";
      message = "";
      selectedSubject = "General Inquiry";
    });
  }
}
