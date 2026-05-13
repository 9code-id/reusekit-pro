import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaOnboardingChecklistView extends StatefulWidget {
  const RhaOnboardingChecklistView({super.key});

  @override
  State<RhaOnboardingChecklistView> createState() => _RhaOnboardingChecklistViewState();
}

class _RhaOnboardingChecklistViewState extends State<RhaOnboardingChecklistView> {
  String selectedEmployee = "john_doe";
  List<Map<String, dynamic>> employees = [
    {
      "id": "john_doe",
      "name": "John Doe",
      "position": "Software Engineer",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=man",
      "startDate": "2024-06-15",
      "department": "Engineering"
    },
    {
      "id": "jane_smith",
      "name": "Jane Smith", 
      "position": "UX Designer",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
      "startDate": "2024-06-20",
      "department": "Design"
    },
    {
      "id": "mike_johnson",
      "name": "Mike Johnson",
      "position": "Product Manager",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=man",
      "startDate": "2024-06-25",
      "department": "Product"
    },
  ];

  List<Map<String, dynamic>> checklistItems = [
    {
      "category": "Documentation",
      "items": [
        {"title": "Complete employment forms", "completed": true, "required": true},
        {"title": "Submit ID and documents", "completed": true, "required": true},
        {"title": "Sign company policies", "completed": false, "required": true},
        {"title": "Emergency contact information", "completed": false, "required": true},
      ]
    },
    {
      "category": "IT Setup",
      "items": [
        {"title": "Receive laptop and equipment", "completed": true, "required": true},
        {"title": "Set up email account", "completed": true, "required": true},
        {"title": "Install required software", "completed": false, "required": true},
        {"title": "VPN access configuration", "completed": false, "required": true},
        {"title": "Security training completion", "completed": false, "required": true},
      ]
    },
    {
      "category": "Workspace",
      "items": [
        {"title": "Office tour and orientation", "completed": true, "required": true},
        {"title": "Desk and parking assignment", "completed": false, "required": true},
        {"title": "Key card and access setup", "completed": false, "required": true},
        {"title": "Meet team members", "completed": false, "required": false},
      ]
    },
    {
      "category": "Training",
      "items": [
        {"title": "Company culture presentation", "completed": false, "required": true},
        {"title": "Role-specific training", "completed": false, "required": true},
        {"title": "Health and safety briefing", "completed": false, "required": true},
        {"title": "Buddy system assignment", "completed": false, "required": false},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedEmp = employees.firstWhere((emp) => emp["id"] == selectedEmployee);
    
    int totalItems = 0;
    int completedItems = 0;
    
    for (var category in checklistItems) {
      for (var item in category["items"]) {
        totalItems++;
        if (item["completed"]) completedItems++;
      }
    }
    
    double progressPercentage = totalItems > 0 ? (completedItems / totalItems) * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Onboarding Checklist"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              //navigateTo('AddChecklistItemView')
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
              items: employees.map((emp) => {
                "label": "${emp["name"]} - ${emp["position"]}",
                "value": emp["id"],
              }).toList(),
              value: selectedEmployee,
              onChanged: (value, label) {
                selectedEmployee = value;
                setState(() {});
              },
            ),

            // Employee Info Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${selectedEmp["avatar"]}"),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedEmp["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${selectedEmp["position"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Start Date: ${selectedEmp["startDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Progress Overview
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Overall Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${progressPercentage.toInt()}%",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: progressPercentage >= 75 ? successColor : warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: progressPercentage / 100,
                    backgroundColor: disabledColor.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progressPercentage >= 75 ? successColor : warningColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "$completedItems of $totalItems tasks completed",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Checklist Categories
            ...checklistItems.map((category) {
              List<Map<String, dynamic>> items = category["items"];
              int categoryCompleted = items.where((item) => item["completed"]).length;
              
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${category["category"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: categoryCompleted == items.length ? successColor : warningColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "$categoryCompleted/${items.length}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...items.map((item) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: disabledColor.withAlpha(30),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                item["completed"] = !item["completed"];
                                setState(() {});
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: item["completed"] ? successColor : Colors.transparent,
                                  border: Border.all(
                                    color: item["completed"] ? successColor : disabledColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: item["completed"]
                                  ? Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${item["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: item["completed"] ? disabledBoldColor : primaryColor,
                                            decoration: item["completed"] ? TextDecoration.lineThrough : null,
                                          ),
                                        ),
                                      ),
                                      if (item["required"])
                                        Container(
                                          margin: EdgeInsets.only(left: spSm),
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: dangerColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Required",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: dangerColor,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('TaskDetailsView')
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Send Reminder",
                    icon: Icons.notifications,
                    size: bs.md,
                    onPressed: () {
                      ss("Reminder sent to ${selectedEmp["name"]}");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('OnboardingReportView')
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
