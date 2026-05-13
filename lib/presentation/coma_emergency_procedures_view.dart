import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaEmergencyProceduresView extends StatefulWidget {
  const ComaEmergencyProceduresView({super.key});

  @override
  State<ComaEmergencyProceduresView> createState() => _ComaEmergencyProceduresViewState();
}

class _ComaEmergencyProceduresViewState extends State<ComaEmergencyProceduresView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedSeverity = "All";
  bool showFavorites = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Fire Safety", "value": "Fire Safety"},
    {"label": "Medical Emergency", "value": "Medical Emergency"},
    {"label": "Structural Collapse", "value": "Structural Collapse"},
    {"label": "Chemical Spill", "value": "Chemical Spill"},
    {"label": "Electrical Hazard", "value": "Electrical Hazard"},
    {"label": "Equipment Failure", "value": "Equipment Failure"},
    {"label": "Weather Emergency", "value": "Weather Emergency"},
  ];

  List<Map<String, dynamic>> severityLevels = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> emergencyProcedures = [
    {
      "id": "EP001",
      "title": "Fire Emergency Response",
      "category": "Fire Safety",
      "severity": "Critical",
      "description": "Immediate response protocol for fire incidents on construction sites",
      "steps": [
        "Sound the alarm immediately",
        "Call emergency services (911)",
        "Evacuate all personnel to designated assembly point",
        "Use fire extinguishers only if safe to do so",
        "Account for all personnel at assembly point",
        "Do not re-enter building until cleared by fire department"
      ],
      "contacts": [
        {"name": "Fire Department", "phone": "911"},
        {"name": "Site Safety Officer", "phone": "(555) 123-4567"},
        {"name": "Project Manager", "phone": "(555) 234-5678"}
      ],
      "lastUpdated": "2024-01-15",
      "isFavorite": true,
      "estimatedTime": "5-10 minutes",
      "requiredEquipment": ["Fire extinguisher", "Emergency radio", "First aid kit"]
    },
    {
      "id": "EP002", 
      "title": "Medical Emergency Protocol",
      "category": "Medical Emergency",
      "severity": "Critical",
      "description": "Response procedures for workplace injuries and medical emergencies",
      "steps": [
        "Assess the scene for safety hazards",
        "Call 911 for serious injuries",
        "Provide first aid within your training limits",
        "Do not move injured person unless necessary",
        "Keep injured person calm and comfortable",
        "Document incident details immediately"
      ],
      "contacts": [
        {"name": "Emergency Services", "phone": "911"},
        {"name": "Safety Coordinator", "phone": "(555) 345-6789"},
        {"name": "HR Department", "phone": "(555) 456-7890"}
      ],
      "lastUpdated": "2024-01-20",
      "isFavorite": false,
      "estimatedTime": "Immediate",
      "requiredEquipment": ["First aid kit", "AED device", "Emergency blanket"]
    },
    {
      "id": "EP003",
      "title": "Structural Collapse Response",
      "category": "Structural Collapse", 
      "severity": "Critical",
      "description": "Emergency response for structural failures and collapse incidents",
      "steps": [
        "Evacuate area immediately - minimum 50ft radius",
        "Call emergency services and structural engineers",
        "Account for all personnel",
        "Secure the perimeter to prevent entry",
        "Turn off utilities if safe to access",
        "Document damage with photos if safe"
      ],
      "contacts": [
        {"name": "Emergency Services", "phone": "911"},
        {"name": "Structural Engineer", "phone": "(555) 567-8901"},
        {"name": "Site Supervisor", "phone": "(555) 678-9012"}
      ],
      "lastUpdated": "2024-01-10",
      "isFavorite": true,
      "estimatedTime": "2-5 minutes",
      "requiredEquipment": ["Barricade tape", "Emergency radio", "Hard hats"]
    },
    {
      "id": "EP004",
      "title": "Chemical Spill Containment",
      "category": "Chemical Spill",
      "severity": "High",
      "description": "Procedures for containing and cleaning up hazardous chemical spills",
      "steps": [
        "Identify the chemical and assess hazard level",
        "Evacuate area and establish safety perimeter",
        "Notify emergency services if required",
        "Use appropriate PPE before containment",
        "Contain spill using absorbent materials",
        "Dispose of contaminated materials properly"
      ],
      "contacts": [
        {"name": "Hazmat Team", "phone": "(555) 789-0123"},
        {"name": "Environmental Safety", "phone": "(555) 890-1234"},
        {"name": "Site Safety Officer", "phone": "(555) 123-4567"}
      ],
      "lastUpdated": "2024-01-25",
      "isFavorite": false,
      "estimatedTime": "15-30 minutes",
      "requiredEquipment": ["Spill kit", "PPE", "Absorbent materials", "Disposal containers"]
    },
    {
      "id": "EP005",
      "title": "Electrical Emergency Response",
      "category": "Electrical Hazard",
      "severity": "High",
      "description": "Safety procedures for electrical incidents and power failures",
      "steps": [
        "Do not touch person in contact with electricity",
        "Turn off power at main breaker if accessible",
        "Call emergency services immediately",
        "Use non-conductive materials to separate victim",
        "Begin CPR if trained and victim is unconscious",
        "Secure area until electrical hazard is eliminated"
      ],
      "contacts": [
        {"name": "Emergency Services", "phone": "911"},
        {"name": "Licensed Electrician", "phone": "(555) 901-2345"},
        {"name": "Utility Company", "phone": "(555) 012-3456"}
      ],
      "lastUpdated": "2024-01-18",
      "isFavorite": true,
      "estimatedTime": "Immediate",
      "requiredEquipment": ["Non-conductive materials", "First aid kit", "Flashlight"]
    },
    {
      "id": "EP006",
      "title": "Equipment Failure Protocol",
      "category": "Equipment Failure",
      "severity": "Medium",
      "description": "Response procedures for major equipment failures and malfunctions",
      "steps": [
        "Shut down equipment immediately",
        "Secure the work area",
        "Tag out equipment - DO NOT OPERATE",
        "Notify maintenance and supervision",
        "Document failure details and circumstances",
        "Arrange for professional inspection"
      ],
      "contacts": [
        {"name": "Maintenance Supervisor", "phone": "(555) 234-5678"},
        {"name": "Equipment Manufacturer", "phone": "(555) 345-6789"},
        {"name": "Site Manager", "phone": "(555) 456-7890"}
      ],
      "lastUpdated": "2024-01-22",
      "isFavorite": false,
      "estimatedTime": "5-15 minutes",
      "requiredEquipment": ["Lockout/tagout materials", "Barricade tape", "Documentation forms"]
    }
  ];

  List<Map<String, dynamic>> get filteredProcedures {
    return emergencyProcedures.where((procedure) {
      bool matchesSearch = searchQuery.isEmpty ||
          (procedure["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (procedure["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || procedure["category"] == selectedCategory;
      bool matchesSeverity = selectedSeverity == "All" || procedure["severity"] == selectedSeverity;
      bool matchesFavorites = !showFavorites || (procedure["isFavorite"] as bool);
      
      return matchesSearch && matchesCategory && matchesSeverity && matchesFavorites;
    }).toList();
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showProcedureDetails(Map<String, dynamic> procedure) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getSeverityColor(procedure["severity"] as String),
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${procedure["title"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${procedure["category"]} • ${procedure["severity"]} Priority",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => back(),
                    icon: Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${procedure["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Procedure Steps
                    Text(
                      "Emergency Steps",
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
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spLg),
                    
                    // Emergency Contacts
                    Text(
                      "Emergency Contacts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(procedure["contacts"] as List).map((contact) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.phone, color: primaryColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${contact["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${contact["phone"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.call,
                              size: bs.sm,
                              onPressed: () {
                                // Call contact
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: spLg),
                    
                    // Additional Information
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Estimated Time",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "${procedure["estimatedTime"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Updated",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${procedure["lastUpdated"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Required Equipment
                    Text(
                      "Required Equipment",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (procedure["requiredEquipment"] as List).map((equipment) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: warningColor.withAlpha(100)),
                          ),
                          child: Text(
                            "$equipment",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
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

  void _toggleFavorite(String procedureId) {
    int index = emergencyProcedures.indexWhere((p) => p["id"] == procedureId);
    if (index != -1) {
      emergencyProcedures[index]["isFavorite"] = !(emergencyProcedures[index]["isFavorite"] as bool);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Procedures"),
        actions: [
          IconButton(
            onPressed: () {
              // Add new emergency procedure
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search procedures...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    _showFilterDialog();
                  },
                ),
              ],
            ),
            
            // Quick Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Severity",
                    items: severityLevels,
                    value: selectedSeverity,
                    onChanged: (value, label) {
                      selectedSeverity = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Show Favorites Toggle
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show Favorites Only",
                        "value": true,
                        "checked": showFavorites,
                      }
                    ],
                    value: [if (showFavorites) {"label": "Show Favorites Only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showFavorites = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${emergencyProcedures.where((p) => p["severity"] == "Critical").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Critical",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${emergencyProcedures.where((p) => p["severity"] == "High").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "High Priority",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${emergencyProcedures.where((p) => p["isFavorite"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Favorites",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Emergency Procedures List
            Text(
              "Emergency Procedures (${filteredProcedures.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            if (filteredProcedures.isEmpty)
              Container(
                padding: EdgeInsets.all(sp2xl),
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
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredProcedures.map((procedure) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getSeverityColor(procedure["severity"] as String).withAlpha(20),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getSeverityColor(procedure["severity"] as String),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${procedure["severity"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${procedure["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _toggleFavorite(procedure["id"] as String),
                              icon: Icon(
                                (procedure["isFavorite"] as bool) ? Icons.favorite : Icons.favorite_border,
                                color: (procedure["isFavorite"] as bool) ? dangerColor : disabledColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${procedure["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${procedure["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.schedule, size: 16, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${procedure["estimatedTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${(procedure["steps"] as List).length} steps",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "View Procedure",
                                size: bs.sm,
                                onPressed: () => _showProcedureDetails(procedure),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Procedures"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Category",
              items: categories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Severity Level",
              items: severityLevels,
              value: selectedSeverity,
              onChanged: (value, label) {
                selectedSeverity = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedCategory = "All";
              selectedSeverity = "All";
              showFavorites = false;
              setState(() {});
              back();
            },
            child: Text("Clear All"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}
