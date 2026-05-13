import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaHelpCenterView extends StatefulWidget {
  const FdaHelpCenterView({super.key});

  @override
  State<FdaHelpCenterView> createState() => _FdaHelpCenterViewState();
}

class _FdaHelpCenterViewState extends State<FdaHelpCenterView> {
  String searchQuery = "";
  String selectedCategory = "all";

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all", "icon": Icons.apps},
    {"label": "Orders", "value": "orders", "icon": Icons.receipt},
    {"label": "Delivery", "value": "delivery", "icon": Icons.delivery_dining},
    {"label": "Payment", "value": "payment", "icon": Icons.payment},
    {"label": "Account", "value": "account", "icon": Icons.person},
    {"label": "Technical", "value": "technical", "icon": Icons.settings},
  ];

  final List<Map<String, dynamic>> faqs = [
    {
      "id": 1,
      "category": "orders",
      "question": "How do I track my order?",
      "answer": "You can track your order in real-time from the 'Orders' section. You'll receive push notifications for each stage: confirmed, preparing, out for delivery, and delivered. You can also see the delivery driver's location on the map when your order is out for delivery.",
      "isPopular": true,
      "tags": ["tracking", "orders", "delivery status"],
    },
    {
      "id": 2,
      "category": "orders",
      "question": "Can I modify my order after placing it?",
      "answer": "You can modify your order within 2 minutes of placing it, provided the restaurant hasn't started preparing it. Go to 'Current Orders' and tap 'Modify Order'. After this window, you'll need to contact customer support for any changes.",
      "isPopular": true,
      "tags": ["modify", "change order", "edit"],
    },
    {
      "id": 3,
      "category": "delivery",
      "question": "What are the delivery charges?",
      "answer": "Delivery charges vary by distance and restaurant. Most restaurants charge between \$1.99-\$4.99. Many offer free delivery on orders above a certain amount (usually \$25-\$35). You'll see the exact delivery fee before confirming your order.",
      "isPopular": true,
      "tags": ["delivery fee", "charges", "cost"],
    },
    {
      "id": 4,
      "category": "delivery",
      "question": "How long does delivery take?",
      "answer": "Delivery times typically range from 25-45 minutes depending on restaurant preparation time, distance, and current demand. Each restaurant shows an estimated delivery time on their page. We'll update you if there are any delays.",
      "isPopular": false,
      "tags": ["delivery time", "how long", "duration"],
    },
    {
      "id": 5,
      "category": "payment",
      "question": "What payment methods do you accept?",
      "answer": "We accept all major credit cards (Visa, Mastercard, American Express), debit cards, PayPal, Apple Pay, Google Pay, and cash on delivery. You can save multiple payment methods in your account for faster checkout.",
      "isPopular": true,
      "tags": ["payment methods", "credit card", "paypal"],
    },
    {
      "id": 6,
      "category": "payment",
      "question": "How do refunds work?",
      "answer": "Refunds are processed automatically for cancelled orders and quality issues. Credit card refunds take 3-5 business days, while digital wallet refunds are usually instant. For cash orders, we'll credit your account wallet which you can use for future orders.",
      "isPopular": false,
      "tags": ["refund", "money back", "cancelled"],
    },
    {
      "id": 7,
      "category": "account",
      "question": "How do I delete my account?",
      "answer": "You can delete your account from Settings > Account Management > Delete Account. This action is permanent and will remove all your data including order history, saved addresses, and payment methods. Consider deactivating instead if you might return.",
      "isPopular": false,
      "tags": ["delete account", "remove profile", "permanently"],
    },
    {
      "id": 8,
      "category": "account",
      "question": "I forgot my password. How do I reset it?",
      "answer": "On the login screen, tap 'Forgot Password' and enter your email address. We'll send you a reset link. If you don't receive it within 5 minutes, check your spam folder or contact support. The reset link expires after 24 hours.",
      "isPopular": false,
      "tags": ["password reset", "forgot password", "login"],
    },
    {
      "id": 9,
      "category": "technical",
      "question": "The app is running slowly. What should I do?",
      "answer": "First, try force-closing and reopening the app. If the issue persists, restart your device and ensure you have the latest app version. Clear the app cache from your device settings. If problems continue, uninstall and reinstall the app.",
      "isPopular": false,
      "tags": ["slow app", "performance", "laggy"],
    },
    {
      "id": 10,
      "category": "technical",
      "question": "I'm not receiving notifications. How do I fix this?",
      "answer": "Check that notifications are enabled in your device settings for our app. Also verify notification preferences in the app's Settings > Notifications. Ensure 'Do Not Disturb' mode isn't blocking notifications. Try logging out and back in to refresh notification tokens.",
      "isPopular": false,
      "tags": ["notifications", "push notifications", "alerts"],
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {
      "title": "Track Order",
      "subtitle": "Check your current order status",
      "icon": Icons.track_changes,
      "color": infoColor,
      "action": "track_order",
    },
    {
      "title": "Report Issue",
      "subtitle": "Something wrong with your order?",
      "icon": Icons.report_problem,
      "color": warningColor,
      "action": "report_issue",
    },
    {
      "title": "Contact Support",
      "subtitle": "Chat with our support team",
      "icon": Icons.chat,
      "color": successColor,
      "action": "contact_support",
    },
    {
      "title": "Request Refund",
      "subtitle": "Request refund for an order",
      "icon": Icons.money_off,
      "color": dangerColor,
      "action": "request_refund",
    },
  ];

  List<Map<String, dynamic>> get filteredFAQs {
    List<Map<String, dynamic>> filtered = faqs;

    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((faq) => faq["category"] == selectedCategory).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((faq) {
        return (faq["question"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (faq["answer"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (faq["tags"] as List).any((tag) => (tag as String).toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.contact_support),
            onPressed: () {
              //navigateTo('contact_support_view')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusSm),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "How can we help you?",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Find answers to common questions or contact our support team",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
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

            SizedBox(height: spLg),

            // Search Bar
            QTextField(
              label: "Search FAQ",
              value: searchQuery,
              hint: "What can we help you with?",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Quick Actions
            Text(
              "Quick Actions",
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
              children: quickActions.map((action) {
                return GestureDetector(
                  onTap: () => _handleQuickAction(action["action"]),
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: (action["color"] as Color).withAlpha(50)),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            action["icon"],
                            color: action["color"],
                            size: 32,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${action["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${action["subtitle"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Categories
            Text(
              "Browse by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category["value"];
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedCategory = category["value"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                          boxShadow: isSelected ? [shadowSm] : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category["icon"],
                              color: isSelected ? Colors.white : disabledBoldColor,
                              size: 18,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${category["label"]}",
                              style: TextStyle(
                                color: isSelected ? Colors.white : disabledBoldColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: spLg),

            // FAQ Results
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Frequently Asked Questions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (filteredFAQs.isNotEmpty)
                  Text(
                    "${filteredFAQs.length} result${filteredFAQs.length != 1 ? 's' : ''}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
              ],
            ),
            SizedBox(height: spMd),

            if (filteredFAQs.isEmpty)
              _buildEmptyState()
            else
              Column(
                children: filteredFAQs.map((faq) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    child: _buildFAQItem(faq),
                  );
                }).toList(),
              ),

            SizedBox(height: spLg),

            // Contact Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.contact_support,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Still need help?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Can't find what you're looking for? Our support team is available 24/7 to help you with any questions or issues.",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Live Chat",
                          icon: Icons.chat,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('live_chat_view')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Send Email",
                          icon: Icons.email,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('contact_support_view')
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

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: ExpansionTile(
        leading: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Icon(
            _getCategoryIcon(faq["category"]),
            color: primaryColor,
            size: 20,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                "${faq["question"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
            if (faq["isPopular"] as bool)
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "POPULAR",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
              ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
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
                SizedBox(height: spMd),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (faq["tags"] as List).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Text(
                      "Was this helpful?",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    GestureDetector(
                      onTap: () => si("Thanks for the feedback!"),
                      child: Icon(Icons.thumb_up, size: 16, color: successColor),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () => si("Thanks for the feedback!"),
                      child: Icon(Icons.thumb_down, size: 16, color: dangerColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No results found",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              searchQuery.isNotEmpty 
                ? "Try different keywords or browse categories above"
                : "No FAQs available for this category",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Contact Support",
              icon: Icons.support_agent,
              size: bs.md,
              onPressed: () {
                //navigateTo('contact_support_view')
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "orders":
        return Icons.receipt;
      case "delivery":
        return Icons.delivery_dining;
      case "payment":
        return Icons.payment;
      case "account":
        return Icons.person;
      case "technical":
        return Icons.settings;
      default:
        return Icons.help;
    }
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case "track_order":
        si("Redirecting to order tracking...");
        break;
      case "report_issue":
        si("Opening issue report form...");
        break;
      case "contact_support":
        //navigateTo('contact_support_view')
        break;
      case "request_refund":
        si("Opening refund request form...");
        break;
    }
  }
}
