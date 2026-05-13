import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaComplianceView extends StatefulWidget {
  const AmaComplianceView({super.key});

  @override
  State<AmaComplianceView> createState() => _AmaComplianceViewState();
}

class _AmaComplianceViewState extends State<AmaComplianceView> {
  int selectedTab = 0;
  String selectedStatus = "All";
  String selectedCategory = "All";
  bool showCompliantOnly = false;
  
  List<Map<String, dynamic>> complianceItems = [
    {
      "id": 1,
      "title": "HIPAA Privacy Rule",
      "category": "Privacy",
      "status": "Compliant",
      "lastReview": "2024-12-15",
      "nextReview": "2025-03-15",
      "percentage": 100,
      "documents": 8,
      "risk": "Low",
      "description": "Health Insurance Portability and Accountability Act privacy regulations compliance",
      "requirements": [
        "Patient consent forms updated",
        "Privacy policy reviewed",
        "Staff training completed",
        "Access controls verified"
      ],
      "violations": 0,
      "responsible": "Dr. Sarah Johnson",
    },
    {
      "id": 2,
      "title": "FDA Medical Device Regulation",
      "category": "Regulatory",
      "status": "In Progress",
      "lastReview": "2024-12-10",
      "nextReview": "2025-01-10",
      "percentage": 75,
      "documents": 15,
      "risk": "Medium",
      "description": "Food and Drug Administration medical device compliance requirements",
      "requirements": [
        "Device registration pending",
        "Quality system documentation",
        "Clinical trial protocols",
        "Post-market surveillance plan"
      ],
      "violations": 2,
      "responsible": "Michael Chen",
    },
    {
      "id": 3,
      "title": "DEA Controlled Substances",
      "category": "Security",
      "status": "Non-Compliant",
      "lastReview": "2024-11-28",
      "nextReview": "2024-12-28",
      "percentage": 45,
      "documents": 6,
      "risk": "High",
      "description": "Drug Enforcement Administration controlled substances handling compliance",
      "requirements": [
        "Inventory reconciliation required",
        "Security system update needed",
        "Staff certification expired",
        "Audit documentation missing"
      ],
      "violations": 5,
      "responsible": "Jennifer Martinez",
    },
    {
      "id": 4,
      "title": "OSHA Workplace Safety",
      "category": "Safety",
      "status": "Compliant",
      "lastReview": "2024-12-12",
      "nextReview": "2025-06-12",
      "percentage": 95,
      "documents": 12,
      "risk": "Low",
      "description": "Occupational Safety and Health Administration workplace safety standards",
      "requirements": [
        "Safety training up to date",
        "Equipment inspections completed",
        "Incident reporting system active",
        "Emergency procedures reviewed"
      ],
      "violations": 1,
      "responsible": "Robert Wilson",
    },
    {
      "id": 5,
      "title": "CMS Quality Measures",
      "category": "Quality",
      "status": "In Progress",
      "lastReview": "2024-12-08",
      "nextReview": "2025-02-08",
      "percentage": 82,
      "documents": 20,
      "risk": "Medium",
      "description": "Centers for Medicare & Medicaid Services quality reporting compliance",
      "requirements": [
        "Quality metrics collection",
        "Patient satisfaction surveys",
        "Clinical outcome tracking",
        "Performance improvement plans"
      ],
      "violations": 3,
      "responsible": "Dr. Amanda Davis",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "id": 1,
      "type": "Review",
      "title": "HIPAA Privacy Rule assessment completed",
      "date": "2024-12-15",
      "user": "Dr. Sarah Johnson",
      "status": "Completed",
    },
    {
      "id": 2,
      "type": "Update",
      "title": "FDA Device Registration documentation updated",
      "date": "2024-12-14",
      "user": "Michael Chen",
      "status": "In Progress",
    },
    {
      "id": 3,
      "type": "Alert",
      "title": "DEA Controlled Substances violations detected",
      "date": "2024-12-13",
      "user": "System Alert",
      "status": "Critical",
    },
    {
      "id": 4,
      "type": "Training",
      "title": "OSHA Safety training session conducted",
      "date": "2024-12-12",
      "user": "Robert Wilson",
      "status": "Completed",
    },
  ];

  List<String> statusOptions = ["All", "Compliant", "In Progress", "Non-Compliant"];
  List<String> categoryOptions = ["All", "Privacy", "Regulatory", "Security", "Safety", "Quality"];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "AMA Compliance",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Requirements", icon: Icon(Icons.assignment)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Compliance Summary Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [successColor.withAlpha(25), successColor.withAlpha(50)],
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
                                Icons.check_circle,
                                color: successColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${((complianceItems.where((item) => item["status"] == "Compliant").length / complianceItems.length) * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Overall Compliance",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${complianceItems.where((item) => item["status"] == "Compliant").length}/${complianceItems.length} Items",
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
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [dangerColor.withAlpha(25), dangerColor.withAlpha(50)],
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
                                Icons.warning,
                                color: dangerColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${complianceItems.fold(0, (sum, item) => sum + (item["violations"] as int))}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Total Violations",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Requires Attention",
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

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [warningColor.withAlpha(25), warningColor.withAlpha(50)],
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
                                Icons.pending,
                                color: warningColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${complianceItems.where((item) => item["status"] == "In Progress").length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "In Progress",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Active Reviews",
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
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [infoColor.withAlpha(25), infoColor.withAlpha(50)],
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
                                Icons.schedule,
                                color: infoColor,
                                size: 24,
                              ),
                              Spacer(),
                              Text(
                                "${complianceItems.where((item) => DateTime.parse(item["nextReview"]).isBefore(DateTime.now().add(Duration(days: 30)))).length}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Due Soon",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Next 30 Days",
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

              // Risk Assessment
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Risk Assessment",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusSm),
                                bottomLeft: Radius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 8,
                            color: warningColor,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(radiusSm),
                                bottomRight: Radius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: dangerColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "High Risk (${complianceItems.where((item) => item["risk"] == "High").length})",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: warningColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Medium (${complianceItems.where((item) => item["risk"] == "Medium").length})",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: successColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Low Risk (${complianceItems.where((item) => item["risk"] == "Low").length})",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // High Priority Items
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Text(
                          "High Priority Items",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "View All",
                          size: bs.sm,
                          onPressed: () {
                            selectedTab = 1;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: complianceItems
                          .where((item) => item["risk"] == "High" || item["status"] == "Non-Compliant")
                          .take(3)
                          .map((item) {
                        Color statusColor = item["status"] == "Compliant" ? successColor :
                                          item["status"] == "In Progress" ? warningColor : dangerColor;
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border(
                              left: BorderSide(
                                color: statusColor,
                                width: 4,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${item["category"]} • Due: ${item["nextReview"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Requirements Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Filters
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions.map((status) => {
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
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: categoryOptions.map((category) => {
                        "label": category,
                        "value": category,
                      }).toList(),
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QSwitch(
                items: [
                  {
                    "label": "Show Compliant Only",
                    "value": true,
                    "checked": showCompliantOnly,
                  }
                ],
                value: [
                  if (showCompliantOnly)
                    {
                      "label": "Show Compliant Only",
                      "value": true,
                      "checked": true,
                    }
                ],
                onChanged: (values, ids) {
                  showCompliantOnly = values.isNotEmpty;
                  setState(() {});
                },
              ),

              // Compliance Items List
              Column(
                children: complianceItems
                    .where((item) {
                      if (selectedStatus != "All" && item["status"] != selectedStatus) return false;
                      if (selectedCategory != "All" && item["category"] != selectedCategory) return false;
                      if (showCompliantOnly && item["status"] != "Compliant") return false;
                      return true;
                    })
                    .map((item) {
                  Color statusColor = item["status"] == "Compliant" ? successColor :
                                    item["status"] == "In Progress" ? warningColor : dangerColor;

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: statusColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${item["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
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
                                color: statusColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${item["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Progress Bar
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Compliance Progress",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${item["percentage"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            LinearProgressIndicator(
                              value: (item["percentage"] as int) / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                            ),
                          ],
                        ),

                        // Details
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.folder,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["documents"]} Documents",
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
                                    Icons.warning,
                                    color: dangerColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["violations"]} Violations",
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

                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["responsible"]}",
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
                                    Icons.schedule,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Due: ${item["nextReview"]}",
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

                        // Requirements List
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Requirements:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Column(
                              children: (item["requirements"] as List).map((requirement) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: primaryColor,
                                        size: 14,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "$requirement",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Update Status",
                              size: bs.sm,
                              onPressed: () {},
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

        // Activity Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                children: recentActivities.map((activity) {
                  Color typeColor = activity["type"] == "Review" ? infoColor :
                                   activity["type"] == "Update" ? warningColor :
                                   activity["type"] == "Alert" ? dangerColor : primaryColor;
                  
                  IconData typeIcon = activity["type"] == "Review" ? Icons.assignment :
                                     activity["type"] == "Update" ? Icons.edit :
                                     activity["type"] == "Alert" ? Icons.warning :
                                     Icons.school;

                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: typeColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: typeColor.withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            typeIcon,
                            color: typeColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "by ${activity["user"]} • ${activity["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                            color: typeColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${activity["type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: typeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
