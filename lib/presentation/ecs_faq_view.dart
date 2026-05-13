import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsFaqView extends StatefulWidget {
  const EcsFaqView({super.key});

  @override
  State<EcsFaqView> createState() => _EcsFaqViewState();
}

class _EcsFaqViewState extends State<EcsFaqView> {
  String searchQuery = "";
  String selectedCategory = "all";
  Set<int> expandedItems = {};

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Account", "value": "account"},
    {"label": "Orders", "value": "orders"},
    {"label": "Payments", "value": "payments"},
    {"label": "Shipping", "value": "shipping"},
    {"label": "Returns", "value": "returns"},
    {"label": "Technical", "value": "technical"},
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "id": 1,
      "category": "account",
      "question": "How do I create an account?",
      "answer": "To create an account, tap 'Sign Up' on the login screen, enter your email address, create a password, and verify your email. You can also sign up using your social media accounts like Google or Facebook.",
      "helpful_count": 245,
      "tags": ["signup", "registration", "email"],
    },
    {
      "id": 2,
      "category": "account",
      "question": "How can I reset my password?",
      "answer": "On the login screen, tap 'Forgot Password', enter your email address, and we'll send you a reset link. Click the link in your email and follow the instructions to create a new password.",
      "helpful_count": 189,
      "tags": ["password", "reset", "forgot"],
    },
    {
      "id": 3,
      "category": "orders",
      "question": "How do I track my order?",
      "answer": "Go to 'My Orders' in your account menu and select the order you want to track. You'll see real-time updates on your order status, including when it's packed, shipped, and out for delivery. You'll also receive SMS and email notifications.",
      "helpful_count": 421,
      "tags": ["tracking", "status", "delivery"],
    },
    {
      "id": 4,
      "category": "orders",
      "question": "Can I modify or cancel my order?",
      "answer": "You can modify or cancel your order within 30 minutes of placing it, provided it hasn't been packed yet. Go to 'My Orders', select the order, and choose 'Modify' or 'Cancel'. After 30 minutes, contact our support team for assistance.",
      "helpful_count": 156,
      "tags": ["cancel", "modify", "change"],
    },
    {
      "id": 5,
      "category": "payments",
      "question": "What payment methods do you accept?",
      "answer": "We accept all major credit and debit cards (Visa, Mastercard, American Express), PayPal, Apple Pay, Google Pay, and bank transfers. All payments are secured with 256-bit SSL encryption.",
      "helpful_count": 298,
      "tags": ["payment", "credit card", "paypal"],
    },
    {
      "id": 6,
      "category": "payments",
      "question": "Why was my payment declined?",
      "answer": "Payments can be declined for several reasons: insufficient funds, incorrect card details, expired card, or security restrictions from your bank. Try using a different payment method or contact your bank to resolve the issue.",
      "helpful_count": 134,
      "tags": ["declined", "failed", "error"],
    },
    {
      "id": 7,
      "category": "shipping",
      "question": "What are your shipping options?",
      "answer": "We offer Standard Shipping (3-5 business days), Express Shipping (1-2 business days), and Same-Day Delivery (available in select cities). Shipping costs vary based on location and order value. Free shipping is available on orders over \$50.",
      "helpful_count": 367,
      "tags": ["shipping", "delivery", "free shipping"],
    },
    {
      "id": 8,
      "category": "shipping",
      "question": "Do you ship internationally?",
      "answer": "Yes, we ship to over 50 countries worldwide. International shipping takes 7-14 business days and includes customs and duties. Check our shipping page for a full list of supported countries and rates.",
      "helpful_count": 203,
      "tags": ["international", "worldwide", "customs"],
    },
    {
      "id": 9,
      "category": "returns",
      "question": "What is your return policy?",
      "answer": "We offer a 30-day return policy for unused items in original packaging. To initiate a return, go to 'My Orders', select the item, and choose 'Return'. We'll provide a prepaid return label and process your refund within 5-7 business days.",
      "helpful_count": 445,
      "tags": ["return", "refund", "policy"],
    },
    {
      "id": 10,
      "category": "returns",
      "question": "How long does it take to get my refund?",
      "answer": "Refunds are processed within 5-7 business days after we receive your returned item. The amount will be credited back to your original payment method. For PayPal payments, refunds may take up to 10 business days.",
      "helpful_count": 178,
      "tags": ["refund", "timeline", "processing"],
    },
    {
      "id": 11,
      "category": "technical",
      "question": "The app keeps crashing, what should I do?",
      "answer": "Try these steps: 1) Force close and restart the app, 2) Restart your device, 3) Clear app cache in settings, 4) Update to the latest app version, 5) Uninstall and reinstall the app. If the problem persists, contact our technical support.",
      "helpful_count": 89,
      "tags": ["crash", "bug", "technical"],
    },
    {
      "id": 12,
      "category": "technical",
      "question": "Why can't I log into my account?",
      "answer": "Login issues can occur due to: incorrect email/password, account suspension, server maintenance, or app version problems. Try resetting your password, updating the app, or contact support if you believe your account was suspended.",
      "helpful_count": 156,
      "tags": ["login", "access", "suspended"],
    },
  ];

  List<Map<String, dynamic>> get filteredFaqs {
    var filtered = faqs;
    
    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((faq) => faq["category"] == selectedCategory).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((faq) {
        String question = faq["question"].toString().toLowerCase();
        String answer = faq["answer"].toString().toLowerCase();
        List<String> tags = (faq["tags"] as List).map((tag) => tag.toString().toLowerCase()).toList();
        
        return question.contains(searchQuery.toLowerCase()) ||
               answer.contains(searchQuery.toLowerCase()) ||
               tags.any((tag) => tag.contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    return filtered;
  }

  void _toggleExpanded(int faqId) {
    if (expandedItems.contains(faqId)) {
      expandedItems.remove(faqId);
    } else {
      expandedItems.add(faqId);
    }
    setState(() {});
  }

  void _markHelpful(int faqId) {
    var faqIndex = faqs.indexWhere((faq) => faq["id"] == faqId);
    if (faqIndex != -1) {
      faqs[faqIndex]["helpful_count"]++;
      setState(() {});
      ss("Thank you for your feedback!");
    }
  }

  Widget _buildFaqItem(Map<String, dynamic> faq) {
    bool isExpanded = expandedItems.contains(faq["id"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isExpanded ? primaryColor.withAlpha(100) : disabledOutlineBorderColor,
        ),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _toggleExpanded(faq["id"] as int),
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Row(
                children: [
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
                  Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    color: primaryColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          
          if (isExpanded) ...[
            Container(
              width: double.infinity,
              height: 1,
              color: disabledOutlineBorderColor,
            ),
            
            Container(
              padding: EdgeInsets.all(spSm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${faq["answer"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Tags
                  Wrap(
                    spacing: spXs,
                    children: (faq["tags"] as List).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Helpful Section
                  Row(
                    children: [
                      Text(
                        "Was this helpful?",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _markHelpful(faq["id"] as int),
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${faq["helpful_count"]}",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 12,
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Frequently Asked Questions",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Search
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search FAQs",
                    value: searchQuery,
                    hint: "Search questions, answers, or topics...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.clear,
                  size: bs.sm,
                  onPressed: () {
                    searchQuery = "";
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Category Filter
            QCategoryPicker(
              label: "Filter by Category",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Results Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Showing ${filteredFaqs.length} question${filteredFaqs.length == 1 ? '' : 's'}",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // FAQ List
            if (filteredFaqs.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Questions Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      searchQuery.isNotEmpty 
                        ? "Try searching with different keywords"
                        : "No questions available for this category",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredFaqs.map((faq) => _buildFaqItem(faq)).toList(),
              ),

            SizedBox(height: spMd),

            // Contact Support
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.contact_support,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Can't find what you're looking for?",
                          style: TextStyle(
                            color: warningColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Our support team is here to help! Contact us via live chat, email, or phone for personalized assistance.",
                    style: TextStyle(
                      color: warningColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.sm,
                          onPressed: () => si("Opening contact support"),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Live Chat",
                          color: successColor,
                          size: bs.sm,
                          onPressed: () => si("Opening live chat"),
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
