import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaGerminationTrackerView extends StatefulWidget {
  const AmaGerminationTrackerView({super.key});

  @override
  State<AmaGerminationTrackerView> createState() => _AmaGerminationTrackerViewState();
}

class _AmaGerminationTrackerViewState extends State<AmaGerminationTrackerView> {
  List<Map<String, dynamic>> germinationTests = [
    {
      "id": 1,
      "testName": "Corn Batch #2024-A",
      "crop": "Corn",
      "variety": "Golden Harvest",
      "lot": "GH-2024-001",
      "testDate": "2024-03-15",
      "seedsUsed": 100,
      "expectedGermination": 90,
      "actualGermination": 92,
      "status": "Completed",
      "daysToGerminate": 7,
      "temperature": 75,
      "moisture": 80,
      "notes": "Excellent germination rate, slightly above expected",
      "dailyRecords": [
        {"day": 1, "germinated": 0, "cumulative": 0},
        {"day": 2, "germinated": 5, "cumulative": 5},
        {"day": 3, "germinated": 15, "cumulative": 20},
        {"day": 4, "germinated": 25, "cumulative": 45},
        {"day": 5, "germinated": 30, "cumulative": 75},
        {"day": 6, "germinated": 12, "cumulative": 87},
        {"day": 7, "germinated": 5, "cumulative": 92}
      ]
    },
    {
      "id": 2,
      "testName": "Soybean Test #2024-B",
      "crop": "Soybean",
      "variety": "Emerald",
      "lot": "EM-2024-002",
      "testDate": "2024-03-20",
      "seedsUsed": 100,
      "expectedGermination": 85,
      "actualGermination": 78,
      "status": "Completed",
      "daysToGerminate": 10,
      "temperature": 70,
      "moisture": 75,
      "notes": "Lower than expected, check seed storage conditions",
      "dailyRecords": [
        {"day": 1, "germinated": 0, "cumulative": 0},
        {"day": 2, "germinated": 2, "cumulative": 2},
        {"day": 3, "germinated": 8, "cumulative": 10},
        {"day": 4, "germinated": 12, "cumulative": 22},
        {"day": 5, "germinated": 18, "cumulative": 40},
        {"day": 6, "germinated": 15, "cumulative": 55},
        {"day": 7, "germinated": 12, "cumulative": 67},
        {"day": 8, "germinated": 8, "cumulative": 75},
        {"day": 9, "germinated": 2, "cumulative": 77},
        {"day": 10, "germinated": 1, "cumulative": 78}
      ]
    },
    {
      "id": 3,
      "testName": "Wheat Sample #2024-C",
      "crop": "Wheat",
      "variety": "Premium Elite",
      "lot": "PE-2024-003",
      "testDate": "2024-03-25",
      "seedsUsed": 100,
      "expectedGermination": 88,
      "actualGermination": 0,
      "status": "In Progress",
      "daysToGerminate": 0,
      "temperature": 65,
      "moisture": 85,
      "notes": "Day 5 of testing, monitoring progress",
      "dailyRecords": [
        {"day": 1, "germinated": 0, "cumulative": 0},
        {"day": 2, "germinated": 3, "cumulative": 3},
        {"day": 3, "germinated": 12, "cumulative": 15},
        {"day": 4, "germinated": 18, "cumulative": 33},
        {"day": 5, "germinated": 22, "cumulative": 55}
      ]
    },
    {
      "id": 4,
      "testName": "Tomato Seeds #2024-D",
      "crop": "Tomato",
      "variety": "Victory",
      "lot": "VT-2024-004",
      "testDate": "2024-03-30",
      "seedsUsed": 50,
      "expectedGermination": 95,
      "actualGermination": 0,
      "status": "Starting",
      "daysToGerminate": 0,
      "temperature": 78,
      "moisture": 90,
      "notes": "Setup complete, awaiting first signs of germination",
      "dailyRecords": [
        {"day": 1, "germinated": 0, "cumulative": 0}
      ]
    }
  ];

  List<Map<String, dynamic>> filteredTests = [];
  String selectedCrop = "All";
  String selectedStatus = "All";

  List<String> cropOptions = ["All", "Corn", "Soybean", "Wheat", "Tomato"];
  List<String> statusOptions = ["All", "Starting", "In Progress", "Completed"];

  @override
  void initState() {
    super.initState();
    filteredTests = germinationTests;
  }

  void _filterTests() {
    filteredTests = germinationTests.where((test) {
      bool matchesCrop = selectedCrop == "All" || test["crop"] == selectedCrop;
      bool matchesStatus = selectedStatus == "All" || test["status"] == selectedStatus;
      
      return matchesCrop && matchesStatus;
    }).toList();
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Starting":
        return infoColor;
      case "In Progress":
        return warningColor;
      case "Completed":
        return successColor;
      default:
        return disabledColor;
    }
  }

  double _calculateGerminationRate(Map<String, dynamic> test) {
    if (test["status"] == "Completed") {
      return ((test["actualGermination"] as int) / (test["seedsUsed"] as int)) * 100;
    } else {
      final records = test["dailyRecords"] as List;
      if (records.isNotEmpty) {
        final lastRecord = records.last;
        return ((lastRecord["cumulative"] as int) / (test["seedsUsed"] as int)) * 100;
      }
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Germination Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to new test
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Section
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
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filter Tests",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Crop Type",
                          items: cropOptions.map((crop) => {
                            "label": crop,
                            "value": crop,
                          }).toList(),
                          value: selectedCrop,
                          onChanged: (value, label) {
                            selectedCrop = value;
                            _filterTests();
                          },
                        ),
                      ),
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
                            _filterTests();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Cards
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${germinationTests.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Tests",
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${germinationTests.where((test) => test["status"] == "In Progress").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Active",
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${((germinationTests.where((test) => test["status"] == "Completed").map((test) => _calculateGerminationRate(test)).fold(0.0, (a, b) => a + b)) / germinationTests.where((test) => test["status"] == "Completed").length).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Avg Rate",
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

            // Germination Tests
            ...List.generate(filteredTests.length, (index) {
              final test = filteredTests[index];
              final germinationRate = _calculateGerminationRate(test);
              final records = test["dailyRecords"] as List;
              final currentDay = records.length;
              final lastRecord = records.isNotEmpty ? records.last : null;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor("${test["status"]}"),
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
                            spacing: spXs,
                            children: [
                              Text(
                                "${test["testName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${test["crop"]} - ${test["variety"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Lot: ${test["lot"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: spXs,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${test["status"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${test["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "Day ${currentDay}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Test Details
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  "Test Date",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(test["testDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: primaryColor.withAlpha(30),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  "Seeds Used",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${test["seedsUsed"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 30,
                            color: primaryColor.withAlpha(30),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: 2,
                            children: [
                              Text(
                                "${germinationRate.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Current Rate",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Environmental Conditions
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.thermostat, size: 16, color: successColor),
                                SizedBox(width: 4),
                                Text(
                                  "${test["temperature"]}°F",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.water_drop, size: 16, color: infoColor),
                                SizedBox(width: 4),
                                Text(
                                  "${test["moisture"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (test["status"] == "Completed")
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.schedule, size: 16, color: warningColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${test["daysToGerminate"]} days",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),

                    // Progress Visualization
                    if (lastRecord != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Germination Progress",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${lastRecord["cumulative"]}/${test["seedsUsed"]} seeds",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: germinationRate / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: germinationRate >= (test["expectedGermination"] as int) 
                                      ? successColor 
                                      : germinationRate >= (test["expectedGermination"] as int) * 0.8 
                                          ? warningColor 
                                          : dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Expected: ${test["expectedGermination"]}%",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              if (test["status"] == "Completed")
                                Text(
                                  germinationRate >= (test["expectedGermination"] as int) 
                                      ? "Above Expected" 
                                      : "Below Expected",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: germinationRate >= (test["expectedGermination"] as int) 
                                        ? successColor 
                                        : dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),

                    // Daily Records (last 3 days)
                    if (records.length > 1)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Recent Progress",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                            ...List.generate(
                              records.length > 3 ? 3 : records.length,
                              (index) {
                                final recordIndex = records.length - 1 - index;
                                final record = records[recordIndex];
                                return Row(
                                  children: [
                                    Text(
                                      "Day ${record["day"]}:",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "+${record["germinated"]} seeds",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Total: ${record["cumulative"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                    if (test["notes"].toString().isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(color: warningColor.withAlpha(30)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.note, size: 16, color: warningColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${test["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to test details
                            },
                          ),
                        ),
                        if (test["status"] == "In Progress")
                          Expanded(
                            child: QButton(
                              label: "Update",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to update test
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            if (filteredTests.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.science,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No germination tests found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Start a new test to track germination",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
