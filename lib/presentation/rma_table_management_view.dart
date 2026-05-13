import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaTableManagementView extends StatefulWidget {
  const RmaTableManagementView({super.key});

  @override
  State<RmaTableManagementView> createState() => _RmaTableManagementViewState();
}

class _RmaTableManagementViewState extends State<RmaTableManagementView> {
  String selectedFloor = "all";
  String tableStatus = "all";
  String sortBy = "table_number";
  bool showOnlyAvailable = false;

  List<Map<String, dynamic>> tables = [
    {
      "id": "table_001",
      "number": "T01",
      "floor": "ground",
      "section": "window",
      "capacity": 2,
      "status": "occupied",
      "currentGuests": 2,
      "reservedBy": "John Smith",
      "reservationTime": "2024-01-15 19:30:00",
      "occupiedSince": "2024-01-15 19:45:00",
      "estimatedDuration": 90,
      "waiter": "Alice Johnson",
      "orderValue": 45.80,
      "orderStatus": "served",
    },
    {
      "id": "table_002",
      "number": "T02",
      "floor": "ground",
      "section": "center",
      "capacity": 4,
      "status": "available",
      "currentGuests": 0,
      "lastCleaned": "2024-01-15 18:30:00",
      "condition": "clean",
    },
    {
      "id": "table_003",
      "number": "T03",
      "floor": "ground",
      "section": "corner",
      "capacity": 6,
      "status": "reserved",
      "reservedBy": "Sarah Wilson",
      "reservationTime": "2024-01-15 20:00:00",
      "partySize": 6,
      "specialRequests": "Birthday celebration",
      "phoneNumber": "+1-555-0123",
    },
    {
      "id": "table_004",
      "number": "T04",
      "floor": "second",
      "section": "balcony",
      "capacity": 4,
      "status": "cleaning",
      "lastOccupied": "2024-01-15 18:15:00",
      "cleaningStarted": "2024-01-15 19:00:00",
      "estimatedCleanTime": 15,
    },
    {
      "id": "table_005",
      "number": "T05",
      "floor": "second",
      "section": "main",
      "capacity": 8,
      "status": "occupied",
      "currentGuests": 6,
      "occupiedSince": "2024-01-15 19:00:00",
      "waiter": "Mike Chen",
      "orderValue": 125.40,
      "orderStatus": "ordering",
    },
    {
      "id": "table_006",
      "number": "T06",
      "floor": "ground",
      "section": "patio",
      "capacity": 2,
      "status": "out_of_order",
      "issue": "Broken chair",
      "reportedAt": "2024-01-15 17:30:00",
      "estimatedRepair": "2024-01-16 10:00:00",
    },
  ];

  List<Map<String, dynamic>> floors = [
    {"label": "All Floors", "value": "all"},
    {"label": "Ground Floor", "value": "ground"},
    {"label": "Second Floor", "value": "second"},
    {"label": "Terrace", "value": "terrace"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Available", "value": "available"},
    {"label": "Occupied", "value": "occupied"},
    {"label": "Reserved", "value": "reserved"},
    {"label": "Cleaning", "value": "cleaning"},
    {"label": "Out of Order", "value": "out_of_order"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Table Number", "value": "table_number"},
    {"label": "Capacity", "value": "capacity"},
    {"label": "Status", "value": "status"},
    {"label": "Occupancy Time", "value": "occupancy_time"},
  ];

  Widget _buildTableOverview() {
    final totalTables = tables.length;
    final occupiedTables = tables.where((t) => t["status"] == "occupied").length;
    final availableTables = tables.where((t) => t["status"] == "available").length;
    final reservedTables = tables.where((t) => t["status"] == "reserved").length;
    final outOfOrderTables = tables.where((t) => t["status"] == "out_of_order").length;
    final occupancyRate = ((occupiedTables / totalTables) * 100);

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
            "Table Overview",
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
              _buildOverviewCard(
                "Total Tables",
                "$totalTables",
                Icons.table_restaurant,
                primaryColor,
              ),
              _buildOverviewCard(
                "Occupied",
                "$occupiedTables",
                Icons.people,
                dangerColor,
              ),
              _buildOverviewCard(
                "Available",
                "$availableTables",
                Icons.check_circle,
                successColor,
              ),
              _buildOverviewCard(
                "Reserved",
                "$reservedTables",
                Icons.schedule,
                warningColor,
              ),
              _buildOverviewCard(
                "Out of Order",
                "$outOfOrderTables",
                Icons.warning,
                dangerColor,
              ),
              _buildOverviewCard(
                "Occupancy Rate",
                "${occupancyRate.toStringAsFixed(1)}%",
                Icons.analytics,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
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

  Widget _buildFilters() {
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
                  label: "Status",
                  items: statusOptions,
                  value: tableStatus,
                  onChanged: (value, label) {
                    tableStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Available Only",
                      "value": true,
                      "checked": showOnlyAvailable,
                    }
                  ],
                  value: [
                    if (showOnlyAvailable)
                      {
                        "label": "Available Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showOnlyAvailable = values.isNotEmpty;
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

  Widget _buildTableCard(Map<String, dynamic> table) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (table["status"]) {
      case "available":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        statusText = "Available";
        break;
      case "occupied":
        statusColor = dangerColor;
        statusIcon = Icons.people;
        statusText = "Occupied";
        break;
      case "reserved":
        statusColor = warningColor;
        statusIcon = Icons.schedule;
        statusText = "Reserved";
        break;
      case "cleaning":
        statusColor = infoColor;
        statusIcon = Icons.cleaning_services;
        statusText = "Cleaning";
        break;
      case "out_of_order":
        statusColor = dangerColor;
        statusIcon = Icons.warning;
        statusText = "Out of Order";
        break;
      default:
        statusColor = disabledColor;
        statusIcon = Icons.help;
        statusText = "Unknown";
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Table ${table["number"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${table["floor"]} floor • ${table["section"]} section",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.chair, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Capacity: ${table["capacity"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (table["currentGuests"] != null) ...[
                SizedBox(width: spSm),
                Icon(Icons.person, color: primaryColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Guests: ${table["currentGuests"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ],
          ),
          if (table["reservedBy"] != null) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.person_outline, color: warningColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Reserved by: ${table["reservedBy"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            if (table["reservationTime"] != null)
              Text(
                "Time: ${DateTime.parse(table["reservationTime"]).dMMMy} ${DateTime.parse(table["reservationTime"]).hour}:${DateTime.parse(table["reservationTime"]).minute.toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
          ],
          if (table["waiter"] != null) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.person_pin, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Waiter: ${table["waiter"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
                if (table["orderValue"] != null) ...[
                  SizedBox(width: spSm),
                  Icon(Icons.receipt, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Order: \$${((table["orderValue"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ],
          if (table["issue"] != null) ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.error_outline, color: dangerColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Issue: ${table["issue"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              if (table["status"] == "available")
                QButton(
                  label: "Mark Occupied",
                  icon: Icons.people,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('RmaTableOccupancyView')
                  },
                ),
              if (table["status"] == "occupied") ...[
                QButton(
                  label: "Add Order",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('RmaNewOrderView')
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Check Out",
                  icon: Icons.payment,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('RmaCheckoutView')
                  },
                ),
              ],
              if (table["status"] == "reserved")
                QButton(
                  label: "Check In",
                  icon: Icons.login,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('RmaReservationCheckInView')
                  },
                ),
              if (table["status"] == "cleaning")
                QButton(
                  label: "Mark Clean",
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () {
                    // Mark table as clean
                  },
                ),
              Spacer(),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RmaEditTableView')
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredTables {
    return tables.where((table) {
      if (selectedFloor != "all" && table["floor"] != selectedFloor) {
        return false;
      }
      if (tableStatus != "all" && table["status"] != tableStatus) {
        return false;
      }
      if (showOnlyAvailable && table["status"] != "available") {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              //navigateTo('RmaTableLayoutView')
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('RmaAddTableView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildTableOverview(),
            _buildFilters(),
            Container(
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
                        "Tables (${filteredTables.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Quick Actions",
                        icon: Icons.flash_on,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('RmaTableQuickActionsView')
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  if (filteredTables.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.table_restaurant,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No tables found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredTables.map((table) => _buildTableCard(table)).toList(),
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
