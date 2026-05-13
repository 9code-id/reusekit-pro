import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaReportingHierarchyView extends StatefulWidget {
  const RhaReportingHierarchyView({super.key});

  @override
  State<RhaReportingHierarchyView> createState() => _RhaReportingHierarchyViewState();
}

class _RhaReportingHierarchyViewState extends State<RhaReportingHierarchyView> {
  String selectedEmployee = "john_doe";
  String viewMode = "hierarchy";

  List<Map<String, dynamic>> employees = [
    {"label": "John Doe - Software Engineer", "value": "john_doe"},
    {"label": "Sarah Chen - Engineering Manager", "value": "sarah_chen"},
    {"label": "Mike Rodriguez - Senior Developer", "value": "mike_rodriguez"},
    {"label": "Emily Davis - Frontend Developer", "value": "emily_davis"},
    {"label": "David Kim - Product Manager", "value": "david_kim"},
    {"label": "Jessica Brown - Design Lead", "value": "jessica_brown"},
  ];

  Map<String, dynamic> hierarchyData = {
    "john_doe": {
      "id": "john_doe",
      "name": "John Doe",
      "position": "Software Engineer",
      "department": "Engineering",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=developer",
      "email": "john.doe@company.com",
      "level": 4,
      "manager": {
        "id": "sarah_chen",
        "name": "Sarah Chen",
        "position": "Engineering Manager",
        "avatar": "https://picsum.photos/80/80?random=2&keyword=manager",
        "email": "sarah.chen@company.com",
        "level": 3,
        "manager": {
          "id": "cto",
          "name": "Alex Johnson",
          "position": "Chief Technology Officer",
          "avatar": "https://picsum.photos/80/80?random=3&keyword=cto",
          "email": "alex.johnson@company.com",
          "level": 2,
          "manager": {
            "id": "ceo",
            "name": "Michael Smith",
            "position": "Chief Executive Officer",
            "avatar": "https://picsum.photos/80/80?random=4&keyword=ceo",
            "email": "michael.smith@company.com",
            "level": 1,
            "manager": null
          }
        }
      },
      "direct_reports": [],
      "peers": [
        {
          "id": "mike_rodriguez",
          "name": "Mike Rodriguez",
          "position": "Senior Developer",
          "avatar": "https://picsum.photos/80/80?random=5&keyword=senior",
          "email": "mike.rodriguez@company.com"
        },
        {
          "id": "emily_davis",
          "name": "Emily Davis",
          "position": "Frontend Developer",
          "avatar": "https://picsum.photos/80/80?random=6&keyword=frontend",
          "email": "emily.davis@company.com"
        }
      ]
    },
    "sarah_chen": {
      "id": "sarah_chen",
      "name": "Sarah Chen",
      "position": "Engineering Manager",
      "department": "Engineering",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=manager",
      "email": "sarah.chen@company.com",
      "level": 3,
      "manager": {
        "id": "cto",
        "name": "Alex Johnson",
        "position": "Chief Technology Officer",
        "avatar": "https://picsum.photos/80/80?random=3&keyword=cto",
        "email": "alex.johnson@company.com",
        "level": 2,
        "manager": {
          "id": "ceo",
          "name": "Michael Smith",
          "position": "Chief Executive Officer",
          "avatar": "https://picsum.photos/80/80?random=4&keyword=ceo",
          "email": "michael.smith@company.com",
          "level": 1,
          "manager": null
        }
      },
      "direct_reports": [
        {
          "id": "john_doe",
          "name": "John Doe",
          "position": "Software Engineer",
          "avatar": "https://picsum.photos/80/80?random=1&keyword=developer",
          "email": "john.doe@company.com"
        },
        {
          "id": "mike_rodriguez",
          "name": "Mike Rodriguez",
          "position": "Senior Developer",
          "avatar": "https://picsum.photos/80/80?random=5&keyword=senior",
          "email": "mike.rodriguez@company.com"
        },
        {
          "id": "emily_davis",
          "name": "Emily Davis",
          "position": "Frontend Developer",
          "avatar": "https://picsum.photos/80/80?random=6&keyword=frontend",
          "email": "emily.davis@company.com"
        }
      ],
      "peers": [
        {
          "id": "david_kim",
          "name": "David Kim",
          "position": "Product Manager",
          "avatar": "https://picsum.photos/80/80?random=7&keyword=product",
          "email": "david.kim@company.com"
        },
        {
          "id": "jessica_brown",
          "name": "Jessica Brown",
          "position": "Design Lead",
          "avatar": "https://picsum.photos/80/80?random=8&keyword=design",
          "email": "jessica.brown@company.com"
        }
      ]
    }
  };

  List<Map<String, dynamic>> reportingRelationships = [
    {
      "from": "Michael Smith",
      "to": "Alex Johnson",
      "relationship": "CEO → CTO",
      "type": "executive",
      "established": "2021-01-15"
    },
    {
      "from": "Alex Johnson",
      "to": "Sarah Chen",
      "relationship": "CTO → Engineering Manager",
      "type": "management",
      "established": "2022-03-20"
    },
    {
      "from": "Sarah Chen",
      "to": "John Doe",
      "relationship": "Manager → Software Engineer",
      "type": "direct",
      "established": "2023-06-01"
    },
    {
      "from": "Sarah Chen",
      "to": "Mike Rodriguez",
      "relationship": "Manager → Senior Developer",
      "type": "direct",
      "established": "2022-08-15"
    },
    {
      "from": "Sarah Chen",
      "to": "Emily Davis",
      "relationship": "Manager → Frontend Developer",
      "type": "direct",
      "established": "2023-02-10"
    }
  ];

  Color _getRelationshipColor(String type) {
    switch (type) {
      case "executive":
        return Colors.purple;
      case "management":
        return Colors.blue;
      case "direct":
        return Colors.green;
      default:
        return primaryColor;
    }
  }

  Widget _buildHierarchyChain(Map<String, dynamic> employee) {
    List<Map<String, dynamic>> chain = [];
    
    // Build upward chain
    Map<String, dynamic>? current = employee;
    while (current != null) {
      chain.add(current);
      current = current["manager"];
    }
    
    return Column(
      children: chain.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> person = entry.value;
        bool isCurrentEmployee = person["id"] == employee["id"];
        
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              margin: EdgeInsets.symmetric(vertical: spXs),
              decoration: BoxDecoration(
                color: isCurrentEmployee ? primaryColor.withAlpha(20) : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isCurrentEmployee ? primaryColor : Colors.grey.withAlpha(50),
                  width: isCurrentEmployee ? 2 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${person["avatar"]}"),
                      ),
                      if (isCurrentEmployee)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${person["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isCurrentEmployee ? primaryColor : Colors.black,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${person["position"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getLevelColor(person["level"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "Level ${person["level"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getLevelColor(person["level"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isCurrentEmployee)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "You",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (index < chain.length - 1)
              Container(
                height: 30,
                child: Column(
                  children: [
                    Container(
                      width: 2,
                      height: 15,
                      color: primaryColor.withAlpha(100),
                    ),
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: primaryColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
          ],
        );
      }).toList(),
    );
  }

  Color _getLevelColor(int level) {
    switch (level) {
      case 1:
        return Colors.purple;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.orange;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentEmployee = hierarchyData[selectedEmployee];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Reporting Hierarchy"),
        actions: [
          QButton(
            icon: viewMode == "hierarchy" ? Icons.list : Icons.account_tree,
            size: bs.sm,
            onPressed: () {
              viewMode = viewMode == "hierarchy" ? "relationships" : "hierarchy";
              setState(() {});
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Employee Selection
            QDropdownField(
              label: "Select Employee",
              items: employees,
              value: selectedEmployee,
              onChanged: (value, label) {
                selectedEmployee = value;
                setState(() {});
              },
            ),

            if (viewMode == "hierarchy" && currentEmployee != null) ...[
              // Current Employee Info
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
                      "Reporting Hierarchy for ${currentEmployee["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.info, color: infoColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Chain of command from top to current position",
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

              // Hierarchy Chain
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: _buildHierarchyChain(currentEmployee),
              ),

              // Direct Reports
              if ((currentEmployee["direct_reports"] as List).isNotEmpty)
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
                      Row(
                        children: [
                          Icon(Icons.people, color: successColor, size: 20),
                          SizedBox(width: spSm),
                          Text(
                            "Direct Reports",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${(currentEmployee["direct_reports"] as List).length} people",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      ...(currentEmployee["direct_reports"] as List).map((report) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: successColor.withAlpha(50)),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage("${report["avatar"]}"),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${report["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${report["position"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                icon: Icons.arrow_forward,
                                size: bs.sm,
                                onPressed: () {
                                  selectedEmployee = report["id"];
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // Peers
              if ((currentEmployee["peers"] as List).isNotEmpty)
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
                      Row(
                        children: [
                          Icon(Icons.group, color: infoColor, size: 20),
                          SizedBox(width: spSm),
                          Text(
                            "Peers",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "Same level",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      ...(currentEmployee["peers"] as List).map((peer) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: infoColor.withAlpha(50)),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage("${peer["avatar"]}"),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${peer["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${peer["position"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                icon: Icons.arrow_forward,
                                size: bs.sm,
                                onPressed: () {
                                  selectedEmployee = peer["id"];
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
            ]
            else ...[
              // Relationships View
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
                      "All Reporting Relationships",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    ...reportingRelationships.map((relationship) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: _getRelationshipColor(relationship["type"]).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getRelationshipColor(relationship["type"]).withAlpha(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getRelationshipColor(relationship["type"]),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "${relationship["type"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Est. ${relationship["established"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${relationship["relationship"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${relationship["from"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: _getRelationshipColor(relationship["type"]),
                                  size: 16,
                                ),
                                Expanded(
                                  child: Text(
                                    "${relationship["to"]}",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
