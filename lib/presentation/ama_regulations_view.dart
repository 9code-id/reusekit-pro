import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaRegulationsView extends StatefulWidget {
  const AmaRegulationsView({super.key});

  @override
  State<AmaRegulationsView> createState() => _AmaRegulationsViewState();
}

class _AmaRegulationsViewState extends State<AmaRegulationsView> {
  List regulations = [
    {
      "id": 1,
      "title": "Organic Farming Standards",
      "category": "Organic",
      "description": "Guidelines for organic crop production and certification requirements",
      "effective_date": "2024-01-01",
      "status": "Active",
      "compliance_level": "Mandatory",
      "authority": "National Organic Standards Board",
      "last_updated": "2024-01-15",
      "color": successColor,
      "icon": Icons.eco,
    },
    {
      "id": 2,
      "title": "Pesticide Usage Regulations",
      "category": "Pesticides",
      "description": "Approved pesticides list and application guidelines for food crops",
      "effective_date": "2023-06-01",
      "status": "Active",
      "compliance_level": "Mandatory",
      "authority": "Environmental Protection Agency",
      "last_updated": "2024-01-10",
      "color": dangerColor,
      "icon": Icons.warning,
    },
    {
      "id": 3,
      "title": "Water Quality Standards",
      "category": "Water",
      "description": "Irrigation water quality requirements and testing protocols",
      "effective_date": "2023-03-15",
      "status": "Active",
      "compliance_level": "Recommended",
      "authority": "Water Resources Department",
      "last_updated": "2023-12-20",
      "color": infoColor,
      "icon": Icons.water_drop,
    },
    {
      "id": 4,
      "title": "Soil Conservation Practices",
      "category": "Soil",
      "description": "Mandatory soil erosion prevention and conservation methods",
      "effective_date": "2023-09-01",
      "status": "Active",
      "compliance_level": "Mandatory",
      "authority": "Soil Conservation Service",
      "last_updated": "2023-11-30",
      "color": warningColor,
      "icon": Icons.landscape,
    },
    {
      "id": 5,
      "title": "GMO Labeling Requirements",
      "category": "GMO",
      "description": "Genetically modified organism identification and labeling standards",
      "effective_date": "2024-03-01",
      "status": "Pending",
      "compliance_level": "Mandatory",
      "authority": "Food Safety Authority",
      "last_updated": "2024-01-05",
      "color": primaryColor,
      "icon": Icons.science,
    },
    {
      "id": 6,
      "title": "Farm Worker Safety",
      "category": "Safety",
      "description": "Workplace safety standards and protective equipment requirements",
      "effective_date": "2023-01-01",
      "status": "Active",
      "compliance_level": "Mandatory",
      "authority": "Occupational Safety Authority",
      "last_updated": "2023-12-15",
      "color": secondaryColor,
      "icon": Icons.safety_check,
    },
  ];

  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedCompliance = "All";
  
  List<String> categories = ["All", "Organic", "Pesticides", "Water", "Soil", "GMO", "Safety"];
  List<String> statuses = ["All", "Active", "Pending", "Expired"];
  List<String> complianceLevels = ["All", "Mandatory", "Recommended", "Optional"];

  @override
  Widget build(BuildContext context) {
    List filteredRegulations = regulations.where((reg) {
      bool categoryMatch = selectedCategory == "All" || reg["category"] == selectedCategory;
      bool statusMatch = selectedStatus == "All" || reg["status"] == selectedStatus;
      bool complianceMatch = selectedCompliance == "All" || reg["compliance_level"] == selectedCompliance;
      return categoryMatch && statusMatch && complianceMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Agricultural Regulations"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search regulations
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Show regulation updates
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Compliance Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.gavel,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Compliance Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${regulations.where((r) => r["status"] == "Active").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Active Regulations",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${regulations.where((r) => r["compliance_level"] == "Mandatory").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Mandatory Rules",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
            
            SizedBox(height: spLg),
            
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Compliance Check",
                    icon: Icons.checklist,
                    size: bs.sm,
                    onPressed: () {
                      // Run compliance check
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Subscribe Updates",
                    icon: Icons.notifications_active,
                    size: bs.sm,
                    onPressed: () {
                      // Subscribe to regulation updates
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filters
            Text(
              "Filter Regulations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories.map((cat) => {
                          "label": cat,
                          "value": cat,
                        }).toList(),
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
                        label: "Status",
                        items: statuses.map((status) => {
                          "label": status,
                          "value": status,
                        }).toList(),
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Compliance Level",
                  items: complianceLevels.map((level) => {
                    "label": level,
                    "value": level,
                  }).toList(),
                  value: selectedCompliance,
                  onChanged: (value, label) {
                    selectedCompliance = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Regulations List
            Text(
              "Regulations (${filteredRegulations.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredRegulations.length,
              itemBuilder: (context, index) {
                final regulation = filteredRegulations[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: regulation["color"] as Color,
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
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (regulation["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                regulation["icon"] as IconData,
                                color: regulation["color"] as Color,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${regulation["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: regulation["status"] == "Active" 
                                              ? successColor.withAlpha(20)
                                              : warningColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${regulation["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: regulation["status"] == "Active" ? successColor : warningColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: regulation["compliance_level"] == "Mandatory" 
                                              ? dangerColor.withAlpha(20)
                                              : infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${regulation["compliance_level"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: regulation["compliance_level"] == "Mandatory" ? dangerColor : infoColor,
                                            fontWeight: FontWeight.w600,
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
                        
                        SizedBox(height: spSm),
                        
                        // Description
                        Text(
                          "${regulation["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Details
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Effective: ${regulation["effective_date"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.update,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Updated: ${regulation["last_updated"]}",
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
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_balance,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "Authority: ${regulation["authority"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // View regulation details
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Download",
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {
                                // Download regulation document
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
