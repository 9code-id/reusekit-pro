import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaContactSupportView extends StatefulWidget {
  const FdaContactSupportView({super.key});

  @override
  State<FdaContactSupportView> createState() => _FdaContactSupportViewState();
}

class _FdaContactSupportViewState extends State<FdaContactSupportView> {
  String selectedCategory = "";
  String subject = "";
  String description = "";
  String priority = "Medium";
  List<String> attachments = [];
  bool loading = false;

  List<Map<String, dynamic>> supportCategories = [
    {
      "label": "Order Issues",
      "value": "order_issues",
      "icon": Icons.receipt_long,
      "description": "Problems with order, delivery, or payment",
    },
    {
      "label": "Food Quality",
      "value": "food_quality",
      "icon": Icons.restaurant,
      "description": "Issues with food quality or preparation",
    },
    {
      "label": "Delivery Problems",
      "value": "delivery_problems",
      "icon": Icons.delivery_dining,
      "description": "Late delivery, wrong address, or driver issues",
    },
    {
      "label": "App Technical",
      "value": "app_technical",
      "icon": Icons.phone_android,
      "description": "App crashes, bugs, or technical difficulties",
    },
    {
      "label": "Account & Profile",
      "value": "account_profile",
      "icon": Icons.account_circle,
      "description": "Profile settings, password, or account issues",
    },
    {
      "label": "Refund & Returns",
      "value": "refund_returns",
      "icon": Icons.monetization_on,
      "description": "Refund requests, return policies, or billing",
    },
    {
      "label": "Restaurant Partner",
      "value": "restaurant_partner",
      "icon": Icons.store,
      "description": "Issues with specific restaurant or menu",
    },
    {
      "label": "Other",
      "value": "other",
      "icon": Icons.help_outline,
      "description": "General inquiries or other concerns",
    },
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];

  List<Map<String, dynamic>> contactMethods = [
    {
      "title": "Live Chat",
      "subtitle": "Get instant help from our support team",
      "icon": Icons.chat_bubble_outline,
      "available": true,
      "estimatedTime": "2-5 minutes",
    },
    {
      "title": "Phone Support",
      "subtitle": "Call us for immediate assistance",
      "icon": Icons.phone,
      "available": true,
      "phone": "+1-800-FOOD-APP",
      "estimatedTime": "1-3 minutes",
    },
    {
      "title": "Email Support",
      "subtitle": "Send us an email for detailed inquiries",
      "icon": Icons.email_outlined,
      "available": true,
      "email": "support@foodapp.com",
      "estimatedTime": "4-24 hours",
    },
    {
      "title": "WhatsApp",
      "subtitle": "Message us on WhatsApp",
      "icon": Icons.message,
      "available": true,
      "estimatedTime": "5-15 minutes",
    },
  ];

  void _submitTicket() async {
    if (selectedCategory.isEmpty) {
      se("Please select a category");
      return;
    }
    if (subject.isEmpty) {
      se("Please enter a subject");
      return;
    }
    if (description.isEmpty) {
      se("Please describe your issue");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Support ticket submitted successfully");
    back();
  }

  void _selectCategory(String category) {
    selectedCategory = category;
    setState(() {});
  }

  void _openLiveChat() {
    // Navigate to live chat
  }

  void _callSupport() {
    // Open dialer
  }

  void _sendEmail() {
    // Open email app
  }

  void _openWhatsApp() {
    // Open WhatsApp
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
          children: [
            // Quick Contact Methods
            Text(
              "Quick Contact",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ...contactMethods.map((method) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: GestureDetector(
                  onTap: () {
                    if (method["title"] == "Live Chat") _openLiveChat();
                    if (method["title"] == "Phone Support") _callSupport();
                    if (method["title"] == "Email Support") _sendEmail();
                    if (method["title"] == "WhatsApp") _openWhatsApp();
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Icon(
                            method["icon"] as IconData,
                            color: primaryColor,
                            size: 24,
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${method["subtitle"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (method["estimatedTime"] != null) ...[
                                SizedBox(height: spXs),
                                Text(
                                  "Response time: ${method["estimatedTime"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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
                  ),
                ),
              );
            }).toList(),

            SizedBox(height: spLg),

            // Create Support Ticket
            Text(
              "Create Support Ticket",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Can't find immediate help? Create a detailed support ticket and we'll get back to you soon.",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),

            // Category Selection
            Text(
              "Select Category",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: supportCategories.map((category) {
                bool isSelected = selectedCategory == category["value"];
                return GestureDetector(
                  onTap: () => _selectCategory(category["value"]),
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          category["icon"] as IconData,
                          color: isSelected ? primaryColor : disabledBoldColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${category["label"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${category["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Form Fields
            QTextField(
              label: "Subject",
              value: subject,
              hint: "Brief description of your issue",
              onChanged: (value) {
                subject = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            QDropdownField(
              label: "Priority",
              items: priorityOptions,
              value: priority,
              onChanged: (value, label) {
                priority = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            QMemoField(
              label: "Description",
              value: description,
              hint: "Please describe your issue in detail...",
              onChanged: (value) {
                description = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            QMultiImagePicker(
              label: "Attachments (Optional)",
              value: attachments,
              hint: "Add screenshots or photos to help us understand your issue",
              maxImages: 5,
              onChanged: (value) {
                attachments = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),

            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Submitting..." : "Submit Ticket",
                size: bs.md,
                onPressed: loading ? null : _submitTicket,
              ),
            ),
            SizedBox(height: spMd),

            // Help Text
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "We typically respond to support tickets within 24 hours. For urgent issues, please use live chat or phone support.",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
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
