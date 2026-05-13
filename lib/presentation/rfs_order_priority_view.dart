import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsOrderPriorityView extends StatefulWidget {
  const RfsOrderPriorityView({super.key});

  @override
  State<RfsOrderPriorityView> createState() => _RfsOrderPriorityViewState();
}

class _RfsOrderPriorityViewState extends State<RfsOrderPriorityView> {
  String searchQuery = "";
  String selectedPriority = "All";
  String selectedStatus = "All";
  String selectedStation = "All";
  bool showUrgentOnly = false;
  String sortBy = "Priority";

  List<Map<String, dynamic>> priorityOrders = [
    {
      "id": "ORD-001",
      "orderNumber": "#12345",
      "customerName": "Sarah Johnson",
      "customerType": "VIP",
      "tableNumber": "T-15",
      "priority": "Critical",
      "priorityScore": 10,
      "status": "In Progress",
      "station": "Grill",
      "estimatedTime": 25,
      "elapsedTime": 35,
      "isDelayed": true,
      "delayMinutes": 10,
      "waitTime": 45,
      "orderTime": "12:15 PM",
      "promisedTime": "12:40 PM",
      "items": [
        {"name": "Beef Wellington", "quantity": 2, "specialInstructions": "Medium rare", "isReady": false},
        {"name": "Truffle Pasta", "quantity": 1, "specialInstructions": "Extra truffle", "isReady": true},
      ],
      "specialRequests": ["Allergy: Nuts", "VIP Service"],
      "rushReason": "Customer Anniversary",
      "assignedChef": "Chef Marcus",
      "notes": "Handle with extra care - celebrating anniversary",
      "lastUpdate": "2 min ago",
    },
    {
      "id": "ORD-002",
      "orderNumber": "#12346",
      "customerName": "Mike Chen",
      "customerType": "Regular",
      "tableNumber": "T-08",
      "priority": "High",
      "priorityScore": 8,
      "status": "Waiting",
      "station": "Sauté",
      "estimatedTime": 20,
      "elapsedTime": 15,
      "isDelayed": false,
      "delayMinutes": 0,
      "waitTime": 15,
      "orderTime": "12:30 PM",
      "promisedTime": "12:50 PM",
      "items": [
        {"name": "Pan-Seared Salmon", "quantity": 1, "specialInstructions": "No sauce", "isReady": false},
        {"name": "Caesar Salad", "quantity": 1, "specialInstructions": "Dressing on side", "isReady": true},
      ],
      "specialRequests": ["Quick service requested"],
      "rushReason": "Business lunch meeting",
      "assignedChef": "Chef Sofia",
      "notes": "Customer has limited time",
      "lastUpdate": "5 min ago",
    },
    {
      "id": "ORD-003",
      "orderNumber": "#12347",
      "customerName": "Emma Wilson",
      "customerType": "Regular",
      "tableNumber": "T-22",
      "priority": "Medium",
      "priorityScore": 5,
      "status": "Ready",
      "station": "Cold Prep",
      "estimatedTime": 15,
      "elapsedTime": 12,
      "isDelayed": false,
      "delayMinutes": 0,
      "waitTime": 12,
      "orderTime": "12:45 PM",
      "promisedTime": "1:00 PM",
      "items": [
        {"name": "Greek Salad", "quantity": 2, "specialInstructions": "Extra olives", "isReady": true},
        {"name": "Soup of the Day", "quantity": 1, "specialInstructions": "Hot", "isReady": true},
      ],
      "specialRequests": [],
      "rushReason": "",
      "assignedChef": "Chef Lisa",
      "notes": "Standard preparation",
      "lastUpdate": "1 min ago",
    },
    {
      "id": "ORD-004",
      "orderNumber": "#12348",
      "customerName": "David Brown",
      "customerType": "New",
      "tableNumber": "T-05",
      "priority": "Low",
      "priorityScore": 3,
      "status": "Pending",
      "station": "Grill",
      "estimatedTime": 30,
      "elapsedTime": 0,
      "isDelayed": false,
      "delayMinutes": 0,
      "waitTime": 0,
      "orderTime": "1:00 PM",
      "promisedTime": "1:30 PM",
      "items": [
        {"name": "Grilled Chicken", "quantity": 1, "specialInstructions": "Well done", "isReady": false},
        {"name": "Seasonal Vegetables", "quantity": 1, "specialInstructions": "Steamed", "isReady": false},
      ],
      "specialRequests": [],
      "rushReason": "",
      "assignedChef": "Chef Antonio",
      "notes": "First-time visitor",
      "lastUpdate": "Just now",
    },
    {
      "id": "ORD-005",
      "orderNumber": "#12349",
      "customerName": "Lisa Martinez",
      "customerType": "VIP",
      "tableNumber": "T-01",
      "priority": "Urgent",
      "priorityScore": 9,
      "status": "In Progress",
      "station": "Pastry",
      "estimatedTime": 18,
      "elapsedTime": 20,
      "isDelayed": true,
      "delayMinutes": 2,
      "waitTime": 20,
      "orderTime": "12:55 PM",
      "promisedTime": "1:13 PM",
      "items": [
        {"name": "Chocolate Soufflé", "quantity": 2, "specialInstructions": "Extra airy", "isReady": false},
        {"name": "Vanilla Ice Cream", "quantity": 2, "specialInstructions": "Premium scoop", "isReady": true},
      ],
      "specialRequests": ["Birthday celebration", "Candles needed"],
      "rushReason": "Birthday surprise",
      "assignedChef": "Chef Marie",
      "notes": "Special birthday order - needs candles",
      "lastUpdate": "3 min ago",
    },
  ];

  List<Map<String, dynamic>> priorities = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "Urgent", "value": "Urgent"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statuses = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Waiting", "value": "Waiting"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Ready", "value": "Ready"},
    {"label": "Delayed", "value": "Delayed"},
  ];

  List<Map<String, dynamic>> stations = [
    {"label": "All", "value": "All"},
    {"label": "Grill", "value": "Grill"},
    {"label": "Sauté", "value": "Sauté"},
    {"label": "Cold Prep", "value": "Cold Prep"},
    {"label": "Pastry", "value": "Pastry"},
    {"label": "Fryer", "value": "Fryer"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Priority", "value": "Priority"},
    {"label": "Wait Time", "value": "Wait Time"},
    {"label": "Order Time", "value": "Order Time"},
    {"label": "Promised Time", "value": "Promised Time"},
    {"label": "Customer Type", "value": "Customer Type"},
  ];

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = priorityOrders.where((order) {
      bool matchesSearch = order["orderNumber"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          order["customerName"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          order["tableNumber"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesPriority = selectedPriority == "All" || order["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "All" || order["status"] == selectedStatus;
      bool matchesStation = selectedStation == "All" || order["station"] == selectedStation;
      bool matchesUrgent = !showUrgentOnly || order["priority"] == "Critical" || order["priority"] == "Urgent";

      return matchesSearch && matchesPriority && matchesStatus && matchesStation && matchesUrgent;
    }).toList();

    // Sort orders
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Priority":
          return (b["priorityScore"] as int).compareTo(a["priorityScore"] as int);
        case "Wait Time":
          return (b["waitTime"] as int).compareTo(a["waitTime"] as int);
        case "Order Time":
          return a["orderTime"].toString().compareTo(b["orderTime"].toString());
        case "Promised Time":
          return a["promisedTime"].toString().compareTo(b["promisedTime"].toString());
        case "Customer Type":
          return a["customerType"].toString().compareTo(b["customerType"].toString());
        default:
          return (b["priorityScore"] as int).compareTo(a["priorityScore"] as int);
      }
    });

    return filtered;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "Urgent":
        return warningColor;
      case "High":
        return infoColor;
      case "Medium":
        return successColor;
      case "Low":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return disabledBoldColor;
      case "Waiting":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Ready":
        return successColor;
      case "Delayed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority) {
      case "Critical":
        return Icons.priority_high;
      case "Urgent":
        return Icons.alarm;
      case "High":
        return Icons.arrow_upward;
      case "Medium":
        return Icons.remove;
      case "Low":
        return Icons.arrow_downward;
      default:
        return Icons.help_outline;
    }
  }

  void _updateOrderPriority(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update Priority: ${order["orderNumber"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            Text(
              "Customer: ${order["customerName"]} (${order["customerType"]})",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Text(
              "Current Priority: ${order["priority"]}",
              style: TextStyle(
                color: _getPriorityColor(order["priority"]),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: spMd),
            
            ...priorities.where((p) => p["value"] != "All").map((priority) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: QButton(
                label: "${priority["label"]} Priority",
                size: bs.md,
                onPressed: () {
                  Navigator.pop(context);
                  ss("Priority updated to ${priority["label"]}");
                },
              ),
            )),
            
            SizedBox(height: spSm),
            QButton(
              label: "Cancel",
              size: bs.md,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _viewOrderDetails(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${order["orderNumber"]} - ${order["customerName"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(order["priority"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${order["priority"]} Priority",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getStatusColor(order["status"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${order["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Info
                    _buildDetailSection("Order Information", [
                      _buildDetailRow("Table", "${order["tableNumber"]}"),
                      _buildDetailRow("Station", "${order["station"]}"),
                      _buildDetailRow("Assigned Chef", "${order["assignedChef"]}"),
                      _buildDetailRow("Customer Type", "${order["customerType"]}"),
                    ]),
                    
                    SizedBox(height: spMd),
                    
                    // Timing
                    _buildDetailSection("Timing Details", [
                      _buildDetailRow("Order Time", "${order["orderTime"]}"),
                      _buildDetailRow("Promised Time", "${order["promisedTime"]}"),
                      _buildDetailRow("Estimated Duration", "${order["estimatedTime"]} min"),
                      _buildDetailRow("Elapsed Time", "${order["elapsedTime"]} min"),
                      if (order["isDelayed"])
                        _buildDetailRow("Delay", "${order["delayMinutes"]} min late", dangerColor),
                    ]),
                    
                    SizedBox(height: spMd),
                    
                    // Items
                    Text(
                      "Order Items",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...((order["items"] as List).map((item) => Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: item["isReady"] ? successColor.withAlpha(30) : warningColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: item["isReady"] ? successColor : warningColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item["isReady"] ? Icons.check_circle : Icons.access_time,
                            color: item["isReady"] ? successColor : warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["name"]} (${item["quantity"]}x)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                if (item["specialInstructions"].isNotEmpty)
                                  Text(
                                    "${item["specialInstructions"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),
                    
                    SizedBox(height: spMd),
                    
                    // Special Requests
                    if ((order["specialRequests"] as List).isNotEmpty) ...[
                      Text(
                        "Special Requests",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...((order["specialRequests"] as List).map((request) => Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: infoColor.withAlpha(100)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: infoColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "$request",
                                style: TextStyle(
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))),
                      SizedBox(height: spMd),
                    ],
                    
                    // Rush Reason
                    if (order["rushReason"].isNotEmpty) ...[
                      _buildDetailSection("Rush Reason", [
                        Text(
                          "${order["rushReason"]}",
                          style: TextStyle(
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ]),
                      SizedBox(height: spMd),
                    ],
                    
                    // Notes
                    if (order["notes"].isNotEmpty) ...[
                      _buildDetailSection("Chef Notes", [
                        Text(
                          "${order["notes"]}",
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ]),
                      SizedBox(height: spMd),
                    ],
                    
                    // Actions
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Update Priority",
                            size: bs.md,
                            onPressed: () {
                              Navigator.pop(context);
                              _updateOrderPriority(order);
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Add Note",
                            size: bs.md,
                            onPressed: () {
                              Navigator.pop(context);
                              ss("Add note to ${order["orderNumber"]}");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valueColor ?? primaryColor,
                fontWeight: valueColor != null ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Priority Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Priority list refreshed");
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search
            QTextField(
              label: "Search orders...",
              value: searchQuery,
              hint: "Enter order number, customer name, or table",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Priority Summary Cards
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Priority Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: _buildPriorityCard("Critical", priorityOrders.where((o) => o["priority"] == "Critical").length, dangerColor),
                      ),
                      Expanded(
                        child: _buildPriorityCard("Urgent", priorityOrders.where((o) => o["priority"] == "Urgent").length, warningColor),
                      ),
                      Expanded(
                        child: _buildPriorityCard("Delayed", priorityOrders.where((o) => o["isDelayed"] == true).length, dangerColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: priorities,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statuses,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Station",
                    items: stations,
                    value: selectedStation,
                    onChanged: (value, label) {
                      selectedStation = value;
                      setState(() {});
                    },
                  ),
                ),
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
              ],
            ),

            // Urgent Only Toggle
            QSwitch(
              items: [
                {
                  "label": "Show Urgent Only",
                  "value": true,
                  "checked": showUrgentOnly,
                }
              ],
              value: [
                if (showUrgentOnly)
                  {
                    "label": "Show Urgent Only",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showUrgentOnly = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Results Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: infoColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Showing ${filteredOrders.length} priority orders",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Orders List
            if (filteredOrders.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.priority_high,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Priority Orders Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredOrders.map((order) => Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: order["isDelayed"] 
                    ? Border.all(color: dangerColor, width: 2)
                    : Border.all(color: _getPriorityColor(order["priority"]).withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getPriorityColor(order["priority"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            _getPriorityIcon(order["priority"]),
                            color: _getPriorityColor(order["priority"]),
                            size: 20,
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
                                    "${order["orderNumber"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(order["priority"]),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${order["priority"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (order["isDelayed"]) ...[
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "DELAYED",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${order["customerName"]} • ${order["tableNumber"]} • ${order["customerType"]}",
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
                            color: _getStatusColor(order["status"]),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${order["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Quick Info
                    Row(
                      children: [
                        _buildQuickInfo(Icons.access_time, "${order["waitTime"]} min wait", warningColor),
                        SizedBox(width: spMd),
                        _buildQuickInfo(Icons.restaurant, "${order["station"]}", infoColor),
                        SizedBox(width: spMd),
                        _buildQuickInfo(Icons.person, "${order["assignedChef"]}", successColor),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Timing Bar
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: order["isDelayed"] ? dangerColor.withAlpha(30) : successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Ordered: ${order["orderTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Promised: ${order["promisedTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: order["isDelayed"] ? dangerColor : successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (order["rushReason"].isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: warningColor.withAlpha(100)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.flash_on,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Rush: ${order["rushReason"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    SizedBox(height: spSm),

                    // Actions
                    Row(
                      children: [
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () => _viewOrderDetails(order),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Update Priority",
                          size: bs.sm,
                          onPressed: () => _updateOrderPriority(order),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit_note,
                          size: bs.sm,
                          onPressed: () {
                            ss("Add note to ${order["orderNumber"]}");
                          },
                        ),
                        Spacer(),
                        Text(
                          "Updated: ${order["lastUpdate"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityCard(String title, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfo(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: color,
        ),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
