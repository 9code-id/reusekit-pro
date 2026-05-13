import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaSupportView extends StatefulWidget {
  const GeaSupportView({super.key});

  @override
  State<GeaSupportView> createState() => _GeaSupportViewState();
}

class _GeaSupportViewState extends State<GeaSupportView> {
  int currentTab = 0;
  String subject = "";
  String message = "";
  String selectedCategory = "General";
  bool isUrgent = false;

  final List<Map<String, dynamic>> faqCategories = [
    {
      "category": "Account",
      "icon": Icons.person,
      "questions": [
        {
          "question": "How do I reset my password?",
          "answer": "You can reset your password by clicking on 'Forgot Password' on the login screen. Enter your email address and follow the instructions sent to your email."
        },
        {
          "question": "How do I update my profile information?",
          "answer": "Go to Settings > Profile and tap on the information you want to update. Make your changes and tap 'Save' to confirm."
        },
        {
          "question": "How do I delete my account?",
          "answer": "To delete your account, go to Settings > Account > Delete Account. Please note that this action is irreversible."
        }
      ]
    },
    {
      "category": "Billing",
      "icon": Icons.payment,
      "questions": [
        {
          "question": "How do I update my payment method?",
          "answer": "Navigate to Settings > Billing > Payment Methods. Tap 'Add Payment Method' to add a new card or 'Edit' to modify existing ones."
        },
        {
          "question": "When will I be charged?",
          "answer": "You'll be charged on the same date each month as your initial subscription. You'll receive an email notification 3 days before each charge."
        },
        {
          "question": "Can I get a refund?",
          "answer": "Refunds are available within 30 days of purchase for annual subscriptions and 7 days for monthly subscriptions. Contact support for assistance."
        }
      ]
    },
    {
      "category": "Technical",
      "icon": Icons.bug_report,
      "questions": [
        {
          "question": "The app is running slowly. What can I do?",
          "answer": "Try closing other apps, restarting the app, or restarting your device. If the problem persists, try clearing the app cache or reinstalling."
        },
        {
          "question": "I'm getting error messages. What should I do?",
          "answer": "Screenshot the error message and contact support with details about what you were doing when the error occurred."
        },
        {
          "question": "The app crashes frequently. How can I fix this?",
          "answer": "Ensure you have the latest version of the app. If crashes continue, try reinstalling the app or contact support with your device information."
        }
      ]
    }
  ];

  final List<Map<String, dynamic>> contactMethods = [
    {
      "title": "Live Chat",
      "subtitle": "Get instant help from our support team",
      "icon": Icons.chat,
      "color": Colors.blue,
      "available": "24/7 Available",
      "responseTime": "Usually responds in 2-5 minutes"
    },
    {
      "title": "Email Support",
      "subtitle": "Send us a detailed message",
      "icon": Icons.email,
      "color": Colors.green,
      "available": "24/7 Available",
      "responseTime": "Usually responds within 24 hours"
    },
    {
      "title": "Phone Support",
      "subtitle": "Call us directly for urgent issues",
      "icon": Icons.phone,
      "color": Colors.orange,
      "available": "Mon-Fri 9AM-6PM EST",
      "responseTime": "Immediate assistance"
    },
    {
      "title": "Community Forum",
      "subtitle": "Get help from other users",
      "icon": Icons.forum,
      "color": Colors.purple,
      "available": "Always Available",
      "responseTime": "Community driven"
    }
  ];

  Widget _buildFaqTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Icon(Icons.help, color: Colors.white, size: 32),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Frequently Asked Questions",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Find quick answers to common questions",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          ...faqCategories.map((category) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: ExpansionTile(
                leading: Icon(
                  category["icon"],
                  color: primaryColor,
                  size: 28,
                ),
                title: Text(
                  "${category["category"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                subtitle: Text(
                  "${(category["questions"] as List).length} questions",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                children: (category["questions"] as List).map<Widget>((faq) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${faq["question"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${faq["answer"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contact Support",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Choose the best way to reach us",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          ...contactMethods.map((method) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: (method["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      method["icon"],
                      color: method["color"],
                      size: 28,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${method["title"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${method["subtitle"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${method["available"]}",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${method["responseTime"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: disabledBoldColor,
                    size: 16,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTicketTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Submit Support Ticket",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Describe your issue and we'll get back to you",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spMd,
              children: [
                QDropdownField(
                  label: "Category",
                  items: [
                    {"label": "General", "value": "General"},
                    {"label": "Technical Issue", "value": "Technical"},
                    {"label": "Billing", "value": "Billing"},
                    {"label": "Account", "value": "Account"},
                    {"label": "Feature Request", "value": "Feature"},
                    {"label": "Bug Report", "value": "Bug"},
                  ],
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Subject",
                  value: subject,
                  hint: "Brief description of your issue",
                  onChanged: (value) {
                    subject = value;
                    setState(() {});
                  },
                ),

                QMemoField(
                  label: "Message",
                  value: message,
                  hint: "Please provide detailed information about your issue",
                  onChanged: (value) {
                    message = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Mark as urgent",
                            "value": true,
                            "checked": isUrgent,
                          }
                        ],
                        value: [
                          if (isUrgent)
                            {
                              "label": "Mark as urgent",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          isUrgent = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                if (isUrgent)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Urgent tickets receive priority support and are typically resolved within 4 hours.",
                            style: TextStyle(
                              color: warningColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Submit Ticket",
                    size: bs.md,
                    onPressed: () {
                      if (subject.isNotEmpty && message.isNotEmpty) {
                        ss("Support ticket submitted successfully");
                      } else {
                        se("Please fill in all required fields");
                      }
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Support",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "FAQ", icon: Icon(Icons.help)),
        Tab(text: "Contact", icon: Icon(Icons.contact_support)),
        Tab(text: "Ticket", icon: Icon(Icons.support_agent)),
      ],
      tabChildren: [
        _buildFaqTab(),
        _buildContactTab(),
        _buildTicketTab(),
      ],
    );
  }
}
