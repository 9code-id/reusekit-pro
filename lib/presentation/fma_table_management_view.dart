import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaTableManagementView extends StatefulWidget {
  const FmaTableManagementView({super.key});

  @override
  State<FmaTableManagementView> createState() => _FmaTableManagementViewState();
}

class _FmaTableManagementViewState extends State<FmaTableManagementView> {
  int currentTab = 0;
  String selectedStatus = "All";
  String selectedSection = "All";
  bool isGridView = true;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All"},
    {"label": "Available", "value": "available"},
    {"label": "Occupied", "value": "occupied"},
    {"label": "Reserved", "value": "reserved"},
    {"label": "Cleaning", "value": "cleaning"},
    {"label": "Maintenance", "value": "maintenance"},
  ];

  List<Map<String, dynamic>> sectionOptions = [
    {"label": "All Sections", "value": "All"},
    {"label": "Main Dining", "value": "main_dining"},
    {"label": "Patio", "value": "patio"},
    {"label": "Private Room", "value": "private_room"},
    {"label": "Bar Area", "value": "bar_area"},
  ];

  List<Map<String, dynamic>> tables = [
    {
      "id": "T001",
      "number": "1",
      "section": "main_dining",
      "capacity": 4,
      "status": "occupied",
      "current_party": 3,
      "server": "Alice Johnson",
      "order_total": 67.50,
      "seated_time": "2024-06-15 18:30",
      "estimated_turnover": "2024-06-15 19:45",
      "order_id": "ORD001",
      "x_position": 50,
      "y_position": 100,
    },
    {
      "id": "T002",
      "number": "2",
      "section": "main_dining",
      "capacity": 2,
      "status": "available",
      "current_party": 0,
      "server": "",
      "order_total": 0.0,
      "seated_time": "",
      "estimated_turnover": "",
      "order_id": "",
      "x_position": 150,
      "y_position": 100,
    },
    {
      "id": "T003",
      "number": "3",
      "section": "patio",
      "capacity": 6,
      "status": "reserved",
      "current_party": 0,
      "server": "Bob Smith",
      "order_total": 0.0,
      "seated_time": "",
      "estimated_turnover": "2024-06-15 19:30",
      "order_id": "",
      "x_position": 250,
      "y_position": 200,
      "reservation_name": "Wilson Party",
      "reservation_time": "2024-06-15 19:30",
    },
    {
      "id": "T004",
      "number": "4",
      "section": "bar_area",
      "capacity": 8,
      "status": "occupied",
      "current_party": 5,
      "server": "Carol Davis",
      "order_total": 124.75,
      "seated_time": "2024-06-15 18:00",
      "estimated_turnover": "2024-06-15 20:00",
      "order_id": "ORD003",
      "x_position": 100,
      "y_position": 300,
    },
    {
      "id": "T005",
      "number": "5",
      "section": "private_room",
      "capacity": 12,
      "status": "cleaning",
      "current_party": 0,
      "server": "",
      "order_total": 0.0,
      "seated_time": "",
      "estimated_turnover": "",
      "order_id": "",
      "x_position": 300,
      "y_position": 150,
    },
  ];

  List<Map<String, dynamic>> reservations = [
    {
      "id": "RES001",
      "customer_name": "Wilson Party",
      "phone": "+1 234-567-8900",
      "party_size": 6,
      "date": "2024-06-15",
      "time": "19:30",
      "table": "T003",
      "status": "confirmed",
      "special_requests": "Birthday celebration, cake",
    },
    {
      "id": "RES002",
      "customer_name": "Brown Family",
      "phone": "+1 234-567-8901",
      "party_size": 4,
      "date": "2024-06-15",
      "time": "20:00",
      "table": "",
      "status": "pending",
      "special_requests": "High chair needed",
    },
    {
      "id": "RES003",
      "customer_name": "Davis Corporation",
      "phone": "+1 234-567-8902",
      "party_size": 10,
      "date": "2024-06-16",
      "time": "18:00",
      "table": "T005",
      "status": "confirmed",
      "special_requests": "Business dinner, quiet area",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Table Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Floor Plan", icon: Icon(Icons.table_restaurant)),
        Tab(text: "Tables", icon: Icon(Icons.list)),
        Tab(text: "Reservations", icon: Icon(Icons.event_seat)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildFloorPlanTab(),
        _buildTablesTab(),
        _buildReservationsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildFloorPlanTab() {
    List<Map<String, dynamic>> filteredTables = tables.where((table) {
      bool matchesStatus = selectedStatus == "All" || table["status"] == selectedStatus;
      bool matchesSection = selectedSection == "All" || table["section"] == selectedSection;
      return matchesStatus && matchesSection;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
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
                    label: "Section",
                    items: sectionOptions,
                    value: selectedSection,
                    onChanged: (value, label) {
                      selectedSection = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          // Floor Plan Status
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Floor Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: successColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${tables.where((t) => t["status"] == "available").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Available",
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: dangerColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${tables.where((t) => t["status"] == "occupied").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Occupied",
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

          // Visual Floor Plan
          Container(
            height: 400,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Stack(
              children: [
                // Background sections
                Positioned(
                  left: 20,
                  top: 20,
                  child: Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor.withAlpha(100)),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "Main Dining",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 240,
                  top: 20,
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: successColor.withAlpha(100)),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "Patio",
                        style: TextStyle(
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 200,
                  child: Container(
                    width: 180,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: warningColor.withAlpha(100)),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "Bar Area",
                        style: TextStyle(
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Tables
                ...filteredTables.map((table) {
                  Color statusColor = _getTableStatusColor(table["status"]);
                  
                  return Positioned(
                    left: (table["x_position"] as int).toDouble(),
                    top: (table["y_position"] as int).toDouble(),
                    child: GestureDetector(
                      onTap: () {
                        _showTableDetails(table);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${table["number"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (table["status"] == "occupied")
                              Text(
                                "${table["current_party"]}/${table["capacity"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Legend
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Status Legend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spSm,
                  runSpacing: spXs,
                  children: [
                    _buildLegendItem("Available", successColor),
                    _buildLegendItem("Occupied", dangerColor),
                    _buildLegendItem("Reserved", warningColor),
                    _buildLegendItem("Cleaning", infoColor),
                    _buildLegendItem("Maintenance", disabledBoldColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTablesTab() {
    List<Map<String, dynamic>> filteredTables = tables.where((table) {
      bool matchesStatus = selectedStatus == "All" || table["status"] == selectedStatus;
      bool matchesSection = selectedSection == "All" || table["section"] == selectedSection;
      return matchesStatus && matchesSection;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters and View Toggle
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
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusOptions,
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
                        label: "Section",
                        items: sectionOptions,
                        value: selectedSection,
                        onChanged: (value, label) {
                          selectedSection = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Grid View",
                      "value": true,
                      "checked": isGridView,
                    }
                  ],
                  value: [if (isGridView) {"label": "Grid View", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    isGridView = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Tables List/Grid
          if (isGridView)
            ResponsiveGridView(
              padding: EdgeInsets.all(spSm),
              minItemWidth: 200,
              children: filteredTables.map((table) {
                Color statusColor = _getTableStatusColor(table["status"]);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(color: statusColor.withAlpha(100)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: statusColor,
                            child: Text(
                              "${table["number"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Table ${table["number"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${table["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Section: ${table["section"]}".replaceAll("_", " ").split(" ").map((word) => word[0].toUpperCase() + word.substring(1)).join(" "),
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Capacity: ${table["capacity"]} guests",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (table["status"] == "occupied") ...[
                        Text(
                          "Current Party: ${table["current_party"]} guests",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Server: ${table["server"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Order Total: \$${((table["order_total"] as num).toDouble()).currency}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                      if (table["status"] == "reserved") ...[
                        Text(
                          "Reserved for: ${table["reservation_name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Time: ${table["reservation_time"]}".substring(11),
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Manage",
                          size: bs.sm,
                          onPressed: () {
                            _showTableDetails(table);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          else
            ...filteredTables.map((table) {
              Color statusColor = _getTableStatusColor(table["status"]);
              
              return Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: statusColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: statusColor,
                      child: Text(
                        "${table["number"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Table ${table["number"]} - ${table["section"]}".replaceAll("_", " "),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Capacity: ${table["capacity"]} • Status: ${table["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Manage",
                      size: bs.sm,
                      onPressed: () {
                        _showTableDetails(table);
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildReservationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Reservation Summary
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Today's Reservations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${reservations.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total",
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: successColor.withAlpha(100)),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${reservations.where((r) => r["status"] == "confirmed").length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Confirmed",
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

          // Add Reservation Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Reservation",
              size: bs.md,
              onPressed: () {
                // Add new reservation
              },
            ),
          ),

          // Reservations List
          ...reservations.map((reservation) {
            Color statusColor = reservation["status"] == "confirmed" ? successColor : warningColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: statusColor.withAlpha(100)),
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
                              "${reservation["customer_name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${reservation["phone"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${reservation["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Date: ${reservation["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Time: ${reservation["time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Party Size: ${reservation["party_size"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      if (reservation["table"] != "")
                        Expanded(
                          child: Text(
                            "Table: ${reservation["table"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (reservation["special_requests"] != "")
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Special Requests: ${reservation["special_requests"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Edit",
                          size: bs.sm,
                          onPressed: () {
                            // Edit reservation
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Seat Now",
                          size: bs.sm,
                          onPressed: () {
                            // Seat the reservation
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Table Utilization
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Table Utilization",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "74%",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Average table utilization today",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Section Performance
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Section Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor.withAlpha(100)),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Main Dining",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "85%",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor.withAlpha(100)),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Patio",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "68%",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor.withAlpha(100)),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Bar Area",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "92%",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Export Options
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Export Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Export Table Report (PDF)",
                    size: bs.md,
                    onPressed: () {
                      // Export table report
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Export Reservation Report (CSV)",
                    size: bs.md,
                    onPressed: () {
                      // Export reservation report
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

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Color _getTableStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "occupied":
        return dangerColor;
      case "reserved":
        return warningColor;
      case "cleaning":
        return infoColor;
      case "maintenance":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  void _showTableDetails(Map<String, dynamic> table) {
    // Show table details dialog or navigate to detail page
    si("Table ${table["number"]} details would be shown here");
  }
}
