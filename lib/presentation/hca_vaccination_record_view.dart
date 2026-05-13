import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaVaccinationRecordView extends StatefulWidget {
  const HcaVaccinationRecordView({super.key});

  @override
  State<HcaVaccinationRecordView> createState() => _HcaVaccinationRecordViewState();
}

class _HcaVaccinationRecordViewState extends State<HcaVaccinationRecordView> {
  int currentTab = 0;
  
  // Add Vaccination Form Variables
  String vaccineName = "";
  String vaccineType = "";
  String manufacturer = "";
  String lotNumber = "";
  String administeredBy = "";
  String location = "";
  String nextDueDate = "";
  String notes = "";
  
  List<Map<String, dynamic>> vaccineTypeItems = [
    {"label": "COVID-19", "value": "COVID-19"},
    {"label": "Influenza", "value": "Influenza"},
    {"label": "Hepatitis A", "value": "Hepatitis A"},
    {"label": "Hepatitis B", "value": "Hepatitis B"},
    {"label": "Tetanus", "value": "Tetanus"},
    {"label": "Measles", "value": "Measles"},
    {"label": "Mumps", "value": "Mumps"},
    {"label": "Rubella", "value": "Rubella"},
    {"label": "Polio", "value": "Polio"},
    {"label": "HPV", "value": "HPV"},
    {"label": "Shingles", "value": "Shingles"},
    {"label": "Pneumonia", "value": "Pneumonia"},
    {"label": "Other", "value": "Other"},
  ];
  
  List<Map<String, dynamic>> vaccinations = [
    {
      "id": "1",
      "name": "COVID-19 Vaccine (Moderna)",
      "type": "COVID-19",
      "manufacturer": "Moderna",
      "lotNumber": "012M20A",
      "administeredBy": "Dr. Sarah Wilson",
      "location": "City Health Center",
      "dateAdministered": "2024-03-15",
      "nextDue": "2024-09-15",
      "isUpToDate": true,
      "dose": "Booster",
      "sideEffects": "Mild arm soreness",
      "daysUntilDue": 89,
    },
    {
      "id": "2",
      "name": "Influenza Vaccine",
      "type": "Influenza",
      "manufacturer": "Sanofi",
      "lotNumber": "FLU2024A",
      "administeredBy": "Nurse Johnson",
      "location": "Local Pharmacy",
      "dateAdministered": "2023-10-20",
      "nextDue": "2024-10-20",
      "isUpToDate": false,
      "dose": "Annual",
      "sideEffects": "None reported",
      "daysUntilDue": -242,
    },
    {
      "id": "3",
      "name": "Tetanus Vaccine",
      "type": "Tetanus",
      "manufacturer": "GSK",
      "lotNumber": "TET2023B",
      "administeredBy": "Dr. Michael Brown",
      "location": "General Hospital",
      "dateAdministered": "2021-08-10",
      "nextDue": "2031-08-10",
      "isUpToDate": true,
      "dose": "1st",
      "sideEffects": "Mild fever",
      "daysUntilDue": 2614,
    },
  ];
  
  List<Map<String, dynamic>> upcomingVaccinations = [
    {
      "vaccine": "Influenza Vaccine",
      "dueDate": "2024-10-20",
      "priority": "High",
      "daysOverdue": 242,
      "isOverdue": true,
    },
    {
      "vaccine": "HPV Vaccine (3rd dose)",
      "dueDate": "2024-08-15",
      "priority": "Medium",
      "daysUntilDue": 58,
      "isOverdue": false,
    },
    {
      "vaccine": "Hepatitis B (2nd dose)",
      "dueDate": "2024-07-30",
      "priority": "Medium",
      "daysUntilDue": 42,
      "isOverdue": false,
    },
  ];

  Color _getStatusColor(bool isUpToDate, int daysUntilDue) {
    if (daysUntilDue < 0) return dangerColor; // Overdue
    if (!isUpToDate) return warningColor; // Due soon
    return successColor; // Up to date
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Vaccination Records",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Records", icon: Icon(Icons.vaccines)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Add Record", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildRecordsTab(),
        _buildScheduleTab(),
        _buildAnalyticsTab(),
        _buildAddRecordTab(),
      ],
    );
  }

  Widget _buildRecordsTab() {
    List<Map<String, dynamic>> upToDateVaccinations = vaccinations.where((v) => v["isUpToDate"]).toList();
    List<Map<String, dynamic>> overdueVaccinations = vaccinations.where((v) => !v["isUpToDate"]).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Records",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${vaccinations.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Up to Date",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${upToDateVaccinations.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overdue",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${overdueVaccinations.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Vaccination Records
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
                Text(
                  "Vaccination History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...vaccinations.map((vaccination) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${vaccination["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${vaccination["type"]} • ${vaccination["dose"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(vaccination["isUpToDate"], vaccination["daysUntilDue"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                vaccination["isUpToDate"] ? "Up to Date" : "Overdue",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(vaccination["isUpToDate"], vaccination["daysUntilDue"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          spacing: spMd,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date Administered",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${vaccination["dateAdministered"]}",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                    "Next Due",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${vaccination["nextDue"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Administered by: ${vaccination["administeredBy"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Location: ${vaccination["location"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Lot Number: ${vaccination["lotNumber"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        if ((vaccination["sideEffects"] as String).isNotEmpty && vaccination["sideEffects"] != "None reported") ...[
                          SizedBox(height: spXs),
                          Text(
                            "Side Effects: ${vaccination["sideEffects"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Overview
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
                Text(
                  "Vaccination Schedule Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Overdue",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${upcomingVaccinations.where((v) => v["isOverdue"]).length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Due Soon",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${upcomingVaccinations.where((v) => !v["isOverdue"]).length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Upcoming Vaccinations
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
                Text(
                  "Upcoming Vaccinations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...upcomingVaccinations.map((upcoming) {
                  bool isOverdue = upcoming["isOverdue"];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isOverdue ? dangerColor : warningColor,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                      color: (isOverdue ? dangerColor : warningColor).withAlpha(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${upcoming["vaccine"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Due: ${upcoming["dueDate"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(upcoming["priority"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${upcoming["priority"]} Priority",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getPriorityColor(upcoming["priority"]),
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  isOverdue 
                                    ? "${upcoming["daysOverdue"]} days overdue"
                                    : "${upcoming["daysUntilDue"]} days left",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isOverdue ? dangerColor : warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: isOverdue ? "Schedule Overdue" : "Schedule Now",
                            size: bs.sm,
                            onPressed: () {
                              ss("Vaccination scheduled successfully");
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Recommended Vaccines by Age
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
                Text(
                  "Recommended Vaccines (Age 25-35)",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...["COVID-19 Booster", "Annual Flu Shot", "HPV (if not completed)", "Hepatitis B (if at risk)"].map((vaccine) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.vaccines,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            vaccine,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          label: "Learn More",
                          size: bs.sm,
                          onPressed: () {
                            si("Learn more about $vaccine");
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    Map<String, int> vaccineTypeCount = {};
    Map<String, int> yearlyCount = {};
    
    for (var vaccination in vaccinations) {
      String type = vaccination["type"];
      String year = (vaccination["dateAdministered"] as String).split('-')[0];
      
      vaccineTypeCount[type] = (vaccineTypeCount[type] ?? 0) + 1;
      yearlyCount[year] = (yearlyCount[year] ?? 0) + 1;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Vaccination Status Distribution
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
                Text(
                  "Vaccination Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${vaccinations.where((v) => v["isUpToDate"]).length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Up to Date",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${vaccinations.where((v) => !v["isUpToDate"]).length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Overdue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${((vaccinations.where((v) => v["isUpToDate"]).length / vaccinations.length) * 100).round()}%",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Compliance",
                              textAlign: TextAlign.center,
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
              ],
            ),
          ),

          // Vaccine Types Distribution
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
                Text(
                  "Vaccines by Type",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...vaccineTypeCount.entries.map((entry) {
                  double percentage = (entry.value / vaccinations.length) * 100;
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "${entry.value} (${percentage.toStringAsFixed(1)}%)",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Vaccination Timeline
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
                Text(
                  "Vaccination Timeline",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...yearlyCount.entries.map((entry) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            height: 24,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (entry.value / vaccinations.length),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: infoColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Center(
                                  child: Text(
                                    "${entry.value}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRecordTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
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
                Text(
                  "Add Vaccination Record",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                // Vaccine Name
                QTextField(
                  label: "Vaccine Name",
                  value: vaccineName,
                  hint: "e.g., COVID-19 Vaccine (Moderna)",
                  onChanged: (value) {
                    vaccineName = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Vaccine Type
                QDropdownField(
                  label: "Vaccine Type",
                  items: vaccineTypeItems,
                  value: vaccineType,
                  onChanged: (value, label) {
                    vaccineType = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Manufacturer
                QTextField(
                  label: "Manufacturer",
                  value: manufacturer,
                  hint: "e.g., Moderna, Pfizer, GSK",
                  onChanged: (value) {
                    manufacturer = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Lot Number
                QTextField(
                  label: "Lot Number",
                  value: lotNumber,
                  hint: "Vaccine lot/batch number",
                  onChanged: (value) {
                    lotNumber = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Administered By
                QTextField(
                  label: "Administered By",
                  value: administeredBy,
                  hint: "Healthcare provider name",
                  onChanged: (value) {
                    administeredBy = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Location
                QTextField(
                  label: "Location/Facility",
                  value: location,
                  hint: "Where was the vaccine given?",
                  onChanged: (value) {
                    location = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Next Due Date
                QDatePicker(
                  label: "Next Due Date (Optional)",
                  value: nextDueDate.isNotEmpty ? DateTime.parse(nextDueDate) : DateTime.now().add(Duration(days: 365)),
                  onChanged: (value) {
                    nextDueDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spSm),
                
                // Notes
                QMemoField(
                  label: "Notes",
                  value: notes,
                  hint: "Side effects, reactions, or other notes",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),
                
                SizedBox(height: spMd),
                
                // Save Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Save Vaccination Record",
                    size: bs.md,
                    onPressed: () {
                      // Save vaccination record logic
                      ss("Vaccination record saved successfully");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
