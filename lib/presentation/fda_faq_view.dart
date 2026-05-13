import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaFaqView extends StatefulWidget {
  const FdaFaqView({super.key});

  @override
  State<FdaFaqView> createState() => _FdaFaqViewState();
}

class _FdaFaqViewState extends State<FdaFaqView> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool loading = false;

  List<Map<String, dynamic>> faqCategories = [
    {"label": "All", "value": "All", "count": 45},
    {"label": "Orders", "value": "orders", "count": 12},
    {"label": "Delivery", "value": "delivery", "count": 8},
    {"label": "Payment", "value": "payment", "count": 6},
    {"label": "Account", "value": "account", "count": 7},
    {"label": "Restaurants", "value": "restaurants", "count": 5},
    {"label": "App Issues", "value": "app_issues", "count": 4},
    {"label": "Refunds", "value": "refunds", "count": 3},
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "question": "How can I track my order?",
      "answer": "You can track your order in real-time by going to 'My Orders' section in the app. You'll see the current status of your order including preparation, pickup, and delivery progress. You'll also receive push notifications for each status update.",
      "category": "orders",
      "isExpanded": false,
      "helpful": 124,
      "notHelpful": 8,
    },
    {
      "question": "What payment methods do you accept?",
      "answer": "We accept all major credit and debit cards (Visa, MasterCard, American Express), PayPal, Apple Pay, Google Pay, and cash on delivery in selected areas. You can also use FoodApp credits and gift cards.",
      "category": "payment",
      "isExpanded": false,
      "helpful": 98,
      "notHelpful": 3,
    },
    {
      "question": "How long does delivery usually take?",
      "answer": "Delivery times vary depending on your location, restaurant preparation time, and current demand. Typically, orders are delivered within 30-45 minutes. You can see the estimated delivery time before placing your order.",
      "category": "delivery",
      "isExpanded": false,
      "helpful": 156,
      "notHelpful": 12,
    },
    {
      "question": "Can I cancel my order after placing it?",
      "answer": "Yes, you can cancel your order within 2 minutes of placing it for a full refund. After that, cancellation depends on whether the restaurant has started preparing your order. If preparation has begun, cancellation may not be possible.",
      "category": "orders",
      "isExpanded": false,
      "helpful": 89,
      "notHelpful": 15,
    },
    {
      "question": "How do I get a refund for my order?",
      "answer": "If you're unsatisfied with your order, you can request a refund through the app by going to 'Order History', selecting the order, and clicking 'Report Issue'. Refunds are typically processed within 3-5 business days to your original payment method.",
      "category": "refunds",
      "isExpanded": false,
      "helpful": 134,
      "notHelpful": 7,
    },
    {
      "question": "Why was my order cancelled by the restaurant?",
      "answer": "Restaurants may cancel orders due to item unavailability, kitchen closure, high order volume, or delivery zone restrictions. When this happens, you'll receive a full refund automatically and a notification explaining the reason.",
      "category": "orders",
      "isExpanded": false,
      "helpful": 76,
      "notHelpful": 22,
    },
    {
      "question": "How can I change my delivery address?",
      "answer": "You can update your delivery address during checkout or by going to 'Profile' > 'Manage Addresses'. Note that changing the address after placing an order may not always be possible, especially if the driver has already picked up your order.",
      "category": "account",
      "isExpanded": false,
      "helpful": 67,
      "notHelpful": 5,
    },
    {
      "question": "What if my food arrives cold or damaged?",
      "answer": "If your food arrives cold, damaged, or doesn't match your order, please report it immediately through the app. Go to 'Order History', select the order, and click 'Report Issue'. We'll offer a refund, redelivery, or credit based on the situation.",
      "category": "delivery",
      "isExpanded": false,
      "helpful": 143,
      "notHelpful": 9,
    },
    {
      "question": "How do I contact customer support?",
      "answer": "You can contact our 24/7 customer support through live chat in the app, email us at support@foodapp.com, call our hotline, or use the contact form. Live chat typically provides the fastest response.",
      "category": "app_issues",
      "isExpanded": false,
      "helpful": 201,
      "notHelpful": 4,
    },
    {
      "question": "Can I schedule an order for later?",
      "answer": "Yes! You can schedule orders up to 7 days in advance. During checkout, select 'Schedule Order' and choose your preferred date and time. This feature is available for most restaurants during their operating hours.",
      "category": "orders",
      "isExpanded": false,
      "helpful": 88,
      "notHelpful": 6,
    },
  ];

  List<Map<String, dynamic>> get filteredFaqs {
    List<Map<String, dynamic>> filtered = faqs;

    if (selectedCategory != "All") {
      filtered = filtered.where((faq) => faq["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((faq) {
        return faq["question"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               faq["answer"].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  void _toggleExpanded(int index) {
    faqs[index]["isExpanded"] = !faqs[index]["isExpanded"];
    setState(() {});
  }

  void _markHelpful(Map<String, dynamic> faq, bool helpful) {
    if (helpful) {
      faq["helpful"] = (faq["helpful"] as int) + 1;
      ss("Thank you for your feedback!");
    } else {
      faq["notHelpful"] = (faq["notHelpful"] as int) + 1;
      si("We'll work on improving this answer");
    }
    setState(() {});
  }

  void _contactSupport() {
    // Navigate to contact support
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
        actions: [
          IconButton(
            icon: Icon(Icons.support_agent),
            onPressed: _contactSupport,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Search Bar
                Container(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search FAQ",
                          value: searchQuery,
                          hint: "Search for questions or topics...",
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                // Categories Filter
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    children: faqCategories.map((category) {
                      bool isSelected = selectedCategory == category["value"];
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
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${category["label"]}",
                                style: TextStyle(
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.white.withAlpha(30) : disabledColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${category["count"]}",
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : disabledBoldColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: spMd),

                // FAQ List
                Expanded(
                  child: filteredFaqs.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 80,
                                color: disabledColor,
                              ),
                              SizedBox(height: spMd),
                              Text(
                                "No FAQs found",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Try adjusting your search or category filter",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledColor,
                                ),
                              ),
                              SizedBox(height: spMd),
                              QButton(
                                label: "Contact Support",
                                size: bs.sm,
                                onPressed: _contactSupport,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          itemCount: filteredFaqs.length,
                          itemBuilder: (context, index) {
                            final faq = filteredFaqs[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: spMd),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusMd),
                                boxShadow: [shadowSm],
                              ),
                              child: Column(
                                children: [
                                  // Question Header
                                  GestureDetector(
                                    onTap: () => _toggleExpanded(index),
                                    child: Container(
                                      padding: EdgeInsets.all(spMd),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${faq["question"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            faq["isExpanded"] ? Icons.expand_less : Icons.expand_more,
                                            color: primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Answer Section
                                  if (faq["isExpanded"]) ...[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(spMd, 0, spMd, spMd),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 1,
                                            color: disabledOutlineBorderColor,
                                          ),
                                          SizedBox(height: spMd),
                                          Text(
                                            "${faq["answer"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: disabledBoldColor,
                                              height: 1.5,
                                            ),
                                          ),
                                          SizedBox(height: spMd),

                                          // Helpful Rating
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
                                                onTap: () => _markHelpful(faq, true),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.thumb_up_outlined,
                                                      size: 16,
                                                      color: successColor,
                                                    ),
                                                    SizedBox(width: spXs),
                                                    Text(
                                                      "${faq["helpful"]}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: successColor,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              GestureDetector(
                                                onTap: () => _markHelpful(faq, false),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.thumb_down_outlined,
                                                      size: 16,
                                                      color: dangerColor,
                                                    ),
                                                    SizedBox(width: spXs),
                                                    Text(
                                                      "${faq["notHelpful"]}",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: dangerColor,
                                                        fontWeight: FontWeight.w600,
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
                          },
                        ),
                ),

                // Contact Support Footer
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: primaryColor,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Still need help?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Contact our 24/7 support team",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Contact Support",
                        size: bs.sm,
                        onPressed: _contactSupport,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
