import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaContactSellerView extends StatefulWidget {
  const ReaContactSellerView({super.key});

  @override
  State<ReaContactSellerView> createState() => _ReaContactSellerViewState();
}

class _ReaContactSellerViewState extends State<ReaContactSellerView> {
  String selectedTab = "Message";
  String message = "";
  String subject = "Property Inquiry";
  String name = "";
  String email = "";
  String phone = "";
  bool isUrgent = false;
  bool sendCopyToMe = true;

  List<Map<String, dynamic>> tabs = [
    {"label": "Message", "value": "Message"},
    {"label": "Call", "value": "Call"},
    {"label": "Email", "value": "Email"},
    {"label": "WhatsApp", "value": "WhatsApp"},
  ];

  Map<String, dynamic> sellerInfo = {
    "name": "Rajesh Kumar",
    "title": "Senior Property Consultant",
    "experience": "8 years",
    "phone": "+91 98765 43210",
    "email": "rajesh.kumar@realestate.com",
    "whatsapp": "+91 98765 43210",
    "rating": 4.8,
    "reviews": 156,
    "properties_sold": 89,
    "image": "https://picsum.photos/120/120?random=101&keyword=person",
    "languages": ["English", "Hindi", "Marathi"],
    "specialization": ["Residential", "Commercial", "Investment"],
    "available_hours": "9:00 AM - 8:00 PM",
    "response_time": "Within 2 hours",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Seller"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Sharing seller contact...");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              si("More options");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Seller Information Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage("${sellerInfo["image"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${sellerInfo["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${sellerInfo["title"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${sellerInfo["rating"]} (${sellerInfo["reviews"]} reviews)",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Online",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${sellerInfo["experience"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Experience",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${sellerInfo["properties_sold"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Properties Sold",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${sellerInfo["response_time"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Response Time",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.schedule, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Available: ${sellerInfo["available_hours"]}",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Specialization & Languages
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Specialization",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    children: (sellerInfo["specialization"] as List).map((spec) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$spec",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )).toList(),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Languages",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    children: (sellerInfo["languages"] as List).map((lang) => Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$lang",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),

            // Contact Method Tabs
            QCategoryPicker(
              label: "Contact Method",
              items: tabs,
              value: selectedTab,
              onChanged: (index, label, value, item) {
                selectedTab = value;
                setState(() {});
              },
            ),

            // Contact Form Based on Selected Tab
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: _buildContactForm(),
            ),

            // Quick Contact Buttons
            Container(
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
                  Text(
                    "Quick Contact",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Call Now",
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            si("Calling ${sellerInfo["phone"]}...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "WhatsApp",
                          icon: Icons.chat,
                          size: bs.sm,
                          onPressed: () {
                            si("Opening WhatsApp...");
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Schedule Call",
                          icon: Icons.schedule,
                          size: bs.sm,
                          onPressed: () {
                            si("Opening call scheduler...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Video Call",
                          icon: Icons.video_call,
                          size: bs.sm,
                          onPressed: () {
                            si("Starting video call...");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    switch (selectedTab) {
      case "Message":
        return Column(
          spacing: spMd,
          children: [
            QTextField(
              label: "Your Name",
              value: name,
              onChanged: (value) {
                name = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Subject",
              value: subject,
              onChanged: (value) {
                subject = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Message",
              value: message,
              hint: "Type your message here...",
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
                    value: [if (isUrgent) {"label": "Mark as urgent", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      isUrgent = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Send Message",
                icon: Icons.send,
                size: bs.md,
                onPressed: () {
                  if (message.isEmpty) {
                    se("Please enter a message");
                    return;
                  }
                  showLoading();
                  Future.delayed(Duration(seconds: 2), () {
                    hideLoading();
                    ss("Message sent successfully!");
                    back();
                  });
                },
              ),
            ),
          ],
        );

      case "Call":
        return Column(
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Icon(Icons.phone, color: successColor, size: 48),
                  SizedBox(height: spSm),
                  Text(
                    "${sellerInfo["phone"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Tap to call directly",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Call Now",
                icon: Icons.phone,
                size: bs.md,
                onPressed: () {
                  si("Calling ${sellerInfo["phone"]}...");
                },
              ),
            ),
          ],
        );

      case "Email":
        return Column(
          spacing: spMd,
          children: [
            QTextField(
              label: "Your Email",
              value: email,
              onChanged: (value) {
                email = value;
                setState(() {});
              },
            ),
            QTextField(
              label: "Subject",
              value: subject,
              onChanged: (value) {
                subject = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Email Message",
              value: message,
              hint: "Compose your email...",
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
                        "label": "Send copy to me",
                        "value": true,
                        "checked": sendCopyToMe,
                      }
                    ],
                    value: [if (sendCopyToMe) {"label": "Send copy to me", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      sendCopyToMe = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Send Email",
                icon: Icons.email,
                size: bs.md,
                onPressed: () {
                  if (email.isEmpty || message.isEmpty) {
                    se("Please fill all required fields");
                    return;
                  }
                  showLoading();
                  Future.delayed(Duration(seconds: 2), () {
                    hideLoading();
                    ss("Email sent successfully!");
                    back();
                  });
                },
              ),
            ),
          ],
        );

      case "WhatsApp":
        return Column(
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Icon(Icons.chat, color: successColor, size: 48),
                  SizedBox(height: spSm),
                  Text(
                    "${sellerInfo["whatsapp"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Chat directly on WhatsApp",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            QMemoField(
              label: "Pre-composed Message",
              value: message.isEmpty ? "Hi, I'm interested in your property listing. Could you please share more details?" : message,
              hint: "Customize your message...",
              onChanged: (value) {
                message = value;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Open WhatsApp",
                icon: Icons.chat,
                size: bs.md,
                onPressed: () {
                  si("Opening WhatsApp...");
                },
              ),
            ),
          ],
        );

      default:
        return Container();
    }
  }
}
