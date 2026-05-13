import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmFirstTimeFixRateView extends StatefulWidget {
  const FsmFirstTimeFixRateView({super.key});

  @override
  State<FsmFirstTimeFixRateView> createState() => _FsmFirstTimeFixRateViewState();
}

class _FsmFirstTimeFixRateViewState extends State<FsmFirstTimeFixRateView> {
  String selectedPeriod = "Last 30 Days";
  String selectedTechnician = "All Technicians";
  String selectedPriority = "All Priorities";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> technicianItems = [
    {"label": "All Technicians", "value": "All Technicians"},
    {"label": "John Smith", "value": "John Smith"},
    {"label": "Mike Johnson", "value": "Mike Johnson"},
    {"label": "Sarah Wilson", "value": "Sarah Wilson"},
    {"label": "David Brown", "value": "David Brown"},
    {"label": "Lisa Garcia", "value": "Lisa Garcia"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priorities", "value": "All Priorities"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> ftfMetrics = [
    {
      "metric": "Overall FTF Rate",
      "value": 87.5,
      "target": 85.0,
      "change": 4.2,
      "total": 1245,
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "metric": "Emergency Fixes",
      "value": 92.3,
      "target": 90.0,
      "change": 6.8,
      "total": 156,
      "icon": Icons.emergency,
      "color": dangerColor,
    },
    {
      "metric": "High Priority",
      "value": 89.1,
      "target": 87.0,
      "change": 3.5,
      "total": 324,
      "icon": Icons.priority_high,
      "color": warningColor,
    },
    {
      "metric": "Standard Fixes",
      "value": 85.7,
      "target": 83.0,
      "change": 2.1,
      "total": 765,
      "icon": Icons.build,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> technicianPerformance = [
    {
      "name": "Sarah Wilson",
      "ftfRate": 94.2,
      "jobsCompleted": 48,
      "avgAttempts": 1.06,
      "specialty": "HVAC Systems",
      "photo": "https://picsum.photos/50/50?random=1&keyword=woman",
      "improvement": 5.8,
    },
    {
      "name": "Mike Johnson",
      "ftfRate": 91.7,
      "jobsCompleted": 52,
      "avgAttempts": 1.08,
      "specialty": "Electrical",
      "photo": "https://picsum.photos/50/50?random=2&keyword=electrician",
      "improvement": 3.2,
    },
    {
      "name": "John Smith",
      "ftfRate": 88.5,
      "jobsCompleted": 45,
      "avgAttempts": 1.12,
      "specialty": "Plumbing",
      "photo": "https://picsum.photos/50/50?random=3&keyword=plumber",
      "improvement": 2.1,
    },
    {
      "name": "David Brown",
      "ftfRate": 85.3,
      "jobsCompleted": 41,
      "avgAttempts": 1.15,
      "specialty": "General Maintenance",
      "photo": "https://picsum.photos/50/50?random=4&keyword=technician",
      "improvement": -1.4,
    },
    {
      "name": "Lisa Garcia",
      "ftfRate": 83.7,
      "jobsCompleted": 39,
      "avgAttempts": 1.18,
      "specialty": "Appliance Repair",
      "photo": "https://picsum.photos/50/50?random=5&keyword=repair",
      "improvement": 1.8,
    },
  ];

  List<Map<String, dynamic>> failureReasons = [
    {"reason": "Parts Not Available", "count": 89, "percentage": 31.2, "color": dangerColor},
    {"reason": "Complex Diagnosis", "count": 67, "percentage": 23.5, "color": warningColor},
    {"reason": "Additional Work Required", "count": 45, "percentage": 15.8, "color": infoColor},
    {"reason": "Tool/Equipment Missing", "count": 38, "percentage": 13.3, "color": primaryColor},
    {"reason": "Customer Not Available", "count": 28, "percentage": 9.8, "color": disabledBoldColor},
    {"reason": "Other Issues", "count": 18, "percentage": 6.3, "color": secondaryColor},
  ];

  List<Map<String, dynamic>> serviceTypeBreakdown = [
    {"service": "HVAC", "ftfRate": 91.2, "jobs": 342, "improvement": 4.5},
    {"service": "Electrical", "ftfRate": 88.7, "jobs": 298, "improvement": 3.1},
    {"service": "Plumbing", "ftfRate": 86.4, "jobs": 275, "improvement": 2.8},
    {"service": "Appliances", "ftfRate": 84.9, "jobs": 198, "improvement": 1.2},
    {"service": "General", "ftfRate": 82.1, "jobs": 132, "improvement": -0.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Time Fix Rate"),
        actions: [
          IconButton(
            icon: Icon(Icons.trending_up),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_list, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Analysis Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Technician",
                          items: technicianItems,
                          value: selectedTechnician,
                          onChanged: (value, label) {
                            selectedTechnician = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Priority Level",
                    items: priorityItems,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // FTF Metrics
            Text(
              "First Time Fix Metrics",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: ftfMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spSm),
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
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(25),
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
                              color: (metric["change"] as double) >= 0 ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) >= 0 ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["metric"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${metric["value"]}%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Out of ${metric["total"]} jobs • Target: ${metric["target"]}%",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Technician Performance
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.person, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Technician Performance",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: technicianPerformance.map((tech) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage("${tech["photo"]}"),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${tech["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${tech["specialty"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${tech["ftfRate"]}%",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: (tech["ftfRate"] as double) >= 90 ? successColor : 
                                               (tech["ftfRate"] as double) >= 85 ? warningColor : dangerColor,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      (tech["improvement"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                                      size: 12,
                                      color: (tech["improvement"] as double) >= 0 ? successColor : dangerColor,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${tech["jobsCompleted"]} jobs • ${tech["avgAttempts"]} avg attempts",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Service Type Breakdown
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.build, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Service Type Breakdown",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: serviceTypeBreakdown.map((service) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${service["service"]} Services",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${service["jobs"]} jobs completed",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${service["ftfRate"]}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${(service["improvement"] as double) >= 0 ? '+' : ''}${(service["improvement"] as double).toStringAsFixed(1)}% vs last period",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: (service["improvement"] as double) >= 0 ? successColor : dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Failure Reasons
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.error_outline, color: dangerColor),
                      SizedBox(width: spSm),
                      Text(
                        "Common Failure Reasons",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: failureReasons.map((reason) {
                      return Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: reason["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${reason["reason"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${reason["count"]} (${(reason["percentage"] as double).toStringAsFixed(1)}%)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Improvement Suggestions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: successColor),
                      SizedBox(width: spSm),
                      Text(
                        "Improvement Suggestions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "• Improve parts availability - 31% of failures due to missing parts",
                        style: TextStyle(fontSize: 12, color: primaryColor),
                      ),
                      Text(
                        "• Provide advanced diagnostic training to reduce complex diagnosis issues",
                        style: TextStyle(fontSize: 12, color: primaryColor),
                      ),
                      Text(
                        "• Implement tool inventory management system",
                        style: TextStyle(fontSize: 12, color: primaryColor),
                      ),
                      Text(
                        "• Focus training on appliance repair team for FTF improvement",
                        style: TextStyle(fontSize: 12, color: primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Analysis",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Training Plan",
                    icon: Icons.school,
                    size: bs.md,
                    onPressed: () {},
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
