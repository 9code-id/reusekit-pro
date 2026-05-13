import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStats4View extends StatefulWidget {
  @override
  State<GrlStats4View> createState() => _GrlStats4ViewState();
}

class _GrlStats4ViewState extends State<GrlStats4View> {
  String selectedDepartment = "all";
  String selectedPeriod = "month";
  
  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "all"},
    {"label": "Sales", "value": "sales"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Development", "value": "development"},
    {"label": "Support", "value": "support"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> get employeeStats => [
    {
      "name": "Sarah Johnson",
      "department": "Sales",
      "performance": 92,
      "tasksCompleted": 47,
      "revenue": 125000,
      "efficiency": 89,
      "image": "https://picsum.photos/100/100?random=1&keyword=business",
    },
    {
      "name": "Mike Chen",
      "department": "Development", 
      "performance": 88,
      "tasksCompleted": 34,
      "revenue": 0,
      "efficiency": 94,
      "image": "https://picsum.photos/100/100?random=2&keyword=business",
    },
    {
      "name": "Emma Wilson",
      "department": "Marketing",
      "performance": 85,
      "tasksCompleted": 28,
      "revenue": 87500,
      "efficiency": 91,
      "image": "https://picsum.photos/100/100?random=3&keyword=business",
    },
    {
      "name": "David Rodriguez",
      "department": "Support",
      "performance": 91,
      "tasksCompleted": 52,
      "revenue": 0,
      "efficiency": 87,
      "image": "https://picsum.photos/100/100?random=4&keyword=business",
    },
    {
      "name": "Lisa Park",
      "department": "Sales",
      "performance": 86,
      "tasksCompleted": 41,
      "revenue": 98000,
      "efficiency": 83,
      "image": "https://picsum.photos/100/100?random=5&keyword=business",
    },
  ];

  List<Map<String, dynamic>> get teamMetrics => [
    {
      "title": "Average Performance",
      "value": "88.4%",
      "trend": "+5.2%",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Tasks Completed",
      "value": "202",
      "trend": "+12",
      "icon": Icons.assignment_turned_in,
      "color": primaryColor,
    },
    {
      "title": "Total Revenue",
      "value": "\$310.5K",
      "trend": "+8.7%",
      "icon": Icons.monetization_on,
      "color": successColor,
    },
    {
      "title": "Team Efficiency",
      "value": "88.8%",
      "trend": "+2.1%",
      "icon": Icons.speed,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Performance Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Performance report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Department",
                    items: departmentItems,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periodItems,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Team Metrics
            ResponsiveGridView(
              minItemWidth: 200,
              children: teamMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: metric["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${metric["trend"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Employee Performance List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Employee Performance",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: employeeStats.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final employee = employeeStats[index];
                      return Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage("${employee["image"]}"),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${employee["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${employee["department"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "Performance: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${employee["performance"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: (employee["performance"] as int) >= 90 
                                            ? successColor 
                                            : (employee["performance"] as int) >= 80 
                                              ? warningColor 
                                              : dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if ((employee["revenue"] as int) > 0) ...[
                                  Text(
                                    "\$${((employee["revenue"] as int).toDouble() / 1000).toStringAsFixed(0)}K",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                ],
                                Text(
                                  "${employee["tasksCompleted"]} tasks",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  width: 80,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (employee["efficiency"] as int) / 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: (employee["efficiency"] as int) >= 90 
                                          ? successColor 
                                          : (employee["efficiency"] as int) >= 80 
                                            ? warningColor 
                                            : dangerColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.description,
                    size: bs.md,
                    onPressed: () {
                      ss("Performance report generated successfully");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export Data",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {
                      ss("Data exported successfully");
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
