import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHelp9View extends StatefulWidget {
  @override
  State<GrlHelp9View> createState() => _GrlHelp9ViewState();
}

class _GrlHelp9ViewState extends State<GrlHelp9View> {
  String selectedRegion = "US";
  String selectedDepartment = "all";

  List<Map<String, dynamic>> regions = [
    {"label": "United States", "value": "US"},
    {"label": "United Kingdom", "value": "UK"},
    {"label": "Canada", "value": "CA"},
    {"label": "Australia", "value": "AU"},
    {"label": "Europe", "value": "EU"},
    {"label": "Asia Pacific", "value": "AP"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "General Support", "value": "general"},
    {"label": "Technical Support", "value": "technical"},
    {"label": "Billing Support", "value": "billing"},
    {"label": "Sales Inquiries", "value": "sales"},
  ];

  Map<String, List<Map<String, dynamic>>> contactInfo = {
    "US": [
      {
        "department": "general",
        "title": "General Support",
        "phone": "+1 (555) 123-4567",
        "email": "support@company.com",
        "hours": "Mon-Fri: 9AM-6PM EST",
        "language": "English",
        "color": primaryColor
      },
      {
        "department": "technical",
        "title": "Technical Support",
        "phone": "+1 (555) 123-4568",
        "email": "tech@company.com",
        "hours": "24/7 Support Available",
        "language": "English",
        "color": dangerColor
      },
      {
        "department": "billing",
        "title": "Billing Support",
        "phone": "+1 (555) 123-4569",
        "email": "billing@company.com",
        "hours": "Mon-Fri: 8AM-8PM EST",
        "language": "English",
        "color": warningColor
      },
      {
        "department": "sales",
        "title": "Sales Inquiries",
        "phone": "+1 (555) 123-4570",
        "email": "sales@company.com",
        "hours": "Mon-Fri: 9AM-7PM EST",
        "language": "English",
        "color": successColor
      }
    ],
    "UK": [
      {
        "department": "general",
        "title": "General Support",
        "phone": "+44 20 7123 4567",
        "email": "support.uk@company.com",
        "hours": "Mon-Fri: 9AM-6PM GMT",
        "language": "English",
        "color": primaryColor
      },
      {
        "department": "technical",
        "title": "Technical Support",
        "phone": "+44 20 7123 4568",
        "email": "tech.uk@company.com",
        "hours": "Mon-Sun: 8AM-10PM GMT",
        "language": "English",
        "color": dangerColor
      }
    ],
    "CA": [
      {
        "department": "general",
        "title": "General Support",
        "phone": "+1 (416) 123-4567",
        "email": "support.ca@company.com",
        "hours": "Mon-Fri: 9AM-6PM EST",
        "language": "English, French",
        "color": primaryColor
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredContacts = (contactInfo[selectedRegion] ?? [])
        .where((contact) => selectedDepartment == "all" || contact["department"] == selectedDepartment)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Support"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Section
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phone Support",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Speak directly with our support team",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Available 24/7",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spMd),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.language,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Multi-language",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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

            // Filters
            Text(
              "Select Your Region",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QDropdownField(
              label: "Region/Country",
              items: regions,
              value: selectedRegion,
              onChanged: (value, label) {
                selectedRegion = value;
                setState(() {});
              },
            ),

            QDropdownField(
              label: "Department",
              items: departments,
              value: selectedDepartment,
              onChanged: (value, label) {
                selectedDepartment = value;
                setState(() {});
              },
            ),

            // Contact Cards
            Text(
              "Contact Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            if (filteredContacts.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd * 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.phone_disabled,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No phone support available",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try selecting a different region or use our other support channels",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Live Chat",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo(LiveChatView());
                      },
                    ),
                  ],
                ),
              )
            else
              ...filteredContacts.map((contact) => Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: contact["color"] as Color,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: (contact["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              _getDepartmentIcon(contact["department"]),
                              color: contact["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${contact["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${contact["language"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: contact["color"] as Color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Available",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Contact Details
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          spacing: spMd,
                          children: [
                            // Phone Number
                            GestureDetector(
                              onTap: () {
                                _makePhoneCall(contact["phone"]);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: contact["color"] as Color,
                                    size: 20,
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Phone Number",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${contact["phone"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: contact["color"] as Color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.call,
                                    color: contact["color"] as Color,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                            
                            // Email
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: contact["color"] as Color,
                                  size: 20,
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email Address",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${contact["email"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            // Hours
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: contact["color"] as Color,
                                  size: 20,
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Support Hours",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${contact["hours"]}",
                                        style: TextStyle(
                                          fontSize: 14,
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
                      
                      SizedBox(height: spMd),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Call Now",
                              size: bs.sm,
                              onPressed: () {
                                _makePhoneCall(contact["phone"]);
                              },
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: contact["color"] as Color,
                                  width: 1,
                                ),
                              ),
                              child: QButton(
                                label: "Send Email",
                                size: bs.sm,
                                onPressed: () {
                                  _sendEmail(contact["email"]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )).toList(),

            // Emergency Contact
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: dangerColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emergency,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Emergency Support",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "For critical issues affecting your business operations, call our emergency hotline:",
                    style: TextStyle(
                      fontSize: 14,
                      color: dangerColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "+1 (555) 911-HELP",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Call Emergency",
                        size: bs.sm,
                        onPressed: () {
                          _makePhoneCall("+1 (555) 911-4357");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Alternative Support
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Other Support Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // navigateTo(LiveChatView());
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.chat,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Live Chat",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Instant messaging",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // navigateTo(TicketSystemView());
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.confirmation_number,
                                  color: infoColor,
                                  size: 24,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Support Ticket",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "Track your issues",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }

  IconData _getDepartmentIcon(String department) {
    switch (department) {
      case 'general':
        return Icons.support_agent;
      case 'technical':
        return Icons.build;
      case 'billing':
        return Icons.payment;
      case 'sales':
        return Icons.sell;
      default:
        return Icons.phone;
    }
  }

  void _makePhoneCall(String phoneNumber) {
    ss("Calling $phoneNumber...");
    // In a real app, you would use url_launcher to make the actual call
    // launch("tel:$phoneNumber");
  }

  void _sendEmail(String email) {
    ss("Opening email to $email...");
    // In a real app, you would use url_launcher to open email
    // launch("mailto:$email");
  }
}
