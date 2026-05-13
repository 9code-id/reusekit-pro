import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaCancerScreeningView extends StatefulWidget {
  const HcaCancerScreeningView({super.key});

  @override
  State<HcaCancerScreeningView> createState() => _HcaCancerScreeningViewState();
}

class _HcaCancerScreeningViewState extends State<HcaCancerScreeningView> {
  int currentTab = 0;
  String selectedScreeningType = "Breast Cancer";
  String riskLevel = "";
  String familyHistory = "";
  String lifestyle = "";
  String selectedReminder = "Monthly";

  List<Map<String, dynamic>> screeningTypes = [
    {"label": "Breast Cancer", "value": "Breast Cancer"},
    {"label": "Cervical Cancer", "value": "Cervical Cancer"},
    {"label": "Colorectal Cancer", "value": "Colorectal Cancer"},
    {"label": "Prostate Cancer", "value": "Prostate Cancer"},
    {"label": "Lung Cancer", "value": "Lung Cancer"},
    {"label": "Skin Cancer", "value": "Skin Cancer"},
  ];

  List<Map<String, dynamic>> reminderOptions = [
    {"label": "Monthly", "value": "Monthly"},
    {"label": "Quarterly", "value": "Quarterly"},
    {"label": "Semi-Annual", "value": "Semi-Annual"},
    {"label": "Annual", "value": "Annual"},
  ];

  List<Map<String, dynamic>> screeningHistory = [
    {
      "id": "1",
      "type": "Mammogram",
      "date": "2024-05-15",
      "result": "Normal",
      "facility": "City Medical Center",
      "nextDue": "2025-05-15",
      "notes": "No abnormalities detected",
    },
    {
      "id": "2",
      "type": "Pap Smear",
      "date": "2024-03-20",
      "result": "Normal",
      "facility": "Women's Health Clinic",
      "nextDue": "2025-03-20",
      "notes": "Regular screening, all clear",
    },
    {
      "id": "3",
      "type": "Colonoscopy",
      "date": "2023-12-10",
      "result": "Normal",
      "facility": "Gastro Health Center",
      "nextDue": "2033-12-10",
      "notes": "No polyps found, 10-year interval",
    },
  ];

  List<Map<String, dynamic>> upcomingScreenings = [
    {
      "type": "Skin Check",
      "dueDate": "2024-07-15",
      "facility": "Dermatology Center",
      "priority": "High",
      "description": "Annual full-body skin examination",
    },
    {
      "type": "Chest X-Ray",
      "dueDate": "2024-08-01",
      "facility": "Radiology Clinic",
      "priority": "Medium",
      "description": "Lung cancer screening for high-risk patients",
    },
    {
      "type": "Blood Test",
      "dueDate": "2024-07-30",
      "facility": "Lab Services",
      "priority": "Medium",
      "description": "PSA test for prostate cancer screening",
    },
  ];

  List<Map<String, dynamic>> riskFactors = [
    {
      "category": "Age",
      "risk": "Medium",
      "description": "Age 45-65 increases risk for several cancers",
      "icon": Icons.cake,
    },
    {
      "category": "Family History",
      "risk": "Low",
      "description": "No immediate family history of cancer",
      "icon": Icons.family_restroom,
    },
    {
      "category": "Lifestyle",
      "risk": "Low",
      "description": "Non-smoker, moderate alcohol consumption",
      "icon": Icons.favorite,
    },
    {
      "category": "Environmental",
      "risk": "Medium",
      "description": "Urban environment with air pollution exposure",
      "icon": Icons.location_city,
    },
  ];

  List<Map<String, dynamic>> preventionTips = [
    {
      "title": "Regular Exercise",
      "description": "30 minutes of moderate exercise 5 days a week",
      "icon": Icons.fitness_center,
      "color": successColor,
    },
    {
      "title": "Healthy Diet",
      "description": "Eat plenty of fruits, vegetables, and whole grains",
      "icon": Icons.restaurant,
      "color": successColor,
    },
    {
      "title": "Avoid Tobacco",
      "description": "Quit smoking and avoid secondhand smoke",
      "icon": Icons.smoke_free,
      "color": dangerColor,
    },
    {
      "title": "Limit Alcohol",
      "description": "Moderate alcohol consumption or avoid completely",
      "icon": Icons.local_bar,
      "color": warningColor,
    },
    {
      "title": "Sun Protection",
      "description": "Use sunscreen, wear protective clothing",
      "icon": Icons.wb_sunny,
      "color": warningColor,
    },
    {
      "title": "Maintain Weight",
      "description": "Keep a healthy body weight through diet and exercise",
      "icon": Icons.monitor_weight,
      "color": infoColor,
    },
  ];

  Color _getRiskColor(String risk) {
    switch (risk) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getResultColor(String result) {
    switch (result) {
      case "Normal":
        return successColor;
      case "Abnormal":
        return dangerColor;
      case "Follow-up":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Cancer Screening",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Risk", icon: Icon(Icons.assessment)),
        Tab(text: "Prevention", icon: Icon(Icons.health_and_safety)),
      ],
      tabChildren: [
        _buildScheduleTab(),
        _buildHistoryTab(),
        _buildRiskTab(),
        _buildPreventionTab(),
      ],
      onInit: (tabController) {
        // TabController initialization if needed
      },
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Schedule New Screening
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_month, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Schedule Screening",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Screening Type",
                  items: screeningTypes,
                  value: selectedScreeningType,
                  onChanged: (value, label) {
                    selectedScreeningType = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Reminder Frequency",
                  items: reminderOptions,
                  value: selectedReminder,
                  onChanged: (value, label) {
                    selectedReminder = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Schedule Appointment",
                    size: bs.md,
                    onPressed: () {
                      ss("Screening appointment scheduled");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Upcoming Screenings
          Text(
            "Upcoming Screenings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...upcomingScreenings.map((screening) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getPriorityColor("${screening["priority"]}"),
                  ),
                ),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${screening["type"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getPriorityColor("${screening["priority"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${screening["priority"]} Priority",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getPriorityColor("${screening["priority"]}"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Due: ${screening["dueDate"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${screening["facility"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${screening["description"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Schedule",
                          size: bs.sm,
                          onPressed: () {
                            ss("Appointment scheduled");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Remind Later",
                          size: bs.sm,
                          onPressed: () {
                            ss("Reminder set");
                          },
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
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Screening History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...screeningHistory.map((screening) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${screening["type"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getResultColor("${screening["result"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${screening["result"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getResultColor("${screening["result"]}"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${screening["date"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "Next: ${screening["nextDue"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${screening["facility"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  if (screening["notes"] != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${screening["notes"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Report",
                          size: bs.sm,
                          onPressed: () {
                            ss("Report opened");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Schedule Next",
                          size: bs.sm,
                          onPressed: () {
                            ss("Next screening scheduled");
                          },
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
    );
  }

  Widget _buildRiskTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Risk Assessment
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.assessment, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Risk Assessment",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QMemoField(
                  label: "Family History",
                  value: familyHistory,
                  hint: "Describe any family history of cancer...",
                  onChanged: (value) {
                    familyHistory = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Lifestyle Factors",
                  value: lifestyle,
                  hint: "Smoking, alcohol, diet, exercise habits...",
                  onChanged: (value) {
                    lifestyle = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Update Risk Profile",
                    size: bs.md,
                    onPressed: () {
                      ss("Risk profile updated");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Risk Factors
          Text(
            "Risk Factors",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...riskFactors.map((factor) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getRiskColor("${factor["risk"]}"),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getRiskColor("${factor["risk"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      factor["icon"],
                      color: _getRiskColor("${factor["risk"]}"),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${factor["category"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getRiskColor("${factor["risk"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${factor["risk"]} Risk",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getRiskColor("${factor["risk"]}"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${factor["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          // Overall Risk Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Overall Risk Assessment",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Based on your profile, you have a MODERATE overall risk for cancer. Regular screenings and lifestyle modifications can help reduce this risk.",
                  style: TextStyle(
                    color: infoColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreventionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cancer Prevention Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: preventionTips.map((tip) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (tip["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        tip["icon"],
                        color: tip["color"],
                        size: 32,
                      ),
                    ),
                    Text(
                      "${tip["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${tip["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Educational Resources
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.school, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Educational Resources",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.link, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "American Cancer Society Guidelines",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.link, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "National Cancer Institute Resources",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.link, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Cancer Prevention Diet Guide",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
