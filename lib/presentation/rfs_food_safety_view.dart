import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsFoodSafetyView extends StatefulWidget {
  const RfsFoodSafetyView({super.key});

  @override
  State<RfsFoodSafetyView> createState() => _RfsFoodSafetyViewState();
}

class _RfsFoodSafetyViewState extends State<RfsFoodSafetyView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedRiskLevel = "All";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Temperature", "value": "Temperature"},
    {"label": "Hygiene", "value": "Hygiene"},
    {"label": "Storage", "value": "Storage"},
    {"label": "Cross Contamination", "value": "Cross Contamination"},
    {"label": "Expiry", "value": "Expiry"},
  ];

  List<Map<String, dynamic>> riskOptions = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  List<Map<String, dynamic>> safetyIncidents = [
    {
      "id": "FS001",
      "title": "Temperature Deviation - Freezer Unit",
      "category": "Temperature",
      "riskLevel": "High",
      "status": "Active",
      "reportedBy": "Chef Marco",
      "reportTime": "2025-06-19T14:30:00",
      "location": "Cold Storage Section B",
      "description": "Freezer temperature rose to 8°F, exceeding safe limit of 5°F",
      "affectedItems": ["Frozen Vegetables", "Ice Cream", "Frozen Meat"],
      "actionTaken": "Maintenance called, items moved to backup freezer",
      "priority": "urgent",
      "estimatedLoss": 250.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=freezer"
    },
    {
      "id": "FS002",
      "title": "Handwashing Station Empty",
      "category": "Hygiene",
      "riskLevel": "Medium",
      "status": "Resolved",
      "reportedBy": "Staff Anna",
      "reportTime": "2025-06-19T13:15:00",
      "location": "Kitchen Station 2",
      "description": "Soap dispenser empty and no paper towels available",
      "affectedItems": ["Kitchen Staff", "Food Prep Area"],
      "actionTaken": "Refilled dispenser and restocked towels",
      "priority": "medium",
      "estimatedLoss": 0.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=handwashing"
    },
    {
      "id": "FS003",
      "title": "Raw Meat Storage Violation",
      "category": "Cross Contamination",
      "riskLevel": "Critical",
      "status": "Under Investigation",
      "reportedBy": "Health Inspector",
      "reportTime": "2025-06-19T12:00:00",
      "location": "Walk-in Refrigerator",
      "description": "Raw chicken stored above ready-to-eat vegetables",
      "affectedItems": ["Fresh Vegetables", "Salad Ingredients"],
      "actionTaken": "All vegetables discarded, storage reorganized",
      "priority": "critical",
      "estimatedLoss": 180.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=storage"
    },
    {
      "id": "FS004",
      "title": "Expired Dairy Products Found",
      "category": "Expiry",
      "riskLevel": "High",
      "status": "Active",
      "reportedBy": "Chef Maria",
      "reportTime": "2025-06-19T11:30:00",
      "location": "Dairy Storage",
      "description": "Multiple dairy products found expired by 2 days",
      "affectedItems": ["Milk", "Cheese", "Yogurt"],
      "actionTaken": "Items disposed, supplier contacted",
      "priority": "high",
      "estimatedLoss": 120.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=dairy"
    },
    {
      "id": "FS005",
      "title": "Cleaning Chemical Spill",
      "category": "Hygiene",
      "riskLevel": "Medium",
      "status": "Resolved",
      "reportedBy": "Janitor Tom",
      "reportTime": "2025-06-19T10:45:00",
      "location": "Storage Room",
      "description": "Sanitizer bottle leaked onto floor near food storage",
      "affectedItems": ["Floor Area", "Nearby Containers"],
      "actionTaken": "Area cleaned and sanitized, containers checked",
      "priority": "medium",
      "estimatedLoss": 25.0,
      "image": "https://picsum.photos/300/200?random=5&keyword=cleaning"
    },
  ];

  List<Map<String, dynamic>> get filteredIncidents {
    return safetyIncidents.where((incident) {
      bool matchesSearch = "${incident["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${incident["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || incident["category"] == selectedCategory;
      bool matchesRisk = selectedRiskLevel == "All" || incident["riskLevel"] == selectedRiskLevel;
      
      return matchesSearch && matchesCategory && matchesRisk;
    }).toList();
  }

  Color getRiskColor(String riskLevel) {
    switch (riskLevel) {
      case "Low": return successColor;
      case "Medium": return warningColor;
      case "High": return dangerColor;
      case "Critical": return Color(0xFF8B0000);
      default: return disabledColor;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Resolved": return successColor;
      case "Active": return warningColor;
      case "Under Investigation": return infoColor;
      default: return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Safety"),
        actions: [
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.warning),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Safety Incidents",
                    value: searchQuery,
                    hint: "Search by title or ID...",
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

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
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
                    label: "Risk Level",
                    items: riskOptions,
                    value: selectedRiskLevel,
                    onChanged: (value, label) {
                      selectedRiskLevel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Statistics Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.warning, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${safetyIncidents.where((incident) => incident["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
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
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${safetyIncidents.where((incident) => incident["status"] == "Resolved").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Resolved",
                          style: TextStyle(
                            fontSize: 12,
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
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.search, color: infoColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${safetyIncidents.where((incident) => incident["status"] == "Under Investigation").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Under Review",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Total Loss Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.monetization_on, color: warningColor, size: 24),
                  SizedBox(width: spSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Estimated Loss",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${((safetyIncidents.map((i) => i["estimatedLoss"] as double).reduce((a, b) => a + b)).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Safety Incidents List
            ...filteredIncidents.map((incident) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getRiskColor("${incident["riskLevel"]}"),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          bottomLeft: Radius.circular(radiusMd),
                        ),
                        child: Image.network(
                          "${incident["image"]}",
                          width: 100,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${incident["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: getRiskColor("${incident["riskLevel"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: getRiskColor("${incident["riskLevel"]}").withAlpha(100),
                                      ),
                                    ),
                                    child: Text(
                                      "${incident["riskLevel"]} Risk",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getRiskColor("${incident["riskLevel"]}"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: getStatusColor("${incident["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      border: Border.all(
                                        color: getStatusColor("${incident["status"]}").withAlpha(100),
                                      ),
                                    ),
                                    child: Text(
                                      "${incident["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: getStatusColor("${incident["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${incident["id"]} • ${incident["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${incident["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "${incident["location"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Affected Items Section
                  if ((incident["affectedItems"] as List).isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(10),
                        border: Border(
                          top: BorderSide(color: disabledOutlineBorderColor),
                          bottom: BorderSide(color: disabledOutlineBorderColor),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Affected Items:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: 4,
                            children: (incident["affectedItems"] as List).map((item) => Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: dangerColor.withAlpha(50)),
                              ),
                              child: Text(
                                "$item",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: dangerColor,
                                ),
                              ),
                            )).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusMd),
                        bottomRight: Radius.circular(radiusMd),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_outline, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${incident["reportedBy"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              DateTime.parse("${incident["reportTime"]}").dMMMy,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if ((incident["estimatedLoss"] as double) > 0) ...[
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.monetization_on, size: 16, color: warningColor),
                              SizedBox(width: spXs),
                              Text(
                                "Loss: \$${((incident["estimatedLoss"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ] else ...[
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Spacer(),
                              QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        child: Icon(Icons.report_problem, color: Colors.white),
      ),
    );
  }
}
