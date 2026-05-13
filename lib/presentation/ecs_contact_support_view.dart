import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsContactSupportView extends StatefulWidget {
  const EcsContactSupportView({super.key});

  @override
  State<EcsContactSupportView> createState() => _EcsContactSupportViewState();
}

class _EcsContactSupportViewState extends State<EcsContactSupportView> {
  final formKey = GlobalKey<FormState>();
  
  String issueCategory = "Order Issues";
  String subject = "";
  String message = "";
  String contactEmail = "";
  String orderNumber = "";
  bool urgent = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Order Issues", "value": "Order Issues"},
    {"label": "Payment Problems", "value": "Payment Problems"},
    {"label": "Shipping & Delivery", "value": "Shipping & Delivery"},
    {"label": "Product Quality", "value": "Product Quality"},
    {"label": "Return & Refund", "value": "Return & Refund"},
    {"label": "Account Issues", "value": "Account Issues"},
    {"label": "Technical Support", "value": "Technical Support"},
    {"label": "General Inquiry", "value": "General Inquiry"},
  ];

  List<Map<String, dynamic>> supportOptions = [
    {
      "icon": Icons.chat,
      "title": "Live Chat",
      "subtitle": "Chat with our support team",
      "availability": "Available 24/7",
      "color": primaryColor,
    },
    {
      "icon": Icons.call,
      "title": "Phone Support",
      "subtitle": "Call us directly",
      "availability": "Mon-Fri, 9AM-6PM EST",
      "color": successColor,
    },
    {
      "icon": Icons.email,
      "title": "Email Support",
      "subtitle": "Send us an email",
      "availability": "Response within 24 hours",
      "color": infoColor,
    },
    {
      "icon": Icons.help,
      "title": "Help Center",
      "subtitle": "Browse FAQ and guides",
      "availability": "Self-service available",
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> faqItems = [
    {
      "question": "How can I track my order?",
      "answer": "You can track your order by going to 'Order History' in your profile and clicking on the specific order.",
    },
    {
      "question": "What is your return policy?",
      "answer": "We offer 30-day returns for most items. Items must be in original condition with tags attached.",
    },
    {
      "question": "How long does shipping take?",
      "answer": "Standard shipping takes 3-5 business days. Express shipping takes 1-2 business days.",
    },
    {
      "question": "How can I change my delivery address?",
      "answer": "You can change your delivery address from your Address Book in the profile section.",
    },
  ];

  bool loading = false;

  void _submitTicket() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      loading = false;
      setState(() {});

      ss("Support ticket submitted successfully");
      
      // Clear form
      subject = "";
      message = "";
      orderNumber = "";
      urgent = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Support"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Support Options
            Text(
              "Get Help",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: supportOptions.map((option) {
                return GestureDetector(
                  onTap: () {
                    if (option["title"] == "Live Chat") {
                      //navigateTo('live_chat')
                    } else if (option["title"] == "Phone Support") {
                      // Open phone dialer
                    } else if (option["title"] == "Help Center") {
                      //navigateTo('faq')
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (option["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            option["icon"] as IconData,
                            size: 24,
                            color: option["color"] as Color,
                          ),
                        ),
                        Text(
                          "${option["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${option["subtitle"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${option["availability"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Submit Ticket Form
            Text(
              "Submit a Support Ticket",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  children: [
                    QDropdownField(
                      label: "Issue Category",
                      items: categoryOptions,
                      value: issueCategory,
                      onChanged: (value, label) {
                        issueCategory = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Subject",
                      value: subject,
                      hint: "Brief description of your issue",
                      validator: Validator.required,
                      onChanged: (value) {
                        subject = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Contact Email",
                      value: contactEmail,
                      hint: "your.email@example.com",
                      validator: Validator.email,
                      onChanged: (value) {
                        contactEmail = value;
                        setState(() {});
                      },
                    ),
                    if (issueCategory == "Order Issues" || issueCategory == "Shipping & Delivery")
                      QTextField(
                        label: "Order Number",
                        value: orderNumber,
                        hint: "ORD-123456789",
                        onChanged: (value) {
                          orderNumber = value;
                          setState(() {});
                        },
                      ),
                    QMemoField(
                      label: "Message",
                      value: message,
                      hint: "Please describe your issue in detail...",
                      validator: Validator.required,
                      onChanged: (value) {
                        message = value;
                        setState(() {});
                      },
                    ),
                    // Urgent Priority
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Mark as Urgent",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "For critical issues requiring immediate attention",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: urgent,
                          onChanged: (value) {
                            urgent = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: loading ? "Submitting..." : "Submit Ticket",
                        size: bs.md,
                        onPressed: loading ? null : _submitTicket,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // FAQ Section
            Text(
              "Frequently Asked Questions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: faqItems.map((faq) {
                  return ExpansionTile(
                    title: Text(
                      "${faq["question"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        child: Text(
                          "${faq["answer"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Contact Information
            Text(
              "Other Ways to Reach Us",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.call,
                          size: 20,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Phone Support",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "+1 (800) 123-4567",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Monday - Friday, 9AM - 6PM EST",
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
                  Divider(color: disabledOutlineBorderColor),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.email,
                          size: 20,
                          color: infoColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Email Support",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "support@ecommerce.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Response within 24 hours",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
