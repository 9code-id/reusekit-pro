import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaAgentContactView extends StatefulWidget {
  const ReaAgentContactView({super.key});

  @override
  State<ReaAgentContactView> createState() => _ReaAgentContactViewState();
}

class _ReaAgentContactViewState extends State<ReaAgentContactView> {
  String name = "";
  String email = "";
  String phone = "";
  String message = "";
  String subject = "Property Inquiry";
  String propertyId = "";
  
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> subjects = [
    {"label": "Property Inquiry", "value": "Property Inquiry"},
    {"label": "Schedule Visit", "value": "Schedule Visit"},
    {"label": "Price Negotiation", "value": "Price Negotiation"},
    {"label": "Legal Assistance", "value": "Legal Assistance"},
    {"label": "Documentation", "value": "Documentation"},
    {"label": "General Question", "value": "General Question"},
  ];

  Map<String, dynamic> agent = {
    "id": "1",
    "name": "Sarah Johnson",
    "image": "https://picsum.photos/200/200?random=101&keyword=agent",
    "rating": 4.8,
    "reviews": 156,
    "experience": "8 years",
    "specialization": "Luxury Properties",
    "phone": "+1 234 567 8900",
    "email": "sarah.johnson@realestate.com",
    "office": "Downtown Office",
    "languages": ["English", "Spanish", "French"],
    "properties_sold": 245,
    "avg_response_time": "< 1 hour",
    "license_number": "RE123456789",
  };

  List<Map<String, dynamic>> contactMethods = [
    {
      "icon": Icons.phone,
      "title": "Call Agent",
      "subtitle": "Direct phone call",
      "action": "call",
      "color": successColor,
    },
    {
      "icon": Icons.message,
      "title": "Send Message", 
      "subtitle": "WhatsApp or SMS",
      "action": "message",
      "color": infoColor,
    },
    {
      "icon": Icons.email,
      "title": "Email Agent",
      "subtitle": "Send detailed inquiry",
      "action": "email", 
      "color": primaryColor,
    },
    {
      "icon": Icons.video_call,
      "title": "Video Call",
      "subtitle": "Schedule video meeting",
      "action": "video",
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Agent"),
        actions: [
          IconButton(
            icon: Icon(Icons.star_border),
            onPressed: () {},
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildAgentCard(),
                  _buildContactMethods(),
                  _buildContactForm(),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildAgentCard() {
    return Container(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${agent["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${agent["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${agent["specialization"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: warningColor),
                        SizedBox(width: spXs),
                        Text(
                          "${(agent["rating"] as num).toStringAsFixed(1)} (${agent["reviews"]} reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  "Experience", 
                  "${agent["experience"]}",
                  Icons.work,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  "Properties Sold", 
                  "${agent["properties_sold"]}",
                  Icons.home,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  "Response Time", 
                  "${agent["avg_response_time"]}",
                  Icons.access_time,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: primaryColor),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildContactMethods() {
    return Container(
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
            "Contact Methods",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...contactMethods.map((method) => _buildContactMethodItem(method)),
        ],
      ),
    );
  }

  Widget _buildContactMethodItem(Map<String, dynamic> method) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: GestureDetector(
        onTap: () => _handleContactMethod("${method["action"]}"),
        child: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: (method["color"] as Color).withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: (method["color"] as Color).withAlpha(100),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: method["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  method["icon"] as IconData,
                  color: Colors.white,
                  size: 20,
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
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${method["subtitle"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
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
            "Send Message",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Your Name",
            value: name,
            validator: Validator.required,
            onChanged: (value) {
              name = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Email",
                  value: email,
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Phone",
                  value: phone,
                  validator: Validator.required,
                  onChanged: (value) {
                    phone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Subject",
            items: subjects,
            value: subject,
            onChanged: (value, label) {
              subject = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Property ID (Optional)",
            value: propertyId,
            hint: "Enter property ID if inquiry is about specific property",
            onChanged: (value) {
              propertyId = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Message",
            value: message,
            hint: "Describe your inquiry in detail",
            validator: Validator.required,
            onChanged: (value) {
              message = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Send Message",
        onPressed: _sendMessage,
      ),
    );
  }

  void _handleContactMethod(String action) {
    switch (action) {
      case "call":
        ss("Calling ${agent["name"]}...");
        break;
      case "message":
        ss("Opening messaging app...");
        break;
      case "email":
        ss("Opening email client...");
        break;
      case "video":
        ss("Scheduling video call...");
        break;
    }
  }

  void _sendMessage() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});

      await Future.delayed(Duration(seconds: 2));

      loading = false;
      setState(() {});

      ss("Message sent successfully!");
      back();
    }
  }
}
