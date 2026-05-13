import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsFaqView extends StatefulWidget {
  const BrsFaqView({super.key});

  @override
  State<BrsFaqView> createState() => _BrsFaqViewState();
}

class _BrsFaqViewState extends State<BrsFaqView> {
  String searchQuery = "";
  String selectedCategory = "All";
  int? expandedIndex;

  List<Map<String, dynamic>> faqCategories = [
    {"label": "All", "value": "All"},
    {"label": "Booking", "value": "Booking"},
    {"label": "Payments", "value": "Payments"},
    {"label": "Account", "value": "Account"},
    {"label": "Services", "value": "Services"},
    {"label": "Technical", "value": "Technical"},
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "question": "How do I book an appointment with a barber?",
      "answer": "To book an appointment, simply browse our list of available barbers, select your preferred one, choose a service, pick a date and time that works for you, and confirm your booking. You'll receive a confirmation notification once your appointment is secured.",
      "category": "Booking",
      "helpful": 234,
      "views": 1847,
    },
    {
      "question": "Can I cancel or reschedule my appointment?",
      "answer": "Yes, you can cancel or reschedule your appointment up to 4 hours before the scheduled time. Go to 'My Bookings' in your profile, select the appointment you want to modify, and choose either 'Cancel' or 'Reschedule'. Please note that cancellations within 4 hours may incur a fee.",
      "category": "Booking",
      "helpful": 189,
      "views": 1432,
    },
    {
      "question": "What payment methods do you accept?",
      "answer": "We accept all major credit and debit cards (Visa, MasterCard, American Express), PayPal, Apple Pay, Google Pay, and bank transfers. All payments are processed securely through our encrypted payment system.",
      "category": "Payments",
      "helpful": 156,
      "views": 1289,
    },
    {
      "question": "How do I update my profile information?",
      "answer": "To update your profile, go to Settings > Profile Information. You can edit your name, phone number, email address, and profile picture. Don't forget to save your changes. Some changes may require email verification for security.",
      "category": "Account",
      "helpful": 143,
      "views": 976,
    },
    {
      "question": "What services are available?",
      "answer": "Our barbers offer a wide range of services including haircuts, beard trimming, hot towel shaves, hair washing, styling, and grooming consultations. Each barber may specialize in different services, so check their profile for specific offerings.",
      "category": "Services",
      "helpful": 198,
      "views": 1654,
    },
    {
      "question": "Why can't I see available time slots?",
      "answer": "If you're not seeing available time slots, try refreshing the page or selecting a different date. Sometimes barbers update their availability in real-time. If the issue persists, try logging out and back in, or contact our support team.",
      "category": "Technical",
      "helpful": 87,
      "views": 543,
    },
    {
      "question": "How far in advance can I book?",
      "answer": "You can book appointments up to 30 days in advance. This gives you plenty of time to plan ahead for special events or regular grooming sessions. Popular time slots fill up quickly, so we recommend booking early.",
      "category": "Booking",
      "helpful": 112,
      "views": 789,
    },
    {
      "question": "Is my payment information secure?",
      "answer": "Absolutely. We use industry-standard SSL encryption and PCI DSS compliance to protect your payment information. We never store your complete card details on our servers, and all transactions are processed through secure payment gateways.",
      "category": "Payments",
      "helpful": 178,
      "views": 1123,
    },
  ];

  List<Map<String, dynamic>> get filteredFaqs {
    return faqs.where((faq) {
      bool matchesCategory = selectedCategory == "All" || faq["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          (faq["question"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (faq["answer"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frequently Asked Questions"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
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
                ],
              ),
            ),

            // Category Filter
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Filter by Category",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QCategoryPicker(
                  items: faqCategories,
                  value: selectedCategory,
                  onChanged: (index, label, value, item) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // FAQ Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredFaqs.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Questions Found",
                          style: TextStyle(
                            fontSize: 12,
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
                          "${faqs.fold(0, (sum, faq) => sum + (faq["views"] as int))}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Views",
                          style: TextStyle(
                            fontSize: 12,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Questions & Answers",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${filteredFaqs.length} of ${faqs.length}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                if (filteredFaqs.isEmpty)
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
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
                          "No FAQs found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Try adjusting your search or category filter",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    spacing: spSm,
                    children: List.generate(filteredFaqs.length, (index) {
                      final faq = filteredFaqs[index];
                      final isExpanded = expandedIndex == index;
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                          border: isExpanded ? Border.all(color: primaryColor, width: 2) : null,
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                expandedIndex = isExpanded ? null : index;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: spXs,
                                        children: [
                                          Text(
                                            "${faq["question"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: successColor.withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "${faq["category"]}",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: successColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Icon(
                                                Icons.visibility,
                                                size: 12,
                                                color: disabledBoldColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${faq["views"]} views",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Icon(
                                                Icons.thumb_up,
                                                size: 12,
                                                color: disabledBoldColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${faq["helpful"]}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(10),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(radiusSm),
                                    bottomRight: Radius.circular(radiusSm),
                                  ),
                                ),
                                child: Column(
                                  spacing: spSm,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        "${faq["answer"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: disabledOutlineBorderColor,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Was this helpful?",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: successColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.thumb_up,
                                                  size: 12,
                                                  color: successColor,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: successColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: dangerColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.thumb_down,
                                                  size: 12,
                                                  color: dangerColor,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "No",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: dangerColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                    }),
                  ),
              ],
            ),

            // Still Need Help
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.help_center,
                    color: primaryColor,
                    size: 40,
                  ),
                  Text(
                    "Didn't find what you're looking for?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Our support team is ready to help you with any questions not covered in our FAQ.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  QButton(
                    label: "Contact Support",
                    size: bs.sm,
                    onPressed: () {},
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
