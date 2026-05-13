import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaSupplyTrackingView extends StatefulWidget {
  const HhaSupplyTrackingView({super.key});

  @override
  State<HhaSupplyTrackingView> createState() => _HhaSupplyTrackingViewState();
}

class _HhaSupplyTrackingViewState extends State<HhaSupplyTrackingView> {
  String selectedTimeframe = "This Week";
  String selectedDepartment = "All";
  String selectedType = "All";
  
  List<String> timeframes = ["Today", "This Week", "This Month", "This Quarter"];
  List<String> departments = ["All", "Housekeeping", "Kitchen", "Maintenance", "Reception", "Laundry"];
  List<String> types = ["All", "Consumption", "Restock", "Waste", "Transfer"];

  List<Map<String, dynamic>> supplyMovements = [
    {
      "id": "SM-001",
      "itemName": "Toilet Paper",
      "itemId": "INV-001",
      "department": "Housekeeping",
      "type": "Consumption",
      "quantity": 24,
      "unit": "rolls",
      "location": "Floor 3 - Rooms 301-310",
      "requestedBy": "Maria Santos",
      "approvedBy": "Sarah Johnson",
      "timestamp": "2024-01-15T09:30:00",
      "notes": "Regular room service restocking",
      "costPerUnit": 1.25,
      "totalCost": 30.0,
      "status": "Completed",
    },
    {
      "id": "SM-002",
      "itemName": "All-Purpose Cleaner",
      "itemId": "INV-002",
      "department": "Housekeeping",
      "type": "Consumption",
      "quantity": 6,
      "unit": "bottles",
      "location": "Cleaning Cart #3",
      "requestedBy": "John Martinez",
      "approvedBy": "Sarah Johnson",
      "timestamp": "2024-01-15T14:15:00",
      "notes": "High traffic area cleaning",
      "costPerUnit": 4.50,
      "totalCost": 27.0,
      "status": "Completed",
    },
    {
      "id": "SM-003",
      "itemName": "Coffee Beans",
      "itemId": "INV-004",
      "department": "Kitchen",
      "type": "Restock",
      "quantity": 10,
      "unit": "bags",
      "location": "Kitchen Pantry",
      "requestedBy": "Chef Williams",
      "approvedBy": "Manager Davis",
      "timestamp": "2024-01-14T11:00:00",
      "notes": "Weekly coffee supply restock",
      "costPerUnit": 18.50,
      "totalCost": 185.0,
      "status": "Completed",
    },
    {
      "id": "SM-004",
      "itemName": "Bed Sheets Set",
      "itemId": "INV-003",
      "department": "Laundry",
      "type": "Waste",
      "quantity": 3,
      "unit": "sets",
      "location": "Laundry Room",
      "requestedBy": "Lisa Chen",
      "approvedBy": "Manager Davis",
      "timestamp": "2024-01-14T16:30:00",
      "notes": "Damaged beyond repair - stains and tears",
      "costPerUnit": 35.0,
      "totalCost": 105.0,
      "status": "Completed",
    },
    {
      "id": "SM-005",
      "itemName": "Hand Soap",
      "itemId": "INV-005",
      "department": "Reception",
      "type": "Transfer",
      "quantity": 8,
      "unit": "bottles",
      "location": "From Storage to Reception Restrooms",
      "requestedBy": "Emma Wilson",
      "approvedBy": "Sarah Johnson",
      "timestamp": "2024-01-13T10:45:00",
      "notes": "Transfer to public restrooms",
      "costPerUnit": 3.75,
      "totalCost": 30.0,
      "status": "Pending",
    },
  ];

  List<Map<String, dynamic>> get filteredMovements {
    DateTime now = DateTime.now();
    DateTime startDate;
    
    switch (selectedTimeframe) {
      case "Today":
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case "This Week":
        startDate = now.subtract(Duration(days: 7));
        break;
      case "This Month":
        startDate = DateTime(now.year, now.month, 1);
        break;
      case "This Quarter":
        startDate = now.subtract(Duration(days: 90));
        break;
      default:
        startDate = now.subtract(Duration(days: 7));
    }

    return supplyMovements.where((movement) {
      DateTime movementDate = DateTime.parse(movement["timestamp"]);
      if (movementDate.isBefore(startDate)) return false;
      if (selectedDepartment != "All" && movement["department"] != selectedDepartment) return false;
      if (selectedType != "All" && movement["type"] != selectedType) return false;
      return true;
    }).toList()..sort((a, b) => DateTime.parse(b["timestamp"]).compareTo(DateTime.parse(a["timestamp"])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supply Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () => _showAnalyticsDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTrackingSummary(),
            SizedBox(height: spLg),
            _buildFilters(),
            SizedBox(height: spMd),
            _buildMovementsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showRecordMovementDialog(),
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTrackingSummary() {
    List<Map<String, dynamic>> movements = filteredMovements;
    int totalMovements = movements.length;
    double totalCost = movements.fold(0.0, (sum, movement) => sum + (movement["totalCost"] as double));
    
    Map<String, int> typeCount = {};
    for (var movement in movements) {
      String type = movement["type"];
      typeCount[type] = (typeCount[type] ?? 0) + 1;
    }

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
              Icon(Icons.track_changes, color: primaryColor, size: 28),
              SizedBox(width: spSm),
              Text(
                "Supply Movement Summary",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Total Movements", totalMovements, Icons.swap_horiz, primaryColor),
              _buildSummaryCard("Consumption", typeCount["Consumption"] ?? 0, Icons.trending_down, dangerColor),
              _buildSummaryCard("Restocks", typeCount["Restock"] ?? 0, Icons.trending_up, successColor),
              _buildSummaryCard("Transfers", typeCount["Transfer"] ?? 0, Icons.compare_arrows, infoColor),
              _buildSummaryCard("Waste", typeCount["Waste"] ?? 0, Icons.delete, warningColor),
            ],
          ),
          SizedBox(height: spMd),
          Divider(),
          Row(
            children: [
              Icon(Icons.attach_money, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Total Value Impact: ",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "\$${totalCost.currency}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                selectedTimeframe,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, int count, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(77)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filters",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Timeframe",
                items: timeframes.map((timeframe) => {
                  "label": timeframe,
                  "value": timeframe,
                }).toList(),
                value: selectedTimeframe,
                onChanged: (value, label) {
                  selectedTimeframe = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Department",
                items: departments.map((dept) => {
                  "label": dept,
                  "value": dept,
                }).toList(),
                value: selectedDepartment,
                onChanged: (value, label) {
                  selectedDepartment = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        QDropdownField(
          label: "Movement Type",
          items: types.map((type) => {
            "label": type,
            "value": type,
          }).toList(),
          value: selectedType,
          onChanged: (value, label) {
            selectedType = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildMovementsList() {
    List<Map<String, dynamic>> movements = filteredMovements;

    if (movements.isEmpty) {
      return Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 48, color: disabledColor),
              SizedBox(height: spSm),
              Text(
                "No movements found",
                style: TextStyle(
                  fontSize: fsH6,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "Try adjusting your filters",
                style: TextStyle(
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Movements (${movements.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...movements.map((movement) => _buildMovementCard(movement)).toList(),
      ],
    );
  }

  Widget _buildMovementCard(Map<String, dynamic> movement) {
    Color typeColor = _getTypeColor(movement["type"]);
    Color statusColor = _getStatusColor(movement["status"]);
    DateTime timestamp = DateTime.parse(movement["timestamp"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: typeColor),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${movement["type"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: typeColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${movement["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${movement["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${movement["itemName"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Quantity: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${movement["quantity"]} ${movement["unit"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${((movement["totalCost"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getDepartmentColor(movement["department"]).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${movement["department"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getDepartmentColor(movement["department"]),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${movement["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Requested by: ${movement["requestedBy"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${timestamp.dMMMy} at ${TimeOfDay.fromDateTime(timestamp).kkmm}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.verified_user, size: 16, color: successColor),
                    SizedBox(width: spXs),
                    Text(
                      "${movement["approvedBy"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                if (movement["notes"].isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.note, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${movement["notes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusSm)),
            ),
            child: Row(
              children: [
                Text(
                  "Unit Cost: \$${((movement["costPerUnit"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showMovementDetails(movement),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Consumption":
        return dangerColor;
      case "Restock":
        return successColor;
      case "Transfer":
        return infoColor;
      case "Waste":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDepartmentColor(String department) {
    switch (department) {
      case "Housekeeping":
        return Colors.blue;
      case "Kitchen":
        return Colors.orange;
      case "Maintenance":
        return Colors.red;
      case "Reception":
        return Colors.green;
      case "Laundry":
        return Colors.purple;
      default:
        return primaryColor;
    }
  }

  void _showMovementDetails(Map<String, dynamic> movement) {
    DateTime timestamp = DateTime.parse(movement["timestamp"]);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Movement Details"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Movement ID: ${movement["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Item: ${movement["itemName"]} (${movement["itemId"]})"),
              Text("Type: ${movement["type"]}"),
              Text("Status: ${movement["status"]}"),
              Text("Department: ${movement["department"]}"),
              Text("Quantity: ${movement["quantity"]} ${movement["unit"]}"),
              Text("Location: ${movement["location"]}"),
              Text("Requested by: ${movement["requestedBy"]}"),
              Text("Approved by: ${movement["approvedBy"]}"),
              Text("Timestamp: ${timestamp.dMMMy} at ${TimeOfDay.fromDateTime(timestamp).kkmm}"),
              Text("Cost per unit: \$${((movement["costPerUnit"] as double)).currency}"),
              Text("Total cost: \$${((movement["totalCost"] as double)).currency}"),
              if (movement["notes"].isNotEmpty) ...[
                SizedBox(height: spSm),
                Text("Notes:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${movement["notes"]}"),
              ],
            ],
          ),
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

  void _showAnalyticsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Supply Analytics"),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: Column(
            children: [
              Text(
                "Analytics Dashboard",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.analytics, size: 64, color: primaryColor),
                      SizedBox(height: spMd),
                      Text(
                        "Advanced analytics coming soon",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "• Consumption trends\n• Cost analysis\n• Waste reports\n• Department comparisons",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

  void _showRecordMovementDialog() {
    String itemName = "";
    String type = "Consumption";
    String department = "Housekeeping";
    String quantity = "";
    String location = "";
    String notes = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Record Supply Movement"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Item Name",
                value: itemName,
                onChanged: (value) => itemName = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Movement Type",
                items: types.skip(1).map((type) => {
                  "label": type,
                  "value": type,
                }).toList(),
                value: type,
                onChanged: (value, label) => type = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Department",
                items: departments.skip(1).map((dept) => {
                  "label": dept,
                  "value": dept,
                }).toList(),
                value: department,
                onChanged: (value, label) => department = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Quantity",
                value: quantity,
                onChanged: (value) => quantity = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Location",
                value: location,
                onChanged: (value) => location = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Notes",
                value: notes,
                onChanged: (value) => notes = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Record",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Supply movement recorded successfully");
            },
          ),
        ],
      ),
    );
  }
}
