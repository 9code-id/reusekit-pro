import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmMobileReceivingView extends StatefulWidget {
  const IwmMobileReceivingView({super.key});

  @override
  State<IwmMobileReceivingView> createState() => _IwmMobileReceivingViewState();
}

class _IwmMobileReceivingViewState extends State<IwmMobileReceivingView> {
  int selectedTab = 0;
  String selectedOrder = "";
  String selectedLocation = "";
  bool loading = false;
  
  List<Map<String, dynamic>> pendingReceipts = [
    {
      "id": "PO-2024-001",
      "supplier": "Tech Solutions Inc",
      "expectedDate": "2024-01-15",
      "totalItems": 15,
      "receivedItems": 8,
      "status": "Partial",
      "priority": "High",
      "items": [
        {"sku": "LT-001", "name": "Laptop Dell XPS 13", "ordered": 5, "received": 3, "pending": 2},
        {"sku": "CH-002", "name": "Office Chair Ergonomic", "ordered": 10, "received": 5, "pending": 5},
      ]
    },
    {
      "id": "PO-2024-002",
      "supplier": "Office Supplies Co",
      "expectedDate": "2024-01-16",
      "totalItems": 25,
      "receivedItems": 0,
      "status": "Pending",
      "priority": "Medium",
      "items": [
        {"sku": "MS-003", "name": "Wireless Mouse", "ordered": 15, "received": 0, "pending": 15},
        {"sku": "KB-004", "name": "Wireless Keyboard", "ordered": 10, "received": 0, "pending": 10},
      ]
    },
    {
      "id": "PO-2024-003",
      "supplier": "Hardware Direct",
      "expectedDate": "2024-01-14",
      "totalItems": 8,
      "receivedItems": 8,
      "status": "Complete",
      "priority": "Low",
      "items": [
        {"sku": "MB-005", "name": "Monitor 24 inch", "ordered": 8, "received": 8, "pending": 0},
      ]
    },
  ];
  
  List<Map<String, dynamic>> receivingTasks = [
    {
      "id": "RT-001",
      "item": "Laptop Dell XPS 13",
      "sku": "LT-001",
      "quantity": 2,
      "location": "A-01-01",
      "status": "In Progress",
      "assignedTo": "John Smith",
      "startTime": "2024-01-15 14:30",
      "supplier": "Tech Solutions Inc"
    },
    {
      "id": "RT-002",
      "item": "Office Chair Ergonomic",
      "sku": "CH-002",
      "quantity": 5,
      "location": "B-02-03",
      "status": "Pending",
      "assignedTo": "Sarah Johnson",
      "startTime": null,
      "supplier": "Tech Solutions Inc"
    },
  ];
  
  List<Map<String, dynamic>> recentActivities = [
    {
      "action": "Received",
      "item": "Monitor 24 inch",
      "quantity": 8,
      "user": "Mike Chen",
      "timestamp": "2024-01-15 13:45",
      "status": "completed"
    },
    {
      "action": "Partial Receive",
      "item": "Laptop Dell XPS 13",
      "quantity": 3,
      "user": "John Smith",
      "timestamp": "2024-01-15 12:30",
      "status": "completed"
    },
    {
      "action": "Quality Check",
      "item": "Office Chair Ergonomic",
      "quantity": 5,
      "user": "Sarah Johnson",
      "timestamp": "2024-01-15 11:20",
      "status": "in_progress"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Mobile Receiving",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Orders", icon: Icon(Icons.list_alt)),
        Tab(text: "Receive", icon: Icon(Icons.add_box)),
        Tab(text: "Tasks", icon: Icon(Icons.assignment)),
      ],
      tabChildren: [
        _buildOrdersTab(),
        _buildReceiveTab(),
        _buildTasksTab(),
      ],
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReceivingStats(),
          _buildOrderFilters(),
          _buildPendingReceiptsList(),
        ],
      ),
    );
  }

  Widget _buildReceiveTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReceiveForm(),
          _buildQualityCheckSection(),
          _buildRecentActivitiesSection(),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTaskFilters(),
          _buildReceivingTasksList(),
          _buildTaskStatistics(),
        ],
      ),
    );
  }

  Widget _buildReceivingStats() {
    List<Map<String, dynamic>> stats = [
      {"title": "Pending Orders", "value": "12", "subtitle": "To receive", "icon": Icons.pending_actions, "color": warningColor},
      {"title": "Today's Receipts", "value": "8", "subtitle": "Items received", "icon": Icons.check_circle, "color": successColor},
      {"title": "In Progress", "value": "3", "subtitle": "Being processed", "icon": Icons.hourglass_empty, "color": infoColor},
      {"title": "Overdue", "value": "2", "subtitle": "Past due date", "icon": Icons.warning, "color": dangerColor},
    ];

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: stats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderFilters() {
    return QHorizontalScroll(
      children: [
        _buildFilterChip("All Orders", true),
        _buildFilterChip("Pending", false),
        _buildFilterChip("Partial", false),
        _buildFilterChip("Complete", false),
        _buildFilterChip("Overdue", false),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      margin: EdgeInsets.only(right: spXs),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: isSelected ? primaryColor : disabledOutlineBorderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : disabledBoldColor,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildPendingReceiptsList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Purchase Orders",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...pendingReceipts.map((receipt) => _buildReceiptCard(receipt)),
      ],
    );
  }

  Widget _buildReceiptCard(Map<String, dynamic> receipt) {
    Color statusColor = _getStatusColor(receipt["status"]);
    Color priorityColor = _getPriorityColor(receipt["priority"]);
    double progress = (receipt["receivedItems"] as int) / (receipt["totalItems"] as int);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
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
                      "${receipt["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${receipt["supplier"]}",
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
                      "${receipt["priority"]}",
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
                      "${receipt["status"]}",
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
              Icon(Icons.calendar_today, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "Expected: ${receipt["expectedDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Text(
                "${receipt["receivedItems"]}/${receipt["totalItems"]} items",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Progress",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
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
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Receive",
                size: bs.sm,
                onPressed: () => _startReceiving(receipt),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReceiveForm() {
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
            "Receive Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Scan/Enter SKU",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.qr_code_scanner,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Quantity Received",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Location",
                  value: selectedLocation,
                  onChanged: (value) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Notes (Optional)",
            value: "",
            onChanged: (value) {},
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Receive Item",
                  size: bs.md,
                  onPressed: () => _receiveItem(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.clear,
                size: bs.md,
                onPressed: () => _clearForm(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQualityCheckSection() {
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
            "Quality Check",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              QSwitch(
                items: [
                  {
                    "label": "Passed",
                    "value": true,
                    "checked": true,
                  }
                ],
                value: [{"label": "Passed", "value": true, "checked": true}],
                onChanged: (values, ids) {},
              ),
            ],
          ),
          QMemoField(
            label: "Quality Notes",
            value: "",
            onChanged: (value) {},
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Pass Quality Check",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Reject",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivitiesSection() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Recent Activities",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Text(
                "View All",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        ...recentActivities.map((activity) => _buildActivityCard(activity)),
      ],
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    Color statusColor = _getActivityStatusColor(activity["status"]);
    IconData actionIcon = _getActionIcon(activity["action"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              actionIcon,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["action"]}: ${activity["item"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Qty: ${activity["quantity"]} • ${activity["user"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${activity["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${activity["status"].toString().replaceAll('_', ' ')}",
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskFilters() {
    return QHorizontalScroll(
      children: [
        _buildFilterChip("All Tasks", true),
        _buildFilterChip("Pending", false),
        _buildFilterChip("In Progress", false),
        _buildFilterChip("Completed", false),
        _buildFilterChip("My Tasks", false),
      ],
    );
  }

  Widget _buildReceivingTasksList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Receiving Tasks",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...receivingTasks.map((task) => _buildTaskCard(task)),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color statusColor = _getTaskStatusColor(task["status"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.assignment,
                  color: statusColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${task["item"]} (${task["sku"]})",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.inventory, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "Qty: ${task["quantity"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.location_on, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${task["location"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${task["assignedTo"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              if (task["startTime"] != null) ...[
                SizedBox(width: spSm),
                Icon(Icons.access_time, size: 16, color: disabledColor),
                SizedBox(width: spXs),
                Text(
                  "${task["startTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ],
          ),
          Row(
            children: [
              if (task["status"] == "Pending")
                Expanded(
                  child: QButton(
                    label: "Start Task",
                    size: bs.sm,
                    onPressed: () => _startTask(task),
                  ),
                )
              else if (task["status"] == "In Progress")
                Expanded(
                  child: QButton(
                    label: "Complete Task",
                    size: bs.sm,
                    onPressed: () => _completeTask(task),
                  ),
                ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskStatistics() {
    List<Map<String, dynamic>> taskStats = [
      {"title": "Completed Today", "value": "5", "icon": Icons.check_circle, "color": successColor},
      {"title": "Average Time", "value": "2.5h", "icon": Icons.schedule, "color": infoColor},
      {"title": "Efficiency", "value": "95%", "icon": Icons.trending_up, "color": primaryColor},
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Task Statistics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: taskStats.map((stat) => _buildSmallStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildSmallStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: (stat["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              stat["icon"],
              color: stat["color"],
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${stat["value"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${stat["title"]}",
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

  void _startReceiving(Map<String, dynamic> receipt) {
    selectedOrder = receipt["id"];
    setState(() {});
    selectedTab = 1;
    setState(() {});
    ss("Started receiving for ${receipt["id"]}");
  }

  void _receiveItem() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Item received successfully");
    });
  }

  void _clearForm() {
    selectedLocation = "";
    setState(() {});
  }

  void _startTask(Map<String, dynamic> task) {
    ss("Task ${task["id"]} started");
  }

  void _completeTask(Map<String, dynamic> task) {
    ss("Task ${task["id"]} completed");
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'complete':
        return successColor;
      case 'partial':
        return warningColor;
      case 'pending':
        return infoColor;
      default:
        return disabledColor;
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
        return disabledColor;
    }
  }

  Color _getActivityStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color _getTaskStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return warningColor;
      case 'pending':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action.toLowerCase()) {
      case 'received':
        return Icons.add_box;
      case 'partial receive':
        return Icons.inventory;
      case 'quality check':
        return Icons.verified;
      default:
        return Icons.assignment;
    }
  }
}
