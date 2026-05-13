import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaEmergencyView extends StatefulWidget {
  const DlaEmergencyView({Key? key}) : super(key: key);

  @override
  State<DlaEmergencyView> createState() => _DlaEmergencyViewState();
}

class _DlaEmergencyViewState extends State<DlaEmergencyView> {
  String searchQuery = "";

  List<Map<String, dynamic>> emergencyContacts = [
    {
      "id": "EC001",
      "name": "Emergency Dispatch Center",
      "department": "Operations",
      "phone": "+1 234 567 8900",
      "email": "dispatch@delivery.com",
      "type": "Primary",
      "available": "24/7",
      "priority": "Critical",
      "description": "Main emergency coordination center for all delivery operations",
    },
    {
      "id": "EC002",
      "name": "Regional Manager",
      "department": "Management",
      "phone": "+1 234 567 8901",
      "email": "manager@delivery.com",
      "type": "Secondary",
      "available": "6 AM - 10 PM",
      "priority": "High",
      "description": "Regional oversight and major incident resolution",
    },
    {
      "id": "EC003",
      "name": "Security Operations",
      "department": "Security",
      "phone": "+1 234 567 8902",
      "email": "security@delivery.com",
      "type": "Primary",
      "available": "24/7",
      "priority": "Critical",
      "description": "Security incidents, theft, and safety emergencies",
    },
    {
      "id": "EC004",
      "name": "Medical Emergency",
      "department": "Health & Safety",
      "phone": "911",
      "email": "emergency@health.gov",
      "type": "External",
      "available": "24/7",
      "priority": "Critical",
      "description": "Medical emergencies and health-related incidents",
    },
    {
      "id": "EC005",
      "name": "Vehicle Breakdown Support",
      "department": "Fleet",
      "phone": "+1 234 567 8903",
      "email": "fleet@delivery.com",
      "type": "Primary",
      "available": "24/7",
      "priority": "High",
      "description": "Vehicle breakdowns, accidents, and mechanical issues",
    },
  ];

  List<Map<String, dynamic>> emergencyProcedures = [
    {
      "id": "EP001",
      "title": "Vehicle Accident",
      "category": "Safety",
      "priority": "Critical",
      "steps": [
        "Ensure personal safety first - move to a safe location",
        "Check for injuries and call 911 if medical attention needed",
        "Contact Emergency Dispatch immediately at +1 234 567 8900",
        "Document the scene with photos if safe to do so",
        "Exchange information with other parties involved",
        "Do not admit fault or discuss details with anyone except authorities",
        "Wait for police report and emergency response team",
        "Follow company incident reporting procedures",
      ],
      "contacts": ["Emergency Dispatch Center", "Security Operations"],
      "estimatedTime": "Immediate",
    },
    {
      "id": "EP002",
      "title": "Package Theft",
      "category": "Security",
      "priority": "High",
      "steps": [
        "Ensure your personal safety - do not confront perpetrators",
        "Note description of suspect(s) and vehicle if applicable",
        "Contact Security Operations immediately",
        "Report to local police if theft is in progress or just occurred",
        "Document all missing packages and their tracking numbers",
        "Inform customers about the theft and expected resolution time",
        "Complete incident report in company system",
        "Follow up with insurance claims if necessary",
      ],
      "contacts": ["Security Operations", "Emergency Dispatch Center"],
      "estimatedTime": "Within 30 minutes",
    },
    {
      "id": "EP003",
      "title": "Vehicle Breakdown",
      "category": "Operations",
      "priority": "Medium",
      "steps": [
        "Pull over safely and turn on hazard lights",
        "Contact Vehicle Breakdown Support immediately",
        "Provide your exact location and vehicle identification",
        "Secure all packages in the vehicle",
        "Wait for roadside assistance or replacement vehicle",
        "Inform dispatch about delivery delays",
        "Transfer packages to replacement vehicle if needed",
        "Complete vehicle incident report",
      ],
      "contacts": ["Vehicle Breakdown Support", "Emergency Dispatch Center"],
      "estimatedTime": "Within 1 hour",
    },
    {
      "id": "EP004",
      "title": "Severe Weather",
      "category": "Safety",
      "priority": "High",
      "steps": [
        "Monitor weather conditions and alerts continuously",
        "Seek immediate shelter in safe building or vehicle",
        "Contact Emergency Dispatch for route guidance",
        "Postpone deliveries if conditions are unsafe",
        "Keep emergency kit accessible (water, flashlight, first aid)",
        "Stay in communication with dispatch every 30 minutes",
        "Document weather-related delays and damages",
        "Resume operations only when conditions are safe",
      ],
      "contacts": ["Emergency Dispatch Center", "Regional Manager"],
      "estimatedTime": "Duration of weather event",
    },
  ];

  List<Map<String, dynamic>> get filteredContacts {
    if (searchQuery.isEmpty) return emergencyContacts;
    
    return emergencyContacts.where((contact) {
      return "${contact["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${contact["department"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${contact["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  List<Map<String, dynamic>> get filteredProcedures {
    if (searchQuery.isEmpty) return emergencyProcedures;
    
    return emergencyProcedures.where((procedure) {
      return "${procedure["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${procedure["category"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      default:
        return successColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Primary":
        return primaryColor;
      case "Secondary":
        return infoColor;
      case "External":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  void _makeCall(String phone, String name) {
    if (phone == "911") {
      ss("Calling Emergency Services (911)");
    } else {
      ss("Calling $name at $phone");
    }
  }

  void _sendEmail(String email, String name) {
    ss("Opening email to $name ($email)");
  }

  void _showProcedureDetails(Map<String, dynamic> procedure) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${procedure["title"]} Procedure",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: disabledBoldColor),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: _getPriorityColor("${procedure["priority"]}").withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: _getPriorityColor("${procedure["priority"]}"),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.priority_high,
                    color: _getPriorityColor("${procedure["priority"]}"),
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${procedure["priority"]} Priority - ${procedure["category"]}",
                    style: TextStyle(
                      color: _getPriorityColor("${procedure["priority"]}"),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Step-by-Step Instructions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(procedure["steps"] as List).asMap().entries.map((entry) {
                      int index = entry.key;
                      String step = entry.value;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                step,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spLg),
                    Text(
                      "Emergency Contacts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(procedure["contacts"] as List).map((contactName) {
                      final contact = emergencyContacts.firstWhere(
                        (c) => c["name"] == contactName,
                        orElse: () => {"name": contactName, "phone": "N/A"},
                      );
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${contact["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            if (contact["phone"] != "N/A")
                              QButton(
                                icon: Icons.phone,
                                size: bs.sm,
                                onPressed: () => _makeCall("${contact["phone"]}", "${contact["name"]}"),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spLg),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Expected Response Time: ${procedure["estimatedTime"]}",
                              style: TextStyle(
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Emergency Center",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Contacts", icon: Icon(Icons.contacts)),
        Tab(text: "Procedures", icon: Icon(Icons.list_alt)),
      ],
      tabChildren: [
        _buildContactsTab(),
        _buildProceduresTab(),
      ],
    );
  }

  Widget _buildContactsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QTextField(
            label: "Search emergency contacts...",
            value: searchQuery,
            hint: "Name, department, or description",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: dangerColor),
            ),
            child: Row(
              children: [
                Icon(Icons.emergency, color: dangerColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Emergency contacts are available 24/7. Call immediately for urgent situations.",
                    style: TextStyle(
                      color: dangerColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          ...filteredContacts.map((contact) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getPriorityColor("${contact["priority"]}"),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${contact["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getTypeColor("${contact["type"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${contact["type"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getTypeColor("${contact["type"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${contact["department"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getPriorityColor("${contact["priority"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${contact["priority"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: _getPriorityColor("${contact["priority"]}"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${contact["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: successColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Available: ${contact["available"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${contact["phone"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () => _makeCall("${contact["phone"]}", "${contact["name"]}"),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.email,
                      size: bs.sm,
                      onPressed: () => _sendEmail("${contact["email"]}", "${contact["name"]}"),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
          if (filteredContacts.isEmpty)
            Container(
              width: double.infinity,
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
                    "No contacts found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Try adjusting your search terms",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProceduresTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QTextField(
            label: "Search procedures...",
            value: searchQuery,
            hint: "Procedure title or category",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Follow these procedures step-by-step during emergency situations.",
                    style: TextStyle(
                      color: infoColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          ...filteredProcedures.map((procedure) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getPriorityColor("${procedure["priority"]}"),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${procedure["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${procedure["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getPriorityColor("${procedure["priority"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${procedure["priority"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: _getPriorityColor("${procedure["priority"]}"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${(procedure["steps"] as List).length} steps",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Response time: ${procedure["estimatedTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Procedure",
                    icon: Icons.list_alt,
                    size: bs.sm,
                    onPressed: () => _showProcedureDetails(procedure),
                  ),
                ),
              ],
            ),
          )).toList(),
          if (filteredProcedures.isEmpty)
            Container(
              width: double.infinity,
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
                    "No procedures found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Try adjusting your search terms",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
