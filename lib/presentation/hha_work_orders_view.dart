import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaWorkOrdersView extends StatefulWidget {
  const HhaWorkOrdersView({super.key});

  @override
  State<HhaWorkOrdersView> createState() => _HhaWorkOrdersViewState();
}

class _HhaWorkOrdersViewState extends State<HhaWorkOrdersView> {
  String selectedStatus = "All";
  String selectedPriority = "All";
  String selectedCategory = "All";
  
  List<String> statusOptions = ["All", "Open", "In Progress", "Completed", "On Hold", "Cancelled"];
  List<String> priorityOptions = ["All", "Emergency", "High", "Medium", "Low"];
  List<String> categoryOptions = ["All", "Plumbing", "Electrical", "HVAC", "Maintenance", "Cleaning", "IT"];

  List<Map<String, dynamic>> workOrders = [
    {
      "id": "WO-2024-001",
      "title": "Fix Leaking Faucet",
      "description": "Guest reported leaking faucet in bathroom sink",
      "category": "Plumbing",
      "priority": "High",
      "status": "In Progress",
      "location": "Room 305",
      "requestedBy": "Reception Desk",
      "assignedTo": "Mike Johnson",
      "requestDate": "2024-01-15T09:30:00",
      "dueDate": "2024-01-15T17:00:00",
      "completedDate": null,
      "estimatedCost": 150.0,
      "actualCost": 0.0,
      "notes": "Guest checkout at 11 AM, priority repair needed",
      "attachments": ["photo1.jpg", "quote.pdf"],
      "parts": [
        {"name": "Faucet Cartridge", "quantity": 1, "cost": 45.0},
        {"name": "O-Ring Set", "quantity": 1, "cost": 15.0},
      ],
    },
    {
      "id": "WO-2024-002",
      "title": "Replace Air Filter",
      "description": "Monthly HVAC maintenance - replace air filters",
      "category": "HVAC",
      "priority": "Medium",
      "status": "Open",
      "location": "Conference Room A",
      "requestedBy": "Maintenance Schedule",
      "assignedTo": "Sarah Davis",
      "requestDate": "2024-01-14T08:00:00",
      "dueDate": "2024-01-18T16:00:00",
      "completedDate": null,
      "estimatedCost": 80.0,
      "actualCost": 0.0,
      "notes": "Part of monthly preventive maintenance",
      "attachments": [],
      "parts": [
        {"name": "HEPA Filter", "quantity": 2, "cost": 35.0},
      ],
    },
    {
      "id": "WO-2024-003",
      "title": "Electrical Outlet Repair",
      "description": "Power outlet not working near reception desk",
      "category": "Electrical",
      "priority": "Emergency",
      "status": "Completed",
      "location": "Reception Area",
      "requestedBy": "Emma Wilson",
      "assignedTo": "Tom Martinez",
      "requestDate": "2024-01-13T14:15:00",
      "dueDate": "2024-01-13T18:00:00",
      "completedDate": "2024-01-13T16:30:00",
      "estimatedCost": 200.0,
      "actualCost": 175.0,
      "notes": "Faulty wiring replaced, tested all nearby outlets",
      "attachments": ["before.jpg", "after.jpg", "receipt.pdf"],
      "parts": [
        {"name": "GFCI Outlet", "quantity": 1, "cost": 25.0},
        {"name": "Wire Nuts", "quantity": 4, "cost": 8.0},
        {"name": "Electrical Wire", "quantity": 10, "cost": 15.0},
      ],
    },
    {
      "id": "WO-2024-004",
      "title": "WiFi Router Replacement",
      "description": "WiFi connection issues in guest rooms 401-405",
      "category": "IT",
      "priority": "High",
      "status": "On Hold",
      "location": "4th Floor",
      "requestedBy": "Guest Services",
      "assignedTo": "Lisa Chen",
      "requestDate": "2024-01-12T10:00:00",
      "dueDate": "2024-01-16T12:00:00",
      "completedDate": null,
      "estimatedCost": 350.0,
      "actualCost": 0.0,
      "notes": "Waiting for new router delivery - ETA Jan 16",
      "attachments": ["network_test.pdf"],
      "parts": [
        {"name": "Enterprise Router", "quantity": 1, "cost": 285.0},
        {"name": "Ethernet Cables", "quantity": 5, "cost": 25.0},
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredWorkOrders {
    return workOrders.where((order) {
      if (selectedStatus != "All" && order["status"] != selectedStatus) return false;
      if (selectedPriority != "All" && order["priority"] != selectedPriority) return false;
      if (selectedCategory != "All" && order["category"] != selectedCategory) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Work Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWorkOrderSummary(),
            SizedBox(height: spLg),
            _buildQuickFilters(),
            SizedBox(height: spMd),
            _buildWorkOrdersList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateWorkOrderDialog(),
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildWorkOrderSummary() {
    int totalOrders = workOrders.length;
    int openOrders = workOrders.where((order) => order["status"] == "Open").length;
    int inProgressOrders = workOrders.where((order) => order["status"] == "In Progress").length;
    int completedOrders = workOrders.where((order) => order["status"] == "Completed").length;
    int emergencyOrders = workOrders.where((order) => order["priority"] == "Emergency").length;

    double totalEstimatedCost = workOrders.fold(0.0, (sum, order) => sum + (order["estimatedCost"] as double));
    double totalActualCost = workOrders.fold(0.0, (sum, order) => sum + (order["actualCost"] as double));

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
              Icon(Icons.build, color: primaryColor, size: 28),
              SizedBox(width: spSm),
              Text(
                "Work Orders Overview",
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
              _buildSummaryCard("Total Orders", totalOrders, Icons.list_alt, primaryColor),
              _buildSummaryCard("Open", openOrders, Icons.fiber_new, warningColor),
              _buildSummaryCard("In Progress", inProgressOrders, Icons.build_circle, infoColor),
              _buildSummaryCard("Completed", completedOrders, Icons.check_circle, successColor),
              _buildSummaryCard("Emergency", emergencyOrders, Icons.priority_high, dangerColor),
            ],
          ),
          SizedBox(height: spMd),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Estimated Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${totalEstimatedCost.currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Actual Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${totalActualCost.currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
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

  Widget _buildQuickFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Filters",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip("All", selectedStatus == "All", () {
                selectedStatus = "All";
                setState(() {});
              }),
              _buildFilterChip("Open", selectedStatus == "Open", () {
                selectedStatus = "Open";
                setState(() {});
              }),
              _buildFilterChip("In Progress", selectedStatus == "In Progress", () {
                selectedStatus = "In Progress";
                setState(() {});
              }),
              _buildFilterChip("Emergency", selectedPriority == "Emergency", () {
                selectedPriority = "Emergency";
                setState(() {});
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
            border: Border.all(
              color: isSelected ? primaryColor : disabledOutlineBorderColor,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkOrdersList() {
    List<Map<String, dynamic>> displayOrders = filteredWorkOrders;

    if (displayOrders.isEmpty) {
      return Container(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 48, color: disabledColor),
              SizedBox(height: spSm),
              Text(
                "No work orders found",
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
          "Work Orders (${displayOrders.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...displayOrders.map((order) => _buildWorkOrderCard(order)).toList(),
      ],
    );
  }

  Widget _buildWorkOrderCard(Map<String, dynamic> order) {
    Color statusColor = _getStatusColor(order["status"]);
    Color priorityColor = _getPriorityColor(order["priority"]);
    DateTime requestDate = DateTime.parse(order["requestDate"]);
    DateTime dueDate = DateTime.parse(order["dueDate"]);
    bool isOverdue = dueDate.isBefore(DateTime.now()) && order["status"] != "Completed";
    
    List<Map<String, dynamic>> parts = List<Map<String, dynamic>>.from(order["parts"]);
    List<String> attachments = List<String>.from(order["attachments"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: isOverdue 
          ? Border.all(color: dangerColor.withAlpha(102))
          : null,
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
                        color: statusColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${order["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${order["priority"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: priorityColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${order["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${order["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${order["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(order["category"]).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${order["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getCategoryColor(order["category"]),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${order["location"]}",
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
                    Icon(Icons.person, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${order["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.schedule, size: 16, color: isOverdue ? dangerColor : disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Due: ${dueDate.dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: isOverdue ? dangerColor : disabledBoldColor,
                        fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Estimated Cost",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((order["estimatedCost"] as double)).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    if (order["actualCost"] > 0) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Actual Cost",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((order["actualCost"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                    Spacer(),
                    if (attachments.isNotEmpty) ...[
                      Icon(Icons.attach_file, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${attachments.length}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
                if (parts.isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Text(
                    "Parts Required:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  ...parts.take(2).map((part) => Text(
                    "• ${part["name"]} (${part["quantity"]}) - \$${((part["cost"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  )).toList(),
                  if (parts.length > 2)
                    Text(
                      "... and ${parts.length - 2} more parts",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                        fontStyle: FontStyle.italic,
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
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showWorkOrderDetails(order),
                ),
                SizedBox(width: spSm),
                if (order["status"] != "Completed" && order["status"] != "Cancelled") ...[
                  QButton(
                    label: "Update Status",
                    size: bs.sm,
                    onPressed: () => _showUpdateStatusDialog(order),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Completed":
        return successColor;
      case "On Hold":
        return Colors.orange;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Emergency":
        return dangerColor;
      case "High":
        return Colors.red;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Plumbing":
        return Colors.blue;
      case "Electrical":
        return Colors.orange;
      case "HVAC":
        return Colors.green;
      case "Maintenance":
        return Colors.purple;
      case "Cleaning":
        return Colors.teal;
      case "IT":
        return Colors.indigo;
      default:
        return primaryColor;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Work Orders"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Status",
              items: statusOptions.map((status) => {
                "label": status,
                "value": status,
              }).toList(),
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Priority",
              items: priorityOptions.map((priority) => {
                "label": priority,
                "value": priority,
              }).toList(),
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Category",
              items: categoryOptions.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showWorkOrderDetails(Map<String, dynamic> order) {
    List<Map<String, dynamic>> parts = List<Map<String, dynamic>>.from(order["parts"]);
    List<String> attachments = List<String>.from(order["attachments"]);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${order["id"]}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title: ${order["title"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Category: ${order["category"]}"),
              Text("Priority: ${order["priority"]}"),
              Text("Status: ${order["status"]}"),
              Text("Location: ${order["location"]}"),
              Text("Assigned to: ${order["assignedTo"]}"),
              Text("Requested by: ${order["requestedBy"]}"),
              SizedBox(height: spSm),
              Text("Description:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${order["description"]}"),
              SizedBox(height: spSm),
              if (order["notes"].isNotEmpty) ...[
                Text("Notes:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${order["notes"]}"),
                SizedBox(height: spSm),
              ],
              if (parts.isNotEmpty) ...[
                Text("Parts:", style: TextStyle(fontWeight: FontWeight.bold)),
                ...parts.map((part) => Text("• ${part["name"]} (${part["quantity"]}) - \$${((part["cost"] as double)).currency}")).toList(),
                SizedBox(height: spSm),
              ],
              if (attachments.isNotEmpty) ...[
                Text("Attachments:", style: TextStyle(fontWeight: FontWeight.bold)),
                ...attachments.map((attachment) => Text("• $attachment")).toList(),
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

  void _showUpdateStatusDialog(Map<String, dynamic> order) {
    String newStatus = order["status"];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Work Order Status"),
        content: QDropdownField(
          label: "Status",
          items: statusOptions.skip(1).map((status) => {
            "label": status,
            "value": status,
          }).toList(),
          value: newStatus,
          onChanged: (value, label) {
            newStatus = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update",
            size: bs.sm,
            onPressed: () {
              order["status"] = newStatus;
              if (newStatus == "Completed") {
                order["completedDate"] = DateTime.now().toIso8601String();
              }
              setState(() {});
              Navigator.pop(context);
              ss("Work order status updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showCreateWorkOrderDialog() {
    String title = "";
    String description = "";
    String category = "Maintenance";
    String priority = "Medium";
    String location = "";
    String assignedTo = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Work Order"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Title",
                value: title,
                onChanged: (value) => title = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Description",
                value: description,
                onChanged: (value) => description = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Category",
                items: categoryOptions.skip(1).map((cat) => {
                  "label": cat,
                  "value": cat,
                }).toList(),
                value: category,
                onChanged: (value, label) => category = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Priority",
                items: priorityOptions.skip(1).map((prio) => {
                  "label": prio,
                  "value": prio,
                }).toList(),
                value: priority,
                onChanged: (value, label) => priority = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Location",
                value: location,
                onChanged: (value) => location = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Assign To",
                value: assignedTo,
                onChanged: (value) => assignedTo = value,
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
            label: "Create",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Work order created successfully");
            },
          ),
        ],
      ),
    );
  }
}
