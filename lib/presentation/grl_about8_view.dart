import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAbout8View extends StatefulWidget {
  @override
  State<GrlAbout8View> createState() => _GrlAbout8ViewState();
}

class _GrlAbout8ViewState extends State<GrlAbout8View> {
  String selectedCategory = 'all';
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Questions", "value": "all"},
    {"label": "Getting Started", "value": "getting_started"},
    {"label": "Account & Billing", "value": "account_billing"},
    {"label": "Technical Support", "value": "technical"},
    {"label": "Privacy & Security", "value": "privacy"},
    {"label": "Features", "value": "features"},
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "question": "How do I create an account?",
      "answer": "Creating an account is simple! Click the 'Sign Up' button on our homepage, fill in your details, and verify your email address. You'll be ready to start using our platform immediately.",
      "category": "getting_started",
      "helpful": 156,
      "views": 2340,
    },
    {
      "question": "What payment methods do you accept?",
      "answer": "We accept all major credit cards (Visa, MasterCard, American Express), PayPal, bank transfers, and various digital wallets including Apple Pay and Google Pay.",
      "category": "account_billing",
      "helpful": 134,
      "views": 1890,
    },
    {
      "question": "How can I reset my password?",
      "answer": "Click 'Forgot Password' on the login page, enter your email address, and we'll send you a secure link to reset your password. The link expires after 24 hours for security.",
      "category": "getting_started",
      "helpful": 98,
      "views": 1567,
    },
    {
      "question": "Is my data secure with your platform?",
      "answer": "Absolutely! We use industry-standard encryption, regular security audits, and comply with GDPR, CCPA, and other privacy regulations. Your data is never sold to third parties.",
      "category": "privacy",
      "helpful": 203,
      "views": 3456,
    },
    {
      "question": "Can I cancel my subscription anytime?",
      "answer": "Yes, you can cancel your subscription at any time from your account settings. There are no cancellation fees, and you'll continue to have access until the end of your billing period.",
      "category": "account_billing",
      "helpful": 167,
      "views": 2789,
    },
    {
      "question": "How do I contact customer support?",
      "answer": "You can reach our support team via email at support@company.com, through our live chat feature, or by calling +1 (555) 123-4567. We're available 24/7 to help you.",
      "category": "technical",
      "helpful": 89,
      "views": 1234,
    },
    {
      "question": "What features are included in the free plan?",
      "answer": "Our free plan includes basic features such as account creation, limited storage, basic analytics, and community support. Premium features require a paid subscription.",
      "category": "features",
      "helpful": 145,
      "views": 2156,
    },
    {
      "question": "How do I upgrade my account?",
      "answer": "Go to your account settings, click on 'Subscription', choose your desired plan, and complete the payment process. Your upgrade will be activated immediately.",
      "category": "account_billing",
      "helpful": 112,
      "views": 1876,
    },
    {
      "question": "Can I integrate your platform with other tools?",
      "answer": "Yes! We offer integrations with popular tools like Slack, Microsoft Teams, Google Workspace, Salesforce, and many others. Check our integrations page for the full list.",
      "category": "features",
      "helpful": 187,
      "views": 2934,
    },
    {
      "question": "What happens to my data if I delete my account?",
      "answer": "When you delete your account, all your personal data is permanently removed from our servers within 30 days. Some anonymized usage data may be retained for analytics purposes.",
      "category": "privacy",
      "helpful": 76,
      "views": 987,
    },
    {
      "question": "Do you offer mobile apps?",
      "answer": "Yes! We have native mobile apps for both iOS and Android. You can download them from the App Store or Google Play Store. All features are available on mobile.",
      "category": "features",
      "helpful": 198,
      "views": 3210,
    },
    {
      "question": "How can I export my data?",
      "answer": "You can export your data anytime from the account settings page. We support various formats including CSV, JSON, and PDF. The export process typically takes a few minutes.",
      "category": "technical",
      "helpful": 67,
      "views": 1123,
    },
  ];

  List<Map<String, dynamic>> supportChannels = [
    {
      "title": "Live Chat",
      "description": "Get instant help from our support team",
      "availability": "24/7",
      "response_time": "< 2 minutes",
      "icon": Icons.chat,
      "color": primaryColor,
    },
    {
      "title": "Email Support",
      "description": "Send detailed questions via email",
      "availability": "24/7",
      "response_time": "< 4 hours",
      "icon": Icons.email,
      "color": infoColor,
    },
    {
      "title": "Phone Support",
      "description": "Speak directly with our experts",
      "availability": "9AM-6PM EST",
      "response_time": "Immediate",
      "icon": Icons.phone,
      "color": successColor,
    },
    {
      "title": "Community Forum",
      "description": "Connect with other users and experts",
      "availability": "24/7",
      "response_time": "Varies",
      "icon": Icons.forum,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> helpfulResources = [
    {
      "title": "Getting Started Guide",
      "description": "Step-by-step guide for new users",
      "icon": Icons.menu_book,
      "color": primaryColor,
      "estimated_time": "10 min read",
    },
    {
      "title": "Video Tutorials",
      "description": "Watch and learn with our video library",
      "icon": Icons.play_circle,
      "color": dangerColor,
      "estimated_time": "5-15 min each",
    },
    {
      "title": "API Documentation",
      "description": "Technical documentation for developers",
      "icon": Icons.code,
      "color": infoColor,
      "estimated_time": "Technical resource",
    },
    {
      "title": "Best Practices",
      "description": "Tips and tricks from our experts",
      "icon": Icons.lightbulb,
      "color": warningColor,
      "estimated_time": "5 min read",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFaqs = selectedCategory == 'all' 
        ? faqs 
        : faqs.where((faq) => faq["category"] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
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
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help_center,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          "How can we help you?",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Find answers to frequently asked questions, browse our help resources, or contact our support team for personalized assistance.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Quick Support Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "< 2 min",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Avg Response",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "98%",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Satisfaction",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "24/7",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Available",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Support Channels
            Text(
              "Contact Support",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: supportChannels.map((channel) => Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (channel["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            channel["icon"] as IconData,
                            color: channel["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${channel["response_time"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${channel["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${channel["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Available: ${channel["availability"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: channel["color"] as Color,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start ${channel["title"]}",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // FAQ Section
            Row(
              children: [
                Text(
                  "Frequently Asked Questions",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${filteredFaqs.length} questions",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Category Filter
            QHorizontalScroll(
              children: categories.map((category) {
                final isSelected = selectedCategory == category["value"];
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Text(
                      "${category["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // FAQ List
            ...filteredFaqs.map((faq) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                childrenPadding: EdgeInsets.all(spMd),
                title: Text(
                  "${faq["question"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Text(
                    "${faq["answer"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${faq["helpful"]} helpful",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spMd),
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${faq["views"]} views",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          ss("Marked as helpful!");
                        },
                        child: Text(
                          "Was this helpful?",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Helpful Resources
            Text(
              "Helpful Resources",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...helpfulResources.map((resource) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (resource["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      resource["icon"] as IconData,
                      color: resource["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${resource["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${resource["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${resource["estimated_time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: resource["color"] as Color,
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
            )).toList(),
            
            SizedBox(height: spMd),
            
            // Still Need Help CTA
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.support_agent,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Still need help?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Our support team is standing by to help you with any questions or issues you might have.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.md,
                          onPressed: () {},
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
