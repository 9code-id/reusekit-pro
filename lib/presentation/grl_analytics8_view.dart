import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAnalytics8View extends StatefulWidget {
  @override
  State<GrlAnalytics8View> createState() => _GrlAnalytics8ViewState();
}

class _GrlAnalytics8ViewState extends State<GrlAnalytics8View> {
  String selectedDepartment = "all";
  String selectedPeriod = "month";

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Sales", "value": "sales"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "This Month", "value": "month"},
    {"label": "Last Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> hrMetrics = [
    {
      "title": "Total Employees",
      "value": 247,
      "change": 8.5,
      "icon": Icons.people,
      "color": Colors.blue
    },
    {
      "title": "Employee Satisfaction",
      "value": 4.3,
      "change": 6.2,
      "icon": Icons.sentiment_satisfied,
      "color": Colors.green
    },
    {
      "title": "Turnover Rate",
      "value": 12.8,
      "change": -15.3,
      "icon": Icons.trending_down,
      "color": Colors.orange
    },
    {
      "title": "Average Salary",
      "value": 75400.0,
      "change": 4.8,
      "icon": Icons.attach_money,
      "color": Colors.purple
    },
  ];

  List<Map<String, dynamic>> departmentData = [
    {
      "department": "Engineering",
      "employees": 78,
      "budget": 2450000.0,
      "satisfaction": 4.6,
      "projects": 23,
      "productivity": 92.5,
      "color": Colors.blue
    },
    {
      "department": "Sales",
      "employees": 45,
      "budget": 1280000.0,
      "satisfaction": 4.1,
      "projects": 15,
      "productivity": 88.2,
      "color": Colors.green
    },
    {
      "department": "Marketing",
      "employees": 32,
      "budget": 890000.0,
      "satisfaction": 4.4,
      "projects": 18,
      "productivity": 85.7,
      "color": Colors.purple
    },
    {
      "department": "HR",
      "employees": 18,
      "budget": 450000.0,
      "satisfaction": 4.2,
      "projects": 8,
      "productivity": 91.3,
      "color": Colors.orange
    },
    {
      "department": "Finance",
      "employees": 24,
      "budget": 680000.0,
      "satisfaction": 4.0,
      "projects": 12,
      "productivity": 89.8,
      "color": Colors.red
    },
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "employee": "Sarah Johnson",
      "department": "Engineering",
      "position": "Senior Developer",
      "performance": 94.5,
      "projects": 8,
      "rating": 4.8,
      "salary": 85000.0,
      "image": "https://picsum.photos/50/50?random=1&keyword=woman"
    },
    {
      "employee": "Michael Chen",
      "department": "Sales",
      "position": "Sales Manager",
      "performance": 91.2,
      "projects": 12,
      "rating": 4.6,
      "salary": 78000.0,
      "image": "https://picsum.photos/50/50?random=2&keyword=man"
    },
    {
      "employee": "Emily Davis",
      "department": "Marketing",
      "position": "Marketing Lead",
      "performance": 89.8,
      "projects": 15,
      "rating": 4.5,
      "salary": 72000.0,
      "image": "https://picsum.photos/50/50?random=3&keyword=woman"
    },
    {
      "employee": "James Wilson",
      "department": "Engineering",
      "position": "Full Stack Developer",
      "performance": 87.3,
      "projects": 6,
      "rating": 4.4,
      "salary": 70000.0,
      "image": "https://picsum.photos/50/50?random=4&keyword=man"
    },
    {
      "employee": "Lisa Anderson",
      "department": "HR",
      "position": "HR Business Partner",
      "performance": 88.9,
      "projects": 4,
      "rating": 4.7,
      "salary": 65000.0,
      "image": "https://picsum.photos/50/50?random=5&keyword=woman"
    },
  ];

  List<Map<String, dynamic>> trainingData = [
    {
      "course": "Leadership Development",
      "participants": 45,
      "completion": 89.5,
      "satisfaction": 4.6,
      "cost": 15000.0,
      "duration": "6 weeks"
    },
    {
      "course": "Technical Skills Bootcamp",
      "participants": 32,
      "completion": 94.2,
      "satisfaction": 4.8,
      "cost": 25000.0,
      "duration": "8 weeks"
    },
    {
      "course": "Communication Skills",
      "participants": 78,
      "completion": 91.8,
      "satisfaction": 4.3,
      "cost": 8000.0,
      "duration": "4 weeks"
    },
    {
      "course": "Project Management",
      "participants": 28,
      "completion": 87.5,
      "satisfaction": 4.5,
      "cost": 12000.0,
      "duration": "5 weeks"
    },
  ];

  List<Map<String, dynamic>> recruitmentData = [
    {
      "position": "Senior Software Engineer",
      "applications": 156,
      "interviews": 24,
      "offers": 3,
      "hires": 2,
      "time_to_hire": 28,
      "status": "active"
    },
    {
      "position": "Marketing Specialist",
      "applications": 89,
      "interviews": 15,
      "offers": 2,
      "hires": 1,
      "time_to_hire": 35,
      "status": "completed"
    },
    {
      "position": "Sales Representative",
      "applications": 134,
      "interviews": 28,
      "offers": 4,
      "hires": 3,
      "time_to_hire": 22,
      "status": "active"
    },
    {
      "position": "Data Analyst",
      "applications": 67,
      "interviews": 12,
      "offers": 1,
      "hires": 1,
      "time_to_hire": 31,
      "status": "completed"
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "completed":
        return infoColor;
      case "paused":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HR Analytics"),
        actions: [
          Icon(Icons.person),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Department",
                    items: departments,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periods,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: hrMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spSm),
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
                              color: (metric["color"] as Color).withAlpha(20),
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
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (metric["change"] as double) >= 0
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                color: (metric["change"] as double) >= 0
                                    ? successColor
                                    : dangerColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        metric["title"] == "Employee Satisfaction"
                            ? "${(metric["value"] as double).toStringAsFixed(1)}/5.0"
                            : metric["title"] == "Turnover Rate"
                            ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                            : metric["title"] == "Average Salary"
                            ? "\$${(metric["value"] as double).currency}"
                            : "${(metric["value"] as int)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Department Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...departmentData.map((dept) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (dept["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: dept["color"] as Color,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${dept["department"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${(dept["employees"] as int)} employees",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                      "Budget",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${(dept["budget"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
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
                                      "Satisfaction",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(dept["satisfaction"] as double).toStringAsFixed(1)}/5.0",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: dept["color"] as Color,
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
                                      "Productivity",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(dept["productivity"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
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

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Top Performers",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...performanceMetrics.take(3).map((employee) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              "${employee["image"]}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${employee["employee"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${employee["position"]} • ${employee["department"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: warningColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${(employee["rating"] as double).toStringAsFixed(1)}",
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${(employee["performance"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${(employee["salary"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Training Programs",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...trainingData.map((training) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(5),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${training["course"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${(training["participants"] as int)} participants",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${(training["completion"] as double).toStringAsFixed(1)}% complete",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
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
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recruitment",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...recruitmentData.map((recruitment) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getStatusColor(recruitment["status"] as String).withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${recruitment["position"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 1,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(recruitment["status"] as String).withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${recruitment["status"]}".toUpperCase(),
                                        style: TextStyle(
                                          color: _getStatusColor(recruitment["status"] as String),
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${(recruitment["hires"] as int)} hired",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${(recruitment["time_to_hire"] as int)} days",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
