import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaPickListView extends StatefulWidget {
  const ImaPickListView({super.key});

  @override
  State<ImaPickListView> createState() => _ImaPickListViewState();
}

class _ImaPickListViewState extends State<ImaPickListView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "On Hold", "value": "On Hold"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priority", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> pickLists = [
    {
      "id": "PL-2024-001",
      "orderNumber": "ORD-45892",
      "customer": "ABC Electronics Store",
      "priority": "High",
      "status": "In Progress",
      "itemCount": 8,
      "pickedCount": 5,
      "assignedTo": "John Smith",
      "createdDate": "2024-06-19",
      "dueDate": "2024-06-20",
      "totalValue": 2450.00,
      "location": "Warehouse A",
      "items": [
        {"sku": "ELEC-001", "name": "Smartphone", "quantity": 2, "picked": 2},
        {"sku": "ELEC-002", "name": "Laptop", "quantity": 1, "picked": 1},
        {"sku": "ELEC-003", "name": "Tablet", "quantity": 3, "picked": 2},
        {"sku": "ELEC-004", "name": "Headphones", "quantity": 2, "picked": 0},
      ]
    },
    {
      "id": "PL-2024-002",
      "orderNumber": "ORD-45893",
      "customer": "Tech Solutions Ltd",
      "priority": "Medium",
      "status": "Pending",
      "itemCount": 12,
      "pickedCount": 0,
      "assignedTo": "Sarah Johnson",
      "createdDate": "2024-06-19",
      "dueDate": "2024-06-21",
      "totalValue": 3200.00,
      "location": "Warehouse B",
      "items": [
        {"sku": "COMP-001", "name": "Desktop PC", "quantity": 2, "picked": 0},
        {"sku": "COMP-002", "name": "Monitor", "quantity": 4, "picked": 0},
        {"sku": "COMP-003", "name": "Keyboard", "quantity": 6, "picked": 0},
      ]
    },
    {
      "id": "PL-2024-003",
      "orderNumber": "ORD-45894",
      "customer": "Home Appliances Co",
      "priority": "High",
      "status": "Completed",
      "itemCount": 6,
      "pickedCount": 6,
      "assignedTo": "Mike Wilson",
      "createdDate": "2024-06-18",
      "dueDate": "2024-06-19",
      "totalValue": 1800.00,
      "location": "Warehouse C",
      "items": [
        {"sku": "APPL-001", "name": "Refrigerator", "quantity": 1, "picked": 1},
        {"sku": "APPL-002", "name": "Washing Machine", "quantity": 1, "picked": 1},
        {"sku": "APPL-003", "name": "Microwave", "quantity": 4, "picked": 4},
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredPickLists {
    return pickLists.where((pickList) {
      final matchesSearch = pickList["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          pickList["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          pickList["orderNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "All" || pickList["status"] == selectedStatus;
      final matchesPriority = selectedPriority == "All" || pickList["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return primaryColor;
      case "Pending":
        return warningColor;
      case "On Hold":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _startPicking(Map<String, dynamic> pickList) {
    ss("Started picking for ${pickList["id"]}");
  }

  void _completePicking(Map<String, dynamic> pickList) async {
    bool isConfirmed = await confirm("Complete picking for ${pickList["id"]}?");
    if (isConfirmed) {
      ss("Picking completed for ${pickList["id"]}");
    }
  }

  void _viewPickListDetails(Map<String, dynamic> pickList) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pick List Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("ID: ${pickList["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spXs),
              Text("Order: ${pickList["orderNumber"]}"),
              Text("Customer: ${pickList["customer"]}"),
              Text("Status: ${pickList["status"]}"),
              Text("Priority: ${pickList["priority"]}"),
              Text("Progress: ${pickList["pickedCount"]}/${pickList["itemCount"]} items"),
              Text("Value: \$${(pickList["totalValue"] as double).currency}"),
              SizedBox(height: spSm),
              Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...((pickList["items"] as List).map((item) => Padding(
                padding: EdgeInsets.only(top: spXs),
                child: Text("• ${item["name"]} (${item["picked"]}/${item["quantity"]})"),
              ))),
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

  Widget _buildPickListCard(Map<String, dynamic> pickList) {
    double progressPercentage = (pickList["pickedCount"] as int) / (pickList["itemCount"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${pickList["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${pickList["customer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(pickList["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${pickList["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(pickList["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.inventory_2, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Order: ${pickList["orderNumber"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor(pickList["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${pickList["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(pickList["priority"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${pickList["assignedTo"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${pickList["location"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
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
                    Text(
                      "Progress: ${pickList["pickedCount"]}/${pickList["itemCount"]} items",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: progressPercentage,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressPercentage == 1.0 ? successColor : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "\$${(pickList["totalValue"] as double).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewPickListDetails(pickList),
                ),
              ),
              SizedBox(width: spSm),
              if (pickList["status"] == "Pending")
                QButton(
                  label: "Start",
                  size: bs.sm,
                  onPressed: () => _startPicking(pickList),
                )
              else if (pickList["status"] == "In Progress")
                QButton(
                  label: "Complete",
                  size: bs.sm,
                  onPressed: () => _completePicking(pickList),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    int totalPickLists = pickLists.length;
    int pendingPickLists = pickLists.where((p) => p["status"] == "Pending").length;
    int inProgressPickLists = pickLists.where((p) => p["status"] == "In Progress").length;
    int completedPickLists = pickLists.where((p) => p["status"] == "Completed").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.list_alt, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalPickLists",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Pick Lists",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.pending_actions, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$pendingPickLists",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Pending",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.work, color: infoColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$inProgressPickLists",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "In Progress",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$completedPickLists",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Completed",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Recent Pick Lists",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...pickLists.take(3).map((pickList) => _buildPickListCard(pickList)),
        ],
      ),
    );
  }

  Widget _buildActiveTab() {
    List<Map<String, dynamic>> activePickLists = pickLists.where((p) => 
        p["status"] == "Pending" || p["status"] == "In Progress").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search pick lists...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: statusItems,
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
                  label: "Filter by Priority",
                  items: priorityItems,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (activePickLists.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.inbox, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No active pick lists found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...activePickLists.map((pickList) => _buildPickListCard(pickList)),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    List<Map<String, dynamic>> completedPickLists = pickLists.where((p) => 
        p["status"] == "Completed").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search completed pick lists...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (completedPickLists.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.history, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No completed pick lists found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...completedPickLists.map((pickList) => _buildPickListCard(pickList)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Pick Lists",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Active", icon: Icon(Icons.work)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildActiveTab(),
        _buildHistoryTab(),
      ],
    );
  }
}
