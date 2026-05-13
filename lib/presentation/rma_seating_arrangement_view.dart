import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaSeatingArrangementView extends StatefulWidget {
  const RmaSeatingArrangementView({super.key});

  @override
  State<RmaSeatingArrangementView> createState() => _RmaSeatingArrangementViewState();
}

class _RmaSeatingArrangementViewState extends State<RmaSeatingArrangementView> {
  String selectedFloor = "ground";
  String viewMode = "overview";
  bool showReservations = true;
  
  List<Map<String, dynamic>> tables = [
    {
      "id": "T-01",
      "number": "01",
      "seats": 2,
      "type": "booth",
      "status": "occupied",
      "floor": "ground",
      "x": 50.0,
      "y": 100.0,
      "width": 80.0,
      "height": 60.0,
      "customerName": "John Smith",
      "partySize": 2,
      "orderTime": "18:30",
      "estimatedFinish": "20:00",
      "server": "Alice",
    },
    {
      "id": "T-02",
      "number": "02",
      "seats": 4,
      "type": "standard",
      "status": "reserved",
      "floor": "ground",
      "x": 150.0,
      "y": 100.0,
      "width": 100.0,
      "height": 80.0,
      "customerName": "Sarah Wilson",
      "partySize": 4,
      "reservationTime": "19:00",
      "server": "Bob",
    },
    {
      "id": "T-03",
      "number": "03",
      "seats": 6,
      "type": "large",
      "status": "available",
      "floor": "ground",
      "x": 270.0,
      "y": 100.0,
      "width": 120.0,
      "height": 100.0,
      "customerName": null,
      "partySize": null,
      "server": null,
    },
    {
      "id": "T-04",
      "number": "04",
      "seats": 2,
      "type": "window",
      "status": "cleaning",
      "floor": "ground",
      "x": 50.0,
      "y": 220.0,
      "width": 80.0,
      "height": 60.0,
      "customerName": null,
      "partySize": null,
      "server": null,
    },
    {
      "id": "T-05",
      "number": "05",
      "seats": 4,
      "type": "standard",
      "status": "occupied",
      "floor": "ground",
      "x": 150.0,
      "y": 220.0,
      "width": 100.0,
      "height": 80.0,
      "customerName": "Mike Johnson",
      "partySize": 3,
      "orderTime": "19:15",
      "estimatedFinish": "20:45",
      "server": "Carol",
    },
    {
      "id": "T-06",
      "number": "06",
      "seats": 8,
      "type": "private",
      "status": "reserved",
      "floor": "upper",
      "x": 50.0,
      "y": 100.0,
      "width": 140.0,
      "height": 120.0,
      "customerName": "Corporate Event",
      "partySize": 8,
      "reservationTime": "18:00",
      "server": "David",
    },
    {
      "id": "T-07",
      "number": "07",
      "seats": 4,
      "type": "booth",
      "status": "available",
      "floor": "upper",
      "x": 220.0,
      "y": 100.0,
      "width": 100.0,
      "height": 80.0,
      "customerName": null,
      "partySize": null,
      "server": null,
    },
    {
      "id": "T-08",
      "number": "08",
      "seats": 2,
      "type": "bar",
      "status": "occupied",
      "floor": "ground",
      "x": 270.0,
      "y": 220.0,
      "width": 60.0,
      "height": 120.0,
      "customerName": "Lisa Brown",
      "partySize": 1,
      "orderTime": "19:45",
      "estimatedFinish": "21:00",
      "server": "Eva",
    },
  ];

  List<Map<String, dynamic>> floorOptions = [
    {"label": "Ground Floor", "value": "ground"},
    {"label": "Upper Floor", "value": "upper"},
    {"label": "Private Rooms", "value": "private"},
  ];

  List<Map<String, dynamic>> viewModeOptions = [
    {"label": "Overview", "value": "overview"},
    {"label": "Detailed", "value": "detailed"},
    {"label": "Server View", "value": "server"},
  ];

  Widget _buildFloorStats() {
    final floorTables = tables.where((t) => t["floor"] == selectedFloor).toList();
    final occupiedTables = floorTables.where((t) => t["status"] == "occupied").length;
    final reservedTables = floorTables.where((t) => t["status"] == "reserved").length;
    final availableTables = floorTables.where((t) => t["status"] == "available").length;
    final occupancyRate = floorTables.isNotEmpty ? (occupiedTables / floorTables.length * 100).round() : 0;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Floor Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatCard(
                "Occupied",
                "$occupiedTables",
                Icons.event_seat,
                dangerColor,
              ),
              _buildStatCard(
                "Reserved",
                "$reservedTables",
                Icons.book_online,
                warningColor,
              ),
              _buildStatCard(
                "Available",
                "$availableTables",
                Icons.check_circle,
                successColor,
              ),
              _buildStatCard(
                "Occupancy",
                "$occupancyRate%",
                Icons.trending_up,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: QDropdownField(
                  label: "Floor",
                  items: floorOptions,
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
                  label: "View Mode",
                  items: viewModeOptions,
                  value: viewMode,
                  onChanged: (value, label) {
                    viewMode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Reservations",
                      "value": true,
                      "checked": showReservations,
                    }
                  ],
                  value: [
                    if (showReservations)
                      {
                        "label": "Show Reservations",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showReservations = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloorPlan() {
    final floorTables = tables.where((t) => t["floor"] == selectedFloor).toList();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Floor Plan - ${selectedFloor == "ground" ? "Ground Floor" : selectedFloor == "upper" ? "Upper Floor" : "Private Rooms"}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Edit Layout",
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('EditFloorPlan')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.grey.withAlpha(50)),
            ),
            child: Stack(
              children: [
                // Background elements (kitchen, bar, entrance)
                if (selectedFloor == "ground") ...[
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Container(
                      width: 80,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "Kitchen",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Container(
                      width: 60,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.brown.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "Bar",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                // Tables
                ...floorTables.map((table) => _buildTableWidget(table)).toList(),
                // Legend
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: _buildLegend(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableWidget(Map<String, dynamic> table) {
    final statusColor = table["status"] == "occupied" ? dangerColor :
                       table["status"] == "reserved" ? warningColor :
                       table["status"] == "available" ? successColor :
                       table["status"] == "cleaning" ? infoColor :
                       disabledBoldColor;

    final typeIcon = table["type"] == "booth" ? Icons.chair :
                    table["type"] == "window" ? Icons.window :
                    table["type"] == "bar" ? Icons.wine_bar :
                    table["type"] == "private" ? Icons.meeting_room :
                    Icons.table_restaurant;

    return Positioned(
      left: table["x"],
      top: table["y"],
      child: GestureDetector(
        onTap: () {
          _showTableDetails(table);
        },
        child: Container(
          width: table["width"],
          height: table["height"],
          decoration: BoxDecoration(
            color: statusColor.withAlpha(40),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: statusColor, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                typeIcon,
                color: statusColor,
                size: viewMode == "detailed" ? 24 : 16,
              ),
              SizedBox(height: spXs),
              Text(
                table["number"],
                style: TextStyle(
                  fontSize: viewMode == "detailed" ? 14 : 12,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              if (viewMode == "detailed" && table["customerName"] != null) ...[
                SizedBox(height: spXs),
                Text(
                  "${table["customerName"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (viewMode == "server" && table["server"] != null) ...[
                SizedBox(height: spXs),
                Text(
                  "${table["server"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(230),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Legend:",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          _buildLegendItem("Occupied", dangerColor),
          _buildLegendItem("Reserved", warningColor),
          _buildLegendItem("Available", successColor),
          _buildLegendItem("Cleaning", infoColor),
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
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTableList() {
    final floorTables = tables.where((t) => t["floor"] == selectedFloor).toList();
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Table List",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...floorTables.map((table) => _buildTableListItem(table)).toList(),
        ],
      ),
    );
  }

  Widget _buildTableListItem(Map<String, dynamic> table) {
    final statusColor = table["status"] == "occupied" ? dangerColor :
                       table["status"] == "reserved" ? warningColor :
                       table["status"] == "available" ? successColor :
                       infoColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                table["number"],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                      "${table["seats"]} seats • ${table["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${table["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                if (table["customerName"] != null) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${table["customerName"]} (${table["partySize"]} guests)",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
                if (table["server"] != null) ...[
                  SizedBox(height: spXs),
                  Text(
                    "Server: ${table["server"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              _showTableOptions(table);
            },
          ),
        ],
      ),
    );
  }

  void _showTableDetails(Map<String, dynamic> table) {
    // Show table details modal
  }

  void _showTableOptions(Map<String, dynamic> table) {
    // Show table options menu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seating Arrangement"),
        actions: [
          IconButton(
            icon: Icon(Icons.fullscreen),
            onPressed: () {
              //navigateTo('FullscreenFloorPlan')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('SeatingSettings')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFloorStats(),
            _buildControls(),
            _buildFloorPlan(),
            _buildTableList(),
          ],
        ),
      ),
    );
  }
}
