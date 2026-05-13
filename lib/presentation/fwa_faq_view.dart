import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaFaqView extends StatefulWidget {
  const FwaFaqView({super.key});

  @override
  State<FwaFaqView> createState() => _FwaFaqViewState();
}

class _FwaFaqViewState extends State<FwaFaqView> {
  String searchQuery = "";
  String selectedCategory = "all";
  Set<String> expandedFaqs = {};

  List<Map<String, dynamic>> faqCategories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Getting Started", "value": "getting_started"},
    {"label": "Account & Profile", "value": "account"},
    {"label": "Features & Functions", "value": "features"},
    {"label": "Billing & Payments", "value": "billing"},
    {"label": "Technical Issues", "value": "technical"},
    {"label": "Privacy & Security", "value": "privacy"}
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "id": "1",
      "category": "getting_started",
      "question": "How do I create my first project?",
      "answer": "To create your first project, follow these steps:\n\n1. Log into your account\n2. Click on 'New Project' button\n3. Choose a project template or start from scratch\n4. Fill in the project details\n5. Click 'Create Project'\n\nYour project will be created and you can start working immediately.",
      "tags": ["project", "create", "new", "start"],
      "helpful": 95,
      "views": 2580
    },
    {
      "id": "2",
      "category": "account",
      "question": "How can I change my password?",
      "answer": "To change your password:\n\n1. Go to Settings > Account\n2. Click on 'Change Password'\n3. Enter your current password\n4. Enter your new password\n5. Confirm your new password\n6. Click 'Update Password'\n\nFor security, you'll be logged out of all devices and need to log in again.",
      "tags": ["password", "security", "account", "change"],
      "helpful": 92,
      "views": 1840
    },
    {
      "id": "3",
      "category": "features",
      "question": "What are the premium features?",
      "answer": "Premium features include:\n\n• Advanced analytics and reporting\n• Priority customer support\n• Unlimited projects and storage\n• Team collaboration tools\n• Advanced export options\n• Custom branding\n• API access\n\nUpgrade to premium to unlock all these features.",
      "tags": ["premium", "features", "upgrade", "benefits"],
      "helpful": 88,
      "views": 3200
    },
    {
      "id": "4",
      "category": "billing",
      "question": "How do I cancel my subscription?",
      "answer": "To cancel your subscription:\n\n1. Go to Settings > Billing\n2. Click on 'Manage Subscription'\n3. Select 'Cancel Subscription'\n4. Choose your cancellation reason\n5. Confirm cancellation\n\nYour subscription will remain active until the end of your current billing period.",
      "tags": ["cancel", "subscription", "billing", "refund"],
      "helpful": 85,
      "views": 1650
    },
    {
      "id": "5",
      "category": "technical",
      "question": "Why is the app running slowly?",
      "answer": "If the app is running slowly, try these solutions:\n\n1. Check your internet connection\n2. Clear browser cache and cookies\n3. Close other browser tabs\n4. Restart your browser\n5. Update to the latest browser version\n6. Disable browser extensions\n\nIf the problem persists, contact our support team.",
      "tags": ["slow", "performance", "troubleshooting", "speed"],
      "helpful": 78,
      "views": 980
    },
    {
      "id": "6",
      "category": "privacy",
      "question": "How is my data protected?",
      "answer": "We take data protection seriously:\n\n• All data is encrypted in transit and at rest\n• We use industry-standard security protocols\n• Regular security audits and penetration testing\n• SOC 2 Type II compliance\n• GDPR and CCPA compliant\n• No data sharing with third parties\n• 99.9% uptime guarantee\n\nYour privacy and security are our top priorities.",
      "tags": ["privacy", "security", "data", "protection", "encryption"],
      "helpful": 97,
      "views": 2100
    },
    {
      "id": "7",
      "category": "features",
      "question": "How do I collaborate with team members?",
      "answer": "Team collaboration features:\n\n1. Invite team members via email\n2. Set different permission levels\n3. Real-time collaborative editing\n4. Comment and review system\n5. Version history and rollback\n6. Activity timeline\n\nUpgrade to a team plan to access these collaboration features.",
      "tags": ["team", "collaboration", "sharing", "permissions"],
      "helpful": 89,
      "views": 1450
    },
    {
      "id": "8",
      "category": "technical",
      "question": "What browsers are supported?",
      "answer": "Supported browsers:\n\n• Chrome 90+ (Recommended)\n• Firefox 88+\n• Safari 14+\n• Edge 90+\n• Opera 76+\n\nFor the best experience, we recommend using the latest version of Chrome. Internet Explorer is not supported.",
      "tags": ["browser", "compatibility", "support", "requirements"],
      "helpful": 82,
      "views": 750
    }
  ];

  List<Map<String, dynamic>> get filteredFaqs {
    return faqs.where((faq) {
      bool matchesCategory = selectedCategory == "all" || 
                           faq["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty ||
                         faq["question"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                         faq["answer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                         (faq["tags"] as List).any((tag) => 
                           tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _toggleFaq(String faqId) {
    if (expandedFaqs.contains(faqId)) {
      expandedFaqs.remove(faqId);
    } else {
      expandedFaqs.add(faqId);
    }
    setState(() {});
  }

  void _markAsHelpful(Map<String, dynamic> faq) {
    ss("Thanks for your feedback!");
    // In real app, this would send feedback to server
  }

  Icon _getCategoryIcon(String category) {
    switch (category) {
      case "getting_started":
        return Icon(Icons.rocket_launch, color: primaryColor, size: 20);
      case "account":
        return Icon(Icons.account_circle, color: successColor, size: 20);
      case "features":
        return Icon(Icons.star, color: warningColor, size: 20);
      case "billing":
        return Icon(Icons.payment, color: infoColor, size: 20);
      case "technical":
        return Icon(Icons.build, color: dangerColor, size: 20);
      case "privacy":
        return Icon(Icons.security, color: primaryColor, size: 20);
      default:
        return Icon(Icons.help, color: disabledColor, size: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
        actions: [
          IconButton(
            icon: Icon(Icons.contact_support),
            onPressed: () {
              si("Opening contact support...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search FAQs...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    si("Searching for: $searchQuery");
                  },
                ),
              ],
            ),

            // Category Filter
            QDropdownField(
              label: "Category",
              items: faqCategories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // FAQ Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${faqs.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total FAQs",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredFaqs.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Found",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${faqCategories.length - 1}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Categories",
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
            ),

            // FAQ List
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
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
                  if (filteredFaqs.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      alignment: Alignment.center,
                      child: Column(
                        spacing: spSm,
                        children: [
                          Icon(Icons.search_off, size: 48, color: disabledColor),
                          Text(
                            "No FAQs found",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search or category filter",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredFaqs.map((faq) {
                      bool isExpanded = expandedFaqs.contains("${faq["id"]}");
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => _toggleFaq("${faq["id"]}"),
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                child: Row(
                                  children: [
                                    _getCategoryIcon("${faq["category"]}"),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "${faq["question"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      isExpanded 
                                          ? Icons.keyboard_arrow_up 
                                          : Icons.keyboard_arrow_down,
                                      color: disabledBoldColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isExpanded) ...[
                              Divider(height: 1),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  spacing: spSm,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${faq["answer"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        height: 1.5,
                                      ),
                                    ),
                                    SizedBox(height: spSm),
                                    Wrap(
                                      spacing: spXs,
                                      children: (faq["tags"] as List).map((tag) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "$tag",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: primaryColor,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(height: spSm),
                                    Row(
                                      children: [
                                        Icon(Icons.visibility, size: 14, color: disabledBoldColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${faq["views"]} views",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spMd),
                                        Icon(Icons.thumb_up, size: 14, color: successColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${faq["helpful"]}% helpful",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                          ),
                                        ),
                                        Spacer(),
                                        QButton(
                                          label: "Helpful",
                                          size: bs.sm,
                                          onPressed: () => _markAsHelpful(faq),
                                        ),
                                      ],
                                    ),
                                  ],
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

            // Still Need Help
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.help_center, color: infoColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Still have questions?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Can't find what you're looking for? Our support team is here to help you with any questions.",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          onPressed: () {
                            si("Opening contact support...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Live Chat",
                          onPressed: () {
                            si("Starting live chat...");
                          },
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
