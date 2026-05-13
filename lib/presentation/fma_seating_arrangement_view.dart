import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaSeatingArrangementView extends StatefulWidget {
  const FmaSeatingArrangementView({super.key});

  @override
  State<FmaSeatingArrangementView> createState() => _FmaSeatingArrangementViewState();
}

class _FmaSeatingArrangementViewState extends State<FmaSeatingArrangementView> {
  int currentTab = 0;
  String selectedFloor = "Ground Floor";
  String selectedSection = "All";
  bool editMode = false;
  
  List<Map<String, dynamic>> floors = [
    {"label": "Ground Floor", "value": "Ground Floor"},
    {"label": "Second Floor", "value": "Second Floor"},
    {"label": "Terrace", "value": "Terrace"},
    {"label": "Private Dining", "value": "Private Dining"},
  ];
  
  List<Map<String, dynamic>> sections = [
    {"label": "All", "value": "All"},
    {"label": "Main Dining", "value": "Main Dining"},
    {"label": "Bar Area", "value": "Bar Area"},
    {"label": "Window Side", "value": "Window Side"},
    {"label": "Private Booths", "value": "Private Booths"},
  ];

  List<Map<String, dynamic>> tables = [
    {
      "id": "T001",
      "number": 1,
      "seats": 4,
      "section": "Main Dining",
      "floor": "Ground Floor",
      "status": "Available",
      "x": 100.0,
      "y": 150.0,
      "width": 80.0,
      "height": 80.0,
      "shape": "Square",
      "features": ["Near Window", "High Chair Available"],
    },
    {
      "id": "T002",
      "number": 2,
      "seats": 2,
      "section": "Window Side",
      "floor": "Ground Floor",
      "status": "Occupied",
      "x": 220.0,
      "y": 150.0,
      "width": 60.0,
      "height": 60.0,
      "shape": "Round",
      "features": ["Romantic Setting", "Garden View"],
    },
    {
      "id": "T003",
      "number": 3,
      "seats": 6,
      "section": "Main Dining",
      "floor": "Ground Floor",
      "status": "Reserved",
      "x": 100.0,
      "y": 280.0,
      "width": 120.0,
      "height": 80.0,
      "shape": "Rectangle",
      "features": ["Family Friendly", "Baby Chair Available"],
    },
    {
      "id": "B001",
      "number": 4,
      "seats": 8,
      "section": "Private Booths",
      "floor": "Ground Floor",
      "status": "Available",
      "x": 300.0,
      "y": 200.0,
      "width": 100.0,
      "height": 120.0,
      "shape": "Booth",
      "features": ["Privacy Screen", "Premium Location"],
    },
  ];

  Color _getTableColor(String status) {
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

  Widget _buildFloorPlan() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Stack(
        children: [
          // Floor elements (walls, doors, etc.)
          Positioned(
            left: 50,
            top: 50,
            right: 50,
            bottom: 50,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: disabledBoldColor, width: 2),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
          ),
          // Entrance
          Positioned(
            left: 180,
            top: 50,
            child: Container(
              width: 40,
              height: 4,
              color: primaryColor,
              child: Center(
                child: Text("ENTRANCE", style: TextStyle(fontSize: 8, color: Colors.white)),
              ),
            ),
          ),
          // Tables
          ...tables.where((table) => table["floor"] == selectedFloor && (selectedSection == "All" || table["section"] == selectedSection)).map((table) {
            return Positioned(
              left: table["x"],
              top: table["y"],
              child: GestureDetector(
                onTap: () => _showTableDetails(table),
                child: Container(
                  width: table["width"],
                  height: table["height"],
                  decoration: BoxDecoration(
                    color: _getTableColor(table["status"]).withAlpha(100),
                    border: Border.all(color: _getTableColor(table["status"]), width: 2),
                    borderRadius: table["shape"] == "Round" 
                        ? BorderRadius.circular(table["width"] / 2)
                        : BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "T${table["number"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getTableColor(table["status"]),
                        ),
                      ),
                      Text(
                        "${table["seats"]} seats",
                        style: TextStyle(
                          fontSize: 8,
                          color: _getTableColor(table["status"]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          // Legend
          Positioned(
            right: spMd,
            bottom: spMd,
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Legend", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  SizedBox(height: spXs),
                  _buildLegendItem("Available", successColor),
                  _buildLegendItem("Occupied", dangerColor),
                  _buildLegendItem("Reserved", warningColor),
                  _buildLegendItem("Cleaning", infoColor),
                ],
              ),
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
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withAlpha(100),
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    );
  }

  void _showTableDetails(Map<String, dynamic> table) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Table ${table["number"]} Details"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Seats: ${table["seats"]}"),
            Text("Section: ${table["section"]}"),
            Text("Status: ${table["status"]}"),
            Text("Shape: ${table["shape"]}"),
            SizedBox(height: spSm),
            Text("Features:", style: TextStyle(fontWeight: FontWeight.bold)),
            ...(table["features"] as List).map((feature) => Text("• $feature")),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTablesList() {
    final filteredTables = tables.where((table) => 
      table["floor"] == selectedFloor && 
      (selectedSection == "All" || table["section"] == selectedSection)
    ).toList();

    return Column(
      children: [
        Row(
          children: [
            Text("Tables (${filteredTables.length})", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
            Spacer(),
            QButton(
              label: "Add Table",
              size: bs.sm,
              icon: Icons.add,
              onPressed: () {
                // Add new table
              },
            ),
          ],
        ),
        SizedBox(height: spMd),
        Expanded(
          child: ListView.builder(
            itemCount: filteredTables.length,
            itemBuilder: (context, index) {
              final table = filteredTables[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _getTableColor(table["status"]).withAlpha(100),
                        border: Border.all(color: _getTableColor(table["status"])),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "T${table["number"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getTableColor(table["status"]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Table ${table["number"]}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getTableColor(table["status"]).withAlpha(100),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${table["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getTableColor(table["status"]),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${table["seats"]} seats • ${table["section"]} • ${table["shape"]}",
                            style: TextStyle(color: disabledBoldColor, fontSize: 12),
                          ),
                          if ((table["features"] as List).isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: spXs),
                              child: Text(
                                (table["features"] as List).join(", "),
                                style: TextStyle(color: disabledColor, fontSize: 10),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        // Edit table
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionManagement() {
    return Column(
      children: [
        Row(
          children: [
            Text("Sections Management", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
            Spacer(),
            QButton(
              label: "Add Section",
              size: bs.sm,
              icon: Icons.add,
              onPressed: () {
                // Add new section
              },
            ),
          ],
        ),
        SizedBox(height: spMd),
        Expanded(
          child: ListView.builder(
            itemCount: sections.length - 1, // Exclude "All"
            itemBuilder: (context, index) {
              final section = sections[index + 1];
              final sectionTables = tables.where((table) => table["section"] == section["value"]).toList();
              final availableTables = sectionTables.where((table) => table["status"] == "Available").length;
              final occupiedTables = sectionTables.where((table) => table["status"] == "Occupied").length;
              final reservedTables = sectionTables.where((table) => table["status"] == "Reserved").length;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.restaurant, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${section["label"]}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fsH6),
                          ),
                        ),
                        QButton(
                          icon: Icons.settings,
                          size: bs.sm,
                          onPressed: () {
                            // Configure section
                          },
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
                              Text("Total Tables", style: TextStyle(fontSize: 10, color: disabledBoldColor)),
                              Text("${sectionTables.length}", style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Available", style: TextStyle(fontSize: 10, color: successColor)),
                              Text("$availableTables", style: TextStyle(fontWeight: FontWeight.bold, color: successColor)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Occupied", style: TextStyle(fontSize: 10, color: dangerColor)),
                              Text("$occupiedTables", style: TextStyle(fontWeight: FontWeight.bold, color: dangerColor)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Reserved", style: TextStyle(fontSize: 10, color: warningColor)),
                              Text("$reservedTables", style: TextStyle(fontWeight: FontWeight.bold, color: warningColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          if (availableTables > 0)
                            Expanded(
                              flex: availableTables,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusXs),
                                    bottomLeft: Radius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          if (occupiedTables > 0)
                            Expanded(
                              flex: occupiedTables,
                              child: Container(color: dangerColor),
                            ),
                          if (reservedTables > 0)
                            Expanded(
                              flex: reservedTables,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(radiusXs),
                                    bottomRight: Radius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Seating Arrangement",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Floor Plan", icon: Icon(Icons.map)),
        Tab(text: "Tables", icon: Icon(Icons.table_restaurant)),
        Tab(text: "Sections", icon: Icon(Icons.view_module)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Controls
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Floor",
                      items: floors,
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
                      label: "Section",
                      items: sections,
                      value: selectedSection,
                      onChanged: (value, label) {
                        selectedSection = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: editMode ? Icons.save : Icons.edit,
                    size: bs.sm,
                    onPressed: () {
                      editMode = !editMode;
                      setState(() {});
                    },
                  ),
                ],
              ),
              
              // Floor Plan
              _buildFloorPlan(),
              
              // Floor Statistics
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Text("Available", style: TextStyle(color: successColor, fontSize: 12)),
                          Text("${tables.where((t) => t["status"] == "Available").length}", 
                               style: TextStyle(color: successColor, fontWeight: FontWeight.bold, fontSize: fsH6)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: dangerColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Text("Occupied", style: TextStyle(color: dangerColor, fontSize: 12)),
                          Text("${tables.where((t) => t["status"] == "Occupied").length}", 
                               style: TextStyle(color: dangerColor, fontWeight: FontWeight.bold, fontSize: fsH6)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(50)),
                      ),
                      child: Column(
                        children: [
                          Text("Reserved", style: TextStyle(color: warningColor, fontSize: 12)),
                          Text("${tables.where((t) => t["status"] == "Reserved").length}", 
                               style: TextStyle(color: warningColor, fontWeight: FontWeight.bold, fontSize: fsH6)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              // Filter Controls
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Floor",
                      items: floors,
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
                      label: "Section",
                      items: sections,
                      value: selectedSection,
                      onChanged: (value, label) {
                        selectedSection = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Expanded(child: _buildTablesList()),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(spMd),
          child: _buildSectionManagement(),
        ),
      ],
    );
  }
}
