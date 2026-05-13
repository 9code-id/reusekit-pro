import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsFloorPlanView extends StatefulWidget {
  const RfsFloorPlanView({super.key});

  @override
  State<RfsFloorPlanView> createState() => _RfsFloorPlanViewState();
}

class _RfsFloorPlanViewState extends State<RfsFloorPlanView> {
  int currentTab = 0;
  String selectedFloor = "Ground Floor";
  String selectedView = "Current Status";
  bool showTableNumbers = true;
  bool showCapacity = true;
  bool showServerAssignments = false;

  List<String> floorOptions = ["Ground Floor", "Second Floor", "Rooftop"];
  List<String> viewOptions = ["Current Status", "Reservations", "Server Zones"];

  Map<String, List<Map<String, dynamic>>> floorPlans = {
    "Ground Floor": [
      {
        "id": "section_1",
        "name": "Main Dining Hall",
        "x": 50,
        "y": 50,
        "width": 400,
        "height": 300,
        "color": 0xFF2196F3,
        "tables": [
          {"id": 1, "number": "T01", "x": 80, "y": 80, "capacity": 4, "status": "Occupied", "shape": "round", "server": "Sarah"},
          {"id": 2, "number": "T02", "x": 180, "y": 80, "capacity": 2, "status": "Available", "shape": "square", "server": null},
          {"id": 3, "number": "T03", "x": 280, "y": 80, "capacity": 6, "status": "Reserved", "shape": "rectangle", "server": "Mike"},
          {"id": 4, "number": "T04", "x": 380, "y": 80, "capacity": 4, "status": "Occupied", "shape": "round", "server": "Emma"},
          {"id": 5, "number": "T05", "x": 80, "y": 180, "capacity": 2, "status": "Cleaning", "shape": "square", "server": null},
          {"id": 6, "number": "T06", "x": 180, "y": 180, "capacity": 4, "status": "Available", "shape": "round", "server": null},
          {"id": 7, "number": "T07", "x": 280, "y": 180, "capacity": 8, "status": "Occupied", "shape": "rectangle", "server": "David"},
          {"id": 8, "number": "T08", "x": 380, "y": 180, "capacity": 2, "status": "Available", "shape": "square", "server": null},
          {"id": 9, "number": "T09", "x": 80, "y": 280, "capacity": 4, "status": "Occupied", "shape": "round", "server": "Sarah"},
          {"id": 10, "number": "T10", "x": 180, "y": 280, "capacity": 6, "status": "Reserved", "shape": "rectangle", "server": "Mike"},
        ]
      },
      {
        "id": "section_2",
        "name": "Patio Area",
        "x": 500,
        "y": 50,
        "width": 250,
        "height": 200,
        "color": 0xFF4CAF50,
        "tables": [
          {"id": 11, "number": "P01", "x": 530, "y": 80, "capacity": 4, "status": "Occupied", "shape": "round", "server": "Emma"},
          {"id": 12, "number": "P02", "x": 630, "y": 80, "capacity": 2, "status": "Available", "shape": "square", "server": null},
          {"id": 13, "number": "P03", "x": 530, "y": 150, "capacity": 6, "status": "Available", "shape": "rectangle", "server": null},
          {"id": 14, "number": "P04", "x": 630, "y": 150, "capacity": 4, "status": "Reserved", "shape": "round", "server": "David"},
        ]
      },
      {
        "id": "section_3",
        "name": "Bar Area",
        "x": 50,
        "y": 400,
        "width": 300,
        "height": 150,
        "color": 0xFFFF9800,
        "tables": [
          {"id": 15, "number": "B01", "x": 80, "y": 430, "capacity": 3, "status": "Occupied", "shape": "round", "server": "Sarah"},
          {"id": 16, "number": "B02", "x": 150, "y": 430, "capacity": 3, "status": "Available", "shape": "round", "server": null},
          {"id": 17, "number": "B03", "x": 220, "y": 430, "capacity": 4, "status": "Occupied", "shape": "rectangle", "server": "Mike"},
          {"id": 18, "number": "B04", "x": 290, "y": 430, "capacity": 2, "status": "Available", "shape": "square", "server": null},
        ]
      }
    ],
    "Second Floor": [
      {
        "id": "section_4",
        "name": "Private Dining",
        "x": 50,
        "y": 50,
        "width": 400,
        "height": 250,
        "color": 0xFF9C27B0,
        "tables": [
          {"id": 19, "number": "PD01", "x": 100, "y": 100, "capacity": 8, "status": "Reserved", "shape": "rectangle", "server": "Emma"},
          {"id": 20, "number": "PD02", "x": 300, "y": 100, "capacity": 10, "status": "Available", "shape": "rectangle", "server": null},
          {"id": 21, "number": "PD03", "x": 100, "y": 200, "capacity": 6, "status": "Occupied", "shape": "rectangle", "server": "David"},
          {"id": 22, "number": "PD04", "x": 300, "y": 200, "capacity": 12, "status": "Available", "shape": "rectangle", "server": null},
        ]
      },
      {
        "id": "section_5",
        "name": "VIP Lounge",
        "x": 500,
        "y": 50,
        "width": 250,
        "height": 250,
        "color": 0xFFE91E63,
        "tables": [
          {"id": 23, "number": "VIP01", "x": 550, "y": 100, "capacity": 4, "status": "Occupied", "shape": "round", "server": "Sarah"},
          {"id": 24, "number": "VIP02", "x": 650, "y": 100, "capacity": 4, "status": "Reserved", "shape": "round", "server": "Mike"},
          {"id": 25, "number": "VIP03", "x": 550, "y": 200, "capacity": 6, "status": "Available", "shape": "rectangle", "server": null},
          {"id": 26, "number": "VIP04", "x": 650, "y": 200, "capacity": 2, "status": "Available", "shape": "square", "server": null},
        ]
      }
    ],
    "Rooftop": [
      {
        "id": "section_6",
        "name": "Rooftop Terrace",
        "x": 50,
        "y": 50,
        "width": 500,
        "height": 300,
        "color": 0xFF607D8B,
        "tables": [
          {"id": 27, "number": "RT01", "x": 100, "y": 100, "capacity": 4, "status": "Available", "shape": "round", "server": null},
          {"id": 28, "number": "RT02", "x": 200, "y": 100, "capacity": 4, "status": "Available", "shape": "round", "server": null},
          {"id": 29, "number": "RT03", "x": 300, "y": 100, "capacity": 6, "status": "Occupied", "shape": "rectangle", "server": "Emma"},
          {"id": 30, "number": "RT04", "x": 400, "y": 100, "capacity": 4, "status": "Available", "shape": "round", "server": null},
          {"id": 31, "number": "RT05", "x": 100, "y": 200, "capacity": 8, "status": "Reserved", "shape": "rectangle", "server": "David"},
          {"id": 32, "number": "RT06", "x": 300, "y": 200, "capacity": 2, "status": "Available", "shape": "square", "server": null},
          {"id": 33, "number": "RT07", "x": 400, "y": 200, "capacity": 4, "status": "Available", "shape": "round", "server": null},
        ]
      }
    ]
  };

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Occupied":
        return warningColor;
      case "Reserved":
        return infoColor;
      case "Cleaning":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getServerColor(String? server) {
    switch (server) {
      case "Sarah":
        return Color(0xFF2196F3);
      case "Mike":
        return Color(0xFF4CAF50);
      case "Emma":
        return Color(0xFFFF9800);
      case "David":
        return Color(0xFF9C27B0);
      default:
        return disabledColor;
    }
  }

  Widget _buildTable(Map<String, dynamic> table) {
    Color statusColor = _getStatusColor(table["status"]);
    Color serverColor = _getServerColor(table["server"]);
    
    double size = 40;
    if (table["capacity"] >= 8) size = 60;
    else if (table["capacity"] >= 6) size = 50;
    
    Widget tableWidget;
    
    switch (table["shape"]) {
      case "round":
        tableWidget = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: selectedView == "Server Zones" && table["server"] != null 
                ? serverColor.withAlpha(200) 
                : statusColor.withAlpha(200),
            shape: BoxShape.circle,
            border: Border.all(
              color: selectedView == "Server Zones" && table["server"] != null 
                  ? serverColor 
                  : statusColor,
              width: 2,
            ),
          ),
          child: _buildTableContent(table, statusColor),
        );
        break;
      case "square":
        tableWidget = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: selectedView == "Server Zones" && table["server"] != null 
                ? serverColor.withAlpha(200) 
                : statusColor.withAlpha(200),
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(
              color: selectedView == "Server Zones" && table["server"] != null 
                  ? serverColor 
                  : statusColor,
              width: 2,
            ),
          ),
          child: _buildTableContent(table, statusColor),
        );
        break;
      case "rectangle":
        tableWidget = Container(
          width: size + 20,
          height: size - 10,
          decoration: BoxDecoration(
            color: selectedView == "Server Zones" && table["server"] != null 
                ? serverColor.withAlpha(200) 
                : statusColor.withAlpha(200),
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(
              color: selectedView == "Server Zones" && table["server"] != null 
                  ? serverColor 
                  : statusColor,
              width: 2,
            ),
          ),
          child: _buildTableContent(table, statusColor),
        );
        break;
      default:
        tableWidget = Container();
    }
    
    return Positioned(
      left: (table["x"] as int).toDouble(),
      top: (table["y"] as int).toDouble(),
      child: GestureDetector(
        onTap: () => _showTableInfo(table),
        child: tableWidget,
      ),
    );
  }

  Widget _buildTableContent(Map<String, dynamic> table, Color statusColor) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTableNumbers)
            Text(
              "${table["number"]}",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          if (showCapacity)
            Text(
              "${table["capacity"]}",
              style: TextStyle(
                fontSize: 8,
                color: Colors.white,
              ),
            ),
          if (showServerAssignments && table["server"] != null)
            Text(
              "${table["server"]![0]}",
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  void _showTableInfo(Map<String, dynamic> table) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Table ${table["number"]}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow("Capacity", "${table["capacity"]} guests"),
              _buildDetailRow("Status", "${table["status"]}"),
              _buildDetailRow("Shape", "${table["shape"]}"),
              if (table["server"] != null)
                _buildDetailRow("Server", "${table["server"]}"),
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(table["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Status: ${table["status"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(table["status"]),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(color: disabledBoldColor)),
        ],
      ),
    );
  }

  Widget _buildFloorPlanTab() {
    List<Map<String, dynamic>> currentFloorSections = floorPlans[selectedFloor] ?? [];
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Floor Plan - $selectedFloor", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spSm),
          
          // Floor and View Selection
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Floor",
                  items: floorOptions.map((floor) => {"label": floor, "value": floor}).toList(),
                  value: selectedFloor,
                  onChanged: (value, label) {
                    selectedFloor = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "View",
                  items: viewOptions.map((view) => {"label": view, "value": view}).toList(),
                  value: selectedView,
                  onChanged: (value, label) {
                    selectedView = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Display Options
          Column(
            children: [
              QSwitch(
                items: [
                  {
                    "label": "Show table numbers",
                    "value": "numbers",
                    "checked": showTableNumbers,
                  }
                ],
                value: [if (showTableNumbers) {"label": "Show table numbers", "value": "numbers", "checked": true}],
                onChanged: (values, ids) {
                  showTableNumbers = values.isNotEmpty;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "Show capacity",
                    "value": "capacity",
                    "checked": showCapacity,
                  }
                ],
                value: [if (showCapacity) {"label": "Show capacity", "value": "capacity", "checked": true}],
                onChanged: (values, ids) {
                  showCapacity = values.isNotEmpty;
                  setState(() {});
                },
              ),
              if (selectedView == "Server Zones")
                QSwitch(
                  items: [
                    {
                      "label": "Show server initials",
                      "value": "servers",
                      "checked": showServerAssignments,
                    }
                  ],
                  value: [if (showServerAssignments) {"label": "Show server initials", "value": "servers", "checked": true}],
                  onChanged: (values, ids) {
                    showServerAssignments = values.isNotEmpty;
                    setState(() {});
                  },
                ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Legend
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Legend", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                if (selectedView == "Server Zones") ...[
                  Wrap(
                    spacing: spSm,
                    runSpacing: spXs,
                    children: [
                      _buildLegendItem("Sarah", _getServerColor("Sarah")),
                      _buildLegendItem("Mike", _getServerColor("Mike")),
                      _buildLegendItem("Emma", _getServerColor("Emma")),
                      _buildLegendItem("David", _getServerColor("David")),
                    ],
                  ),
                ] else ...[
                  Wrap(
                    spacing: spSm,
                    runSpacing: spXs,
                    children: [
                      _buildLegendItem("Available", successColor),
                      _buildLegendItem("Occupied", warningColor),
                      _buildLegendItem("Reserved", infoColor),
                      _buildLegendItem("Cleaning", dangerColor),
                    ],
                  ),
                ],
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Floor Plan
          Container(
            width: double.infinity,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Stack(
              children: [
                // Sections
                ...currentFloorSections.map((section) {
                  return Positioned(
                    left: (section["x"] as int).toDouble(),
                    top: (section["y"] as int).toDouble(),
                    child: Container(
                      width: (section["width"] as int).toDouble(),
                      height: (section["height"] as int).toDouble(),
                      decoration: BoxDecoration(
                        color: Color(section["color"]).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: Color(section["color"]),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(spXs),
                        child: Text(
                          "${section["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(section["color"]),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                
                // Tables
                ...currentFloorSections.expand((section) {
                  return (section["tables"] as List<Map<String, dynamic>>).map((table) {
                    return _buildTable(table);
                  });
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildStatsTab() {
    Map<String, int> statusCounts = {};
    Map<String, int> serverCounts = {};
    int totalTables = 0;
    int totalCapacity = 0;
    
    for (var floorSections in floorPlans.values) {
      for (var section in floorSections) {
        for (var table in section["tables"]) {
          totalTables++;
          totalCapacity += table["capacity"] as int;
          
          String status = table["status"];
          statusCounts[status] = (statusCounts[status] ?? 0) + 1;
          
          String? server = table["server"];
          if (server != null) {
            serverCounts[server] = (serverCounts[server] ?? 0) + 1;
          }
        }
      }
    }
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Restaurant Statistics", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spMd),
          
          // Overall Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$totalTables",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                      Text("Total Tables", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
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
                        "$totalCapacity",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: infoColor),
                      ),
                      Text("Total Capacity", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
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
                        "${floorOptions.length}",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: successColor),
                      ),
                      Text("Floors", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Status Breakdown
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Table Status", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                ...statusCounts.entries.map((entry) {
                  String status = entry.key;
                  int count = entry.value;
                  double percentage = (count / totalTables) * 100;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _getStatusColor(status),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(status, style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Text("$count tables", style: TextStyle(color: disabledBoldColor)),
                        SizedBox(width: spSm),
                        Text("${percentage.toStringAsFixed(1)}%", 
                             style: TextStyle(fontWeight: FontWeight.bold, color: _getStatusColor(status))),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Server Assignments
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Server Assignments", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                ...serverCounts.entries.map((entry) {
                  String server = entry.key;
                  int count = entry.value;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getServerColor(server).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: _getServerColor(server),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Center(
                            child: Text(
                              server[0],
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(server, style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Text("$count tables", style: TextStyle(fontWeight: FontWeight.bold, color: _getServerColor(server))),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Floor Breakdown
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Floor Breakdown", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                ...floorOptions.map((floor) {
                  List<Map<String, dynamic>> floorSections = floorPlans[floor] ?? [];
                  int floorTables = floorSections.fold(0, (sum, section) => sum + (section["tables"] as List).length);
                  int floorCapacity = floorSections.fold(0, (sum, section) => 
                      sum + (section["tables"] as List).fold(0, (tableSum, table) => tableSum + (table["capacity"] as int)));
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(floor, style: TextStyle(fontWeight: FontWeight.w600)),
                              Text("$floorTables tables • $floorCapacity capacity", 
                                   style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                            ],
                          ),
                        ),
                        Text("${floorSections.length} sections", 
                             style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)),
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

  Widget _buildLayoutTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Layout Management", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spMd),
          
          // Quick Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quick Actions", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add Table",
                        size: bs.sm,
                        icon: Icons.add,
                        onPressed: () => ss("Add table functionality"),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Edit Layout",
                        size: bs.sm,
                        icon: Icons.edit,
                        onPressed: () => ss("Edit layout functionality"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save Layout",
                        size: bs.sm,
                        icon: Icons.save,
                        onPressed: () => ss("Layout saved successfully"),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Reset Layout",
                        size: bs.sm,
                        icon: Icons.refresh,
                        onPressed: () => ss("Layout reset to default"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Section Management
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Section Management", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                
                ...floorPlans[selectedFloor]!.map((section) {
                  List<Map<String, dynamic>> sectionTables = section["tables"];
                  int occupiedTables = sectionTables.where((t) => t["status"] == "Occupied").length;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Color(section["color"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Color(section["color"]),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text("${section["name"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Text("$occupiedTables/${sectionTables.length} occupied", 
                                 style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Expanded(
                              child: Text("${sectionTables.length} tables", 
                                         style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                            ),
                            Text("${sectionTables.fold(0, (sum, table) => sum + (table["capacity"] as int))} capacity", 
                                 style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Floor Plan",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Floor Plan", icon: Icon(Icons.map)),
        Tab(text: "Statistics", icon: Icon(Icons.analytics)),
        Tab(text: "Layout", icon: Icon(Icons.design_services)),
      ],
      tabChildren: [
        _buildFloorPlanTab(),
        _buildStatsTab(),
        _buildLayoutTab(),
      ],
    );
  }
}
