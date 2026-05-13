import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSoilTestingView extends StatefulWidget {
  const AmaSoilTestingView({super.key});

  @override
  State<AmaSoilTestingView> createState() => _AmaSoilTestingViewState();
}

class _AmaSoilTestingViewState extends State<AmaSoilTestingView> {
  List<Map<String, dynamic>> testingSchedule = [
    {
      "id": "ST001",
      "fieldName": "North Field",
      "scheduledDate": "2024-06-20",
      "time": "09:00",
      "testType": "Complete Soil Analysis",
      "depth": "0-30cm",
      "gridPoints": 12,
      "status": "Scheduled",
      "technician": "Dr. Smith",
      "estimatedDuration": "2 hours",
      "priority": "High",
    },
    {
      "id": "ST002",
      "fieldName": "South Field",
      "scheduledDate": "2024-06-22",
      "time": "10:30",
      "testType": "pH & Nutrient Test",
      "depth": "0-20cm",
      "gridPoints": 8,
      "status": "In Progress",
      "technician": "Dr. Johnson",
      "estimatedDuration": "1.5 hours",
      "priority": "Medium",
    },
    {
      "id": "ST003",
      "fieldName": "East Field",
      "scheduledDate": "2024-06-25",
      "time": "08:00",
      "testType": "Organic Matter Test",
      "depth": "0-25cm",
      "gridPoints": 10,
      "status": "Completed",
      "technician": "Dr. Brown",
      "estimatedDuration": "1 hour",
      "priority": "Low",
    },
  ];

  List<Map<String, dynamic>> testTypes = [
    {
      "name": "Complete Soil Analysis",
      "description": "Comprehensive testing including pH, NPK, organic matter, and micronutrients",
      "duration": "2-3 hours",
      "cost": 150,
      "parameters": ["pH", "Nitrogen", "Phosphorus", "Potassium", "Organic Matter", "Micronutrients"],
    },
    {
      "name": "Basic Nutrient Test",
      "description": "Essential NPK testing for immediate fertilizer recommendations",
      "duration": "1 hour",
      "cost": 75,
      "parameters": ["Nitrogen", "Phosphorus", "Potassium"],
    },
    {
      "name": "pH & Lime Requirement",
      "description": "pH testing with lime requirement calculations",
      "duration": "45 minutes",
      "cost": 45,
      "parameters": ["pH", "Buffer pH", "Lime Requirement"],
    },
    {
      "name": "Organic Matter Analysis",
      "description": "Organic carbon and matter content analysis",
      "duration": "1.5 hours",
      "cost": 85,
      "parameters": ["Organic Carbon", "Organic Matter", "C:N Ratio"],
    },
  ];

  String selectedField = "";
  String selectedTestType = "";
  String scheduledDate = "";
  String scheduledTime = "";
  String sampleDepth = "0-20cm";
  int gridPoints = 8;
  String specialInstructions = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soil Testing"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // navigateTo('testing-calendar')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.biotech,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Soil Testing Services",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Schedule professional soil testing for accurate analysis",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Test Types Section
            Text(
              "Available Test Types",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: testTypes.length,
              itemBuilder: (context, index) {
                final testType = testTypes[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${testType["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "\$${testType["cost"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      Text(
                        "${testType["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${testType["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.checklist,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(testType["parameters"] as List).length} parameters",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Schedule Test",
                          size: bs.sm,
                          onPressed: () {
                            selectedTestType = "${testType["name"]}";
                            _showScheduleDialog();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: spLg),

            // Scheduled Tests Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Scheduled Tests",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {
                    // navigateTo('all-scheduled-tests')
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: testingSchedule.length,
              itemBuilder: (context, index) {
                final test = testingSchedule[index];
                Color statusColor = successColor;
                if ("${test["status"]}" == "Scheduled") statusColor = warningColor;
                if ("${test["status"]}" == "In Progress") statusColor = infoColor;

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${test["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${test["id"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      Text(
                        "${test["fieldName"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      SizedBox(height: spXs),

                      Text(
                        "${test["testType"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Icon(
                            Icons.event,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${test["scheduledDate"]} at ${test["time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.person,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${test["technician"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo('test-detail')
                              },
                            ),
                          ),
                          if ("${test["status"]}" == "Scheduled") ...[
                            SizedBox(width: spSm),
                            QButton(
                              label: "Reschedule",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
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
    );
  }

  void _showScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Schedule Soil Test"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Select Field",
              items: [
                {"label": "North Field", "value": "North Field"},
                {"label": "South Field", "value": "South Field"},
                {"label": "East Field", "value": "East Field"},
                {"label": "West Field", "value": "West Field"},
              ],
              value: selectedField,
              onChanged: (value, label) {
                selectedField = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDatePicker(
              label: "Test Date",
              value: DateTime.now().add(Duration(days: 1)),
              onChanged: (value) {
                scheduledDate = "${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}";
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTimePicker(
              label: "Test Time",
              value: TimeOfDay(hour: 9, minute: 0),
              onChanged: (value) {
                scheduledTime = value!.kkmm;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Test scheduled successfully");
            },
            child: Text("Schedule"),
          ),
        ],
      ),
    );
  }
}
