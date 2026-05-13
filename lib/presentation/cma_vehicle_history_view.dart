import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaVehicleHistoryView extends StatefulWidget {
  const CmaVehicleHistoryView({super.key});

  @override
  State<CmaVehicleHistoryView> createState() => _CmaVehicleHistoryViewState();
}

class _CmaVehicleHistoryViewState extends State<CmaVehicleHistoryView> {
  int currentTab = 0;
  bool showOnlyAccidents = false;
  String selectedVehicle = "2023 Toyota Camry - ABC123";
  
  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "2023 Toyota Camry - ABC123", "value": "2023 Toyota Camry - ABC123"},
    {"label": "2021 Honda Civic - XYZ789", "value": "2021 Honda Civic - XYZ789"},
    {"label": "2020 Ford Explorer - DEF456", "value": "2020 Ford Explorer - DEF456"},
  ];

  List<Map<String, dynamic>> historyRecords = [
    {
      "date": "2024-12-15",
      "type": "Service",
      "description": "Regular oil change and filter replacement",
      "cost": 45.99,
      "mileage": 25000,
      "shop": "Quick Lube Plus",
      "category": "maintenance",
      "severity": "routine"
    },
    {
      "date": "2024-11-20",
      "type": "Accident",
      "description": "Minor rear-end collision, bumper damage",
      "cost": 1250.00,
      "mileage": 24500,
      "shop": "AutoBody Express",
      "category": "accident",
      "severity": "minor"
    },
    {
      "date": "2024-10-05",
      "type": "Repair",
      "description": "Brake pad replacement and rotor resurfacing",
      "cost": 320.00,
      "mileage": 24000,
      "shop": "Brake Masters",
      "category": "repair",
      "severity": "important"
    },
    {
      "date": "2024-09-12",
      "type": "Service",
      "description": "Tire rotation and alignment check",
      "cost": 65.00,
      "mileage": 23500,
      "shop": "Tire World",
      "category": "maintenance",
      "severity": "routine"
    },
    {
      "date": "2024-08-18",
      "type": "Inspection",
      "description": "Annual state safety inspection passed",
      "cost": 25.00,
      "mileage": 23000,
      "shop": "State Inspection Center",
      "category": "inspection",
      "severity": "required"
    },
    {
      "date": "2024-07-03",
      "type": "Accident",
      "description": "Hail damage to hood and roof",
      "cost": 2100.00,
      "mileage": 22800,
      "shop": "Premier Auto Body",
      "category": "accident",
      "severity": "moderate"
    }
  ];

  List<Map<String, dynamic>> get filteredRecords {
    if (showOnlyAccidents) {
      return historyRecords.where((record) => record["category"] == "accident").toList();
    }
    return historyRecords;
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "accident":
        return dangerColor;
      case "repair":
        return warningColor;
      case "maintenance":
        return successColor;
      case "inspection":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "accident":
        return Icons.warning;
      case "repair":
        return Icons.build;
      case "maintenance":
        return Icons.settings;
      case "inspection":
        return Icons.verified;
      default:
        return Icons.event;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle History"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Exporting vehicle history report...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Selection
            QDropdownField(
              label: "Select Vehicle",
              items: vehicleOptions,
              value: selectedVehicle,
              onChanged: (value, label) {
                selectedVehicle = value;
                setState(() {});
              },
            ),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show Only Accidents",
                        "value": true,
                        "checked": showOnlyAccidents,
                      }
                    ],
                    value: [
                      if (showOnlyAccidents)
                        {"label": "Show Only Accidents", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      showOnlyAccidents = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // History Summary Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(60)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.history, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "History Summary",
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
                        child: Column(
                          children: [
                            Text(
                              "${historyRecords.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Records",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((historyRecords.map((r) => r["cost"] as double).reduce((a, b) => a + b))).currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Cost",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${historyRecords.where((r) => r["category"] == "accident").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Accidents",
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
                ],
              ),
            ),

            // History Records List
            ...filteredRecords.map((record) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getCategoryColor(record["category"]),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(record["category"]).withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            _getCategoryIcon(record["category"]),
                            size: 16,
                            color: _getCategoryColor(record["category"]),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${record["type"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${DateTime.parse(record["date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${record["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${record["shop"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${(record["mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "\$${(record["cost"] as double).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: _getCategoryColor(record["category"]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Add Record Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Record",
                icon: Icons.add,
                size: bs.md,
                onPressed: () {
                  ss("Opening add record form...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
