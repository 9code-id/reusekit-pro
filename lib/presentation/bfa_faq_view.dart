import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaFaqView extends StatefulWidget {
  const BfaFaqView({super.key});

  @override
  State<BfaFaqView> createState() => _BfaFaqViewState();
}

class _BfaFaqViewState extends State<BfaFaqView> {
  String searchQuery = "";
  String selectedCategory = "all";
  int? expandedIndex;

  List<Map<String, dynamic>> faqCategories = [
    {"label": "All", "value": "all"},
    {"label": "Account", "value": "account"},
    {"label": "Cards", "value": "cards"},
    {"label": "Loans", "value": "loans"},
    {"label": "Payments", "value": "payments"},
    {"label": "Security", "value": "security"},
    {"label": "Mobile App", "value": "mobile"},
  ];

  List<Map<String, dynamic>> faqData = [
    {
      "category": "account",
      "question": "How do I open a new bank account?",
      "answer": "You can open a new account by visiting any of our branches with valid ID, proof of address, and initial deposit. You can also start the process online through our mobile app.",
      "tags": ["account", "opening", "documents"],
      "helpful": 245,
      "notHelpful": 12,
    },
    {
      "category": "account",
      "question": "What documents are required for account opening?",
      "answer": "Required documents include: Valid government-issued photo ID (passport, driver's license), proof of address (utility bill, lease agreement), Social Security card, and minimum opening deposit.",
      "tags": ["documents", "requirements", "account"],
      "helpful": 189,
      "notHelpful": 8,
    },
    {
      "category": "cards",
      "question": "How do I apply for a credit card?",
      "answer": "You can apply for a credit card through our mobile app, website, or by visiting a branch. You'll need to provide personal information, income details, and undergo a credit check.",
      "tags": ["credit card", "application", "approval"],
      "helpful": 312,
      "notHelpful": 15,
    },
    {
      "category": "cards",
      "question": "What should I do if my card is lost or stolen?",
      "answer": "Immediately call our 24/7 customer service hotline to report and block your card. You can also use the mobile app to temporarily freeze your card. We'll issue a replacement card within 3-5 business days.",
      "tags": ["lost card", "stolen card", "replacement"],
      "helpful": 423,
      "notHelpful": 7,
    },
    {
      "category": "loans",
      "question": "What types of loans do you offer?",
      "answer": "We offer personal loans, home loans, auto loans, education loans, and business loans. Each loan type has different eligibility criteria and interest rates.",
      "tags": ["loan types", "personal loan", "home loan"],
      "helpful": 267,
      "notHelpful": 19,
    },
    {
      "category": "loans",
      "question": "How is my loan eligibility calculated?",
      "answer": "Loan eligibility is based on factors including your credit score, income, employment history, existing debts, and the loan amount requested. Our loan calculator can give you an estimate.",
      "tags": ["eligibility", "credit score", "income"],
      "helpful": 198,
      "notHelpful": 23,
    },
    {
      "category": "payments",
      "question": "How do I set up automatic bill payments?",
      "answer": "You can set up autopay through online banking or the mobile app. Go to Bill Pay, select the payee, choose the account to pay from, and set the payment schedule.",
      "tags": ["autopay", "bill payment", "automatic"],
      "helpful": 334,
      "notHelpful": 11,
    },
    {
      "category": "payments",
      "question": "What are the transfer limits?",
      "answer": "Daily transfer limits vary by account type: Checking accounts have a \$5,000 daily limit, Savings accounts have a \$2,500 limit. You can request higher limits by contacting customer service.",
      "tags": ["transfer limits", "daily limits", "account types"],
      "helpful": 156,
      "notHelpful": 28,
    },
    {
      "category": "security",
      "question": "How do I enable two-factor authentication?",
      "answer": "Go to Security Settings in your account, select Two-Factor Authentication, choose your preferred method (SMS or authenticator app), and follow the setup instructions.",
      "tags": ["2FA", "security", "authentication"],
      "helpful": 289,
      "notHelpful": 9,
    },
    {
      "category": "security",
      "question": "What should I do if I suspect fraudulent activity?",
      "answer": "Immediately contact our fraud department at 1-800-FRAUD-HELP, change your online banking password, and review recent transactions. We'll investigate and resolve the issue promptly.",
      "tags": ["fraud", "suspicious activity", "security"],
      "helpful": 378,
      "notHelpful": 6,
    },
    {
      "category": "mobile",
      "question": "How do I download and set up the mobile app?",
      "answer": "Download our app from the App Store or Google Play Store. Use your online banking credentials to log in. If you don't have online banking, you can register through the app.",
      "tags": ["mobile app", "download", "setup"],
      "helpful": 445,
      "notHelpful": 13,
    },
    {
      "category": "mobile",
      "question": "Can I deposit checks using the mobile app?",
      "answer": "Yes, you can deposit checks using our mobile deposit feature. Simply take photos of the front and back of the check and follow the app instructions. Funds are typically available within 1-2 business days.",
      "tags": ["mobile deposit", "check deposit", "mobile app"],
      "helpful": 367,
      "notHelpful": 18,
    },
  ];

  List<Map<String, dynamic>> get filteredFAQs {
    return faqData.where((faq) {
      bool matchesCategory = selectedCategory == "all" || faq["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty ||
          faq["question"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          faq["answer"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          (faq["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frequently Asked Questions"),
        actions: [
          IconButton(
            icon: Icon(Icons.contact_support),
            onPressed: () {
              //navigateTo(BfaChatSupportView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_center,
                    color: primaryColor,
                    size: 28,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Need Help?",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Find answers to common questions or contact our support team.",
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

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search FAQs",
                    value: searchQuery,
                    hint: "Type your question or keywords...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),

            QCategoryPicker(
              label: "Filter by Category",
              items: faqCategories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Found ${filteredFAQs.length} FAQ(s)",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            if (filteredFAQs.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No FAQs Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search terms or category filter.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Contact Support",
                      size: bs.sm,
                      icon: Icons.support_agent,
                      onPressed: () {
                        //navigateTo(BfaChatSupportView());
                      },
                    ),
                  ],
                ),
              ),

            ...filteredFAQs.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> faq = entry.value;
              bool isExpanded = expandedIndex == index;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isExpanded ? Border.all(color: primaryColor.withAlpha(50)) : null,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        expandedIndex = isExpanded ? null : index;
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(radiusMd),
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
                                "${faq["category"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${faq["question"]}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: isExpanded ? primaryColor : Colors.black87,
                                ),
                              ),
                            ),
                            Icon(
                              isExpanded ? Icons.expand_less : Icons.expand_more,
                              color: primaryColor,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    if (isExpanded)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(spMd, 0, spMd, spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Divider(color: Colors.grey.withAlpha(30)),
                            
                            Text(
                              "${faq["answer"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                            
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (faq["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "#$tag",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            Row(
                              children: [
                                Text(
                                  "Was this helpful?",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {
                                    ss("Thank you for your feedback!");
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.thumb_up, size: 16, color: successColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${faq["helpful"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {
                                    si("Thank you for your feedback. We'll improve this answer.");
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.thumb_down, size: 16, color: dangerColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${faq["notHelpful"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: dangerColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.support_agent,
                    size: 32,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Still Need Help?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Can't find what you're looking for? Our support team is here to help you 24/7.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Contact Support",
                      size: bs.md,
                      icon: Icons.chat,
                      onPressed: () {
                        //navigateTo(BfaChatSupportView());
                      },
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
