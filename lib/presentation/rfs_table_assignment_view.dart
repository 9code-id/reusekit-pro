import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsTableAssignmentView extends StatefulWidget {
  const RfsTableAssignmentView({super.key});

  @override
  State<RfsTableAssignmentView> createState() => _RfsTableAssignmentViewState();
}

class _RfsTableAssignmentViewState extends State<RfsTableAssignmentView> {
  int selectedZone = 0;
  String selectedTableType = "All";
  String selectedStatus = "All";
  bool showOnlyAvailable = false;

  List<Map<String, dynamic>> zones = [
    {"name": "Main Hall", "tables": 24, "available": 18},
    {"name": "Private Rooms", "tables": 8, "available": 6},
    {"name": "Outdoor Terrace", "tables": 12, "available": 10},
    {"name": "VIP Section", "tables": 6, "available": 4},
  ];

  List<Map<String, dynamic>> tables = [
    {
      "id": "T001",
      "number": "1",
      "type": "Standard",
      "capacity": 4,
      "status": "Available",
      "zone": "Main Hall",
      "guest": null,
      "reservationTime": null,
      "estimatedTurnover": null,
    },
    {
      "id": "T002", 
      "number": "2",
      "type": "Window",
      "capacity": 2,
      "status": "Occupied",
      "zone": "Main Hall",
      "guest": "Smith Family",
      "reservationTime": "7:30 PM",
      "estimatedTurnover": "9:00 PM",
    },
    {
      "id": "T003",
      "number": "3", 
      "type": "Standard",
      "capacity": 6,
      "status": "Reserved",
      "zone": "Main Hall",
      "guest": "Johnson Party",
      "reservationTime": "8:00 PM",
      "estimatedTurnover": "10:00 PM",
    },
    {
      "id": "T004",
      "number": "4",
      "type": "Booth",
      "capacity": 4,
      "status": "Cleaning",
      "zone": "Main Hall",
      "guest": null,
      "reservationTime": null,
      "estimatedTurnover": "8:15 PM",
    },
    {
      "id": "VIP001",
      "number": "VIP-1",
      "type": "Private",
      "capacity": 8,
      "status": "Available",
      "zone": "VIP Section",
      "guest": null,
      "reservationTime": null,
      "estimatedTurnover": null,
    },
    {
      "id": "VIP002",
      "number": "VIP-2",
      "type": "Private",
      "capacity": 12,
      "status": "Occupied",
      "zone": "VIP Section",
      "guest": "Corporate Event",
      "reservationTime": "6:00 PM",
      "estimatedTurnover": "11:00 PM",
    },
  ];

  List<Map<String, dynamic>> tableTypes = [
    {"label": "All Types", "value": "All"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Window", "value": "Window"},
    {"label": "Booth", "value": "Booth"},
    {"label": "Private", "value": "Private"},
  ];

  List<Map<String, dynamic>> statusTypes = [
    {"label": "All Status", "value": "All"},
    {"label": "Available", "value": "Available"},
    {"label": "Occupied", "value": "Occupied"},
    {"label": "Reserved", "value": "Reserved"},
    {"label": "Cleaning", "value": "Cleaning"},
  ];

  List<Map<String, dynamic>> get filteredTables {
    return tables.where((table) {
      bool matchesType = selectedTableType == "All" || table["type"] == selectedTableType;
      bool matchesStatus = selectedStatus == "All" || table["status"] == selectedStatus;
      bool matchesAvailable = !showOnlyAvailable || table["status"] == "Available";
      bool matchesZone = table["zone"] == zones[selectedZone]["name"];
      
      return matchesType && matchesStatus && matchesAvailable && matchesZone;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Occupied":
        return dangerColor;
      case "Reserved":
        return warningColor;
      case "Cleaning":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  void _assignTable(Map<String, dynamic> table) async {
    bool isConfirmed = await confirm("Assign table ${table["number"]} to a guest?");
    if (isConfirmed) {
      setState(() {
        table["status"] = "Occupied";
        table["guest"] = "Walk-in Guest";
        table["reservationTime"] = TimeOfDay.now().kkmm;
      });
      ss("Table ${table["number"]} assigned successfully");
    }
  }

  void _clearTable(Map<String, dynamic> table) async {
    bool isConfirmed = await confirm("Clear table ${table["number"]}?");
    if (isConfirmed) {
      setState(() {
        table["status"] = "Cleaning";
        table["guest"] = null;
        table["reservationTime"] = null;
      });
      ss("Table ${table["number"]} cleared successfully");
    }
  }

  void _markAvailable(Map<String, dynamic> table) async {
    bool isConfirmed = await confirm("Mark table ${table["number"]} as available?");
    if (isConfirmed) {
      setState(() {
        table["status"] = "Available";
        table["guest"] = null;
        table["reservationTime"] = null;
        table["estimatedTurnover"] = null;
      });
      ss("Table ${table["number"]} is now available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Assignment"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              setState(() {});
              si("Table status refreshed");
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
            // Zone Selection
            Container(
              width: double.infinity,
              child: QCategoryPicker(
                label: "Select Zone",
                items: zones.asMap().entries.map((entry) {
                  final index = entry.key;
                  final zone = entry.value;
                  return {
                    "label": "${zone["name"]} (${zone["available"]}/${zone["tables"]})",
                    "value": index,
                  };
                }).toList(),
                value: selectedZone,
                onChanged: (index, label, value, item) {
                  selectedZone = value;
                  setState(() {});
                },
              ),
            ),

            // Zone Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.restaurant, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${zones[selectedZone]["name"]} - ${zones[selectedZone]["available"]} Available, ${(zones[selectedZone]["tables"] as int) - (zones[selectedZone]["available"] as int)} Occupied",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Table Type",
                    items: tableTypes,
                    value: selectedTableType,
                    onChanged: (value, label) {
                      selectedTableType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusTypes,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Show Only Available Toggle
            QSwitch(
              items: [
                {
                  "label": "Show only available tables",
                  "value": true,
                  "checked": showOnlyAvailable,
                }
              ],
              value: [
                if (showOnlyAvailable)
                  {
                    "label": "Show only available tables",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showOnlyAvailable = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Tables Grid
            Text(
              "Tables (${filteredTables.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredTables.map((table) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: _getStatusColor(table["status"]),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Table Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(table["status"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Table ${table["number"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${table["capacity"]} seats",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Table Info
                      Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.category, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${table["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.info_outline, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${table["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getStatusColor(table["status"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          if (table["guest"] != null) ...[
                            Row(
                              children: [
                                Icon(Icons.person, size: 14, color: disabledBoldColor),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${table["guest"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (table["reservationTime"] != null) ...[
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                SizedBox(width: 4),
                                Text(
                                  "${table["reservationTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (table["estimatedTurnover"] != null) ...[
                            Row(
                              children: [
                                Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                                SizedBox(width: 4),
                                Text(
                                  "Est. ${table["estimatedTurnover"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),

                      // Action Buttons
                      if (table["status"] == "Available") ...[
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Assign Table",
                            size: bs.sm,
                            onPressed: () => _assignTable(table),
                          ),
                        ),
                      ] else if (table["status"] == "Occupied") ...[
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Clear Table",
                            size: bs.sm,
                            onPressed: () => _clearTable(table),
                          ),
                        ),
                      ] else if (table["status"] == "Cleaning") ...[
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Mark Available",
                            size: bs.sm,
                            onPressed: () => _markAvailable(table),
                          ),
                        ),
                      ] else if (table["status"] == "Reserved") ...[
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Seat Guests",
                            size: bs.sm,
                            onPressed: () => _assignTable(table),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
