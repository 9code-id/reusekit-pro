import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmPickListsView extends StatefulWidget {
  const IwmPickListsView({super.key});

  @override
  State<IwmPickListsView> createState() => _IwmPickListsViewState();
}

class _IwmPickListsViewState extends State<IwmPickListsView> {
  String selectedStatus = "all";
  String selectedWave = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Created", "value": "created"},
    {"label": "Assigned", "value": "assigned"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
    {"label": "On Hold", "value": "on_hold"},
  ];
  
  List<Map<String, dynamic>> waveOptions = [
    {"label": "All Waves", "value": "all"},
    {"label": "Wave 001", "value": "wave_001"},
    {"label": "Wave 002", "value": "wave_002"},
    {"label": "Wave 003", "value": "wave_003"},
    {"label": "Wave 004", "value": "wave_004"},
  ];
  
  List<Map<String, dynamic>> pickLists = [
    {
      "id": "PL-2024-001",
      "waveId": "Wave 001",
      "ordersCount": 15,
      "itemsCount": 87,
      "assignedTo": "John Smith",
      "status": "In Progress",
      "priority": "High",
      "zone": "Zone A",
      "estimatedTime": "2.5 hours",
      "completedItems": 52,
      "createdAt": "2024-01-15 08:30",
      "startedAt": "2024-01-15 09:00",
      "dueAt": "2024-01-15 12:00",
      "orders": [
        {"id": "ORD-001", "customer": "ABC Corp", "items": 5, "completed": true},
        {"id": "ORD-002", "customer": "XYZ Ltd", "items": 8, "completed": true},
        {"id": "ORD-003", "customer": "Tech Solutions", "items": 6, "completed": false},
      ]
    },
    {
      "id": "PL-2024-002",
      "waveId": "Wave 001",
      "ordersCount": 22,
      "itemsCount": 134,
      "assignedTo": "Sarah Wilson",
      "status": "Created",
      "priority": "Medium",
      "zone": "Zone B",
      "estimatedTime": "3.2 hours",
      "completedItems": 0,
      "createdAt": "2024-01-15 09:15",
      "startedAt": null,
      "dueAt": "2024-01-15 14:00",
      "orders": [
        {"id": "ORD-004", "customer": "Global Inc", "items": 12, "completed": false},
        {"id": "ORD-005", "customer": "Metro Corp", "items": 15, "completed": false},
        {"id": "ORD-006", "customer": "Prime Systems", "items": 9, "completed": false},
      ]
    },
    {
      "id": "PL-2024-003",
      "waveId": "Wave 002",
      "ordersCount": 8,
      "itemsCount": 45,
      "assignedTo": "Mike Chen",
      "status": "Completed",
      "priority": "Low",
      "zone": "Zone C",
      "estimatedTime": "1.5 hours",
      "completedItems": 45,
      "createdAt": "2024-01-15 07:45",
      "startedAt": "2024-01-15 08:15",
      "completedAt": "2024-01-15 09:45",
      "dueAt": "2024-01-15 11:00",
      "orders": [
        {"id": "ORD-007", "customer": "Alpha Systems", "items": 8, "completed": true},
        {"id": "ORD-008", "customer": "Beta Corp", "items": 12, "completed": true},
        {"id": "ORD-009", "customer": "Gamma Inc", "items": 7, "completed": true},
      ]
    },
    {
      "id": "PL-2024-004",
      "waveId": "Wave 002",
      "ordersCount": 18,
      "itemsCount": 92,
      "assignedTo": "Lisa Davis",
      "status": "On Hold",
      "priority": "High",
      "zone": "Zone A",
      "estimatedTime": "2.8 hours",
      "completedItems": 35,
      "createdAt": "2024-01-15 10:30",
      "startedAt": "2024-01-15 11:00",
      "dueAt": "2024-01-15 15:00",
      "holdReason": "Inventory shortage - Item SKU-12345",
      "orders": [
        {"id": "ORD-010", "customer": "Delta Industries", "items": 10, "completed": true},
        {"id": "ORD-011", "customer": "Echo Systems", "items": 14, "completed": false},
        {"id": "ORD-012", "customer": "Foxtrot Corp", "items": 8, "completed": false},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Lists"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            _buildPickListsOverview(),
            _buildPickListsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
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
                  label: "Wave",
                  items: waveOptions,
                  value: selectedWave,
                  onChanged: (value, label) {
                    selectedWave = value;
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

  Widget _buildPickListsOverview() {
    List<Map<String, dynamic>> overview = [
      {"title": "Total Lists", "value": 47, "color": primaryColor, "icon": Icons.list_alt},
      {"title": "In Progress", "value": 12, "color": warningColor, "icon": Icons.schedule},
      {"title": "Completed", "value": 28, "color": successColor, "icon": Icons.check_circle},
      {"title": "On Hold", "value": 7, "color": dangerColor, "icon": Icons.pause_circle},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pick Lists Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: overview.map((item) => _buildOverviewCard(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (item["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (item["color"] as Color).withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(
            item["icon"],
            color: item["color"],
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["value"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: item["color"],
                  ),
                ),
                Text(
                  "${item["title"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickListsList() {
    return Column(
      spacing: spSm,
      children: pickLists.map((pickList) => _buildPickListCard(pickList)).toList(),
    );
  }

  Widget _buildPickListCard(Map<String, dynamic> pickList) {
    Color statusColor = _getStatusColor(pickList["status"]);
    Color priorityColor = _getPriorityColor(pickList["priority"]);
    double progress = (pickList["completedItems"] as int) / (pickList["itemsCount"] as int);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${pickList["waveId"]} • ${pickList["zone"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${pickList["priority"]}",
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${pickList["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Orders: ${pickList["ordersCount"]} • Items: ${pickList["itemsCount"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Assigned to: ${pickList["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Est: ${pickList["estimatedTime"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Due: ${pickList["dueAt"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (pickList["status"] == "In Progress" || pickList["status"] == "On Hold")
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: ${pickList["completedItems"]}/${pickList["itemsCount"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(progress * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: disabledOutlineBorderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          if (pickList["status"] == "On Hold" && pickList["holdReason"] != null)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Hold Reason: ${pickList["holdReason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Text(
                "Created: ${pickList["createdAt"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  _showPickListDetails(pickList);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPickListDetails(Map<String, dynamic> pickList) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${pickList["id"]} Details"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Orders in this Pick List:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...(pickList["orders"] as List<Map<String, dynamic>>).map((order) =>
                Container(
                  padding: EdgeInsets.all(spXs),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (order["completed"] as bool) ? Icons.check_circle : Icons.circle_outlined,
                        color: (order["completed"] as bool) ? successColor : disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${order["id"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${order["customer"]} • ${order["items"]} items",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return primaryColor;
      case 'created':
      case 'assigned':
        return warningColor;
      case 'on hold':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
