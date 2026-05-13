import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmMobilePickingView extends StatefulWidget {
  const IwmMobilePickingView({super.key});

  @override
  State<IwmMobilePickingView> createState() => _IwmMobilePickingViewState();
}

class _IwmMobilePickingViewState extends State<IwmMobilePickingView> {
  int selectedTab = 0;
  String selectedOrder = "";
  String selectedPicker = "";
  bool loading = false;
  
  List<Map<String, dynamic>> pickingOrders = [
    {
      "id": "SO-2024-001",
      "customer": "ABC Corporation",
      "orderDate": "2024-01-15",
      "dueDate": "2024-01-16",
      "totalItems": 8,
      "pickedItems": 5,
      "status": "In Progress",
      "priority": "High",
      "assignedTo": "John Smith",
      "zone": "Zone A",
      "items": [
        {"sku": "LT-001", "name": "Laptop Dell XPS 13", "ordered": 2, "picked": 2, "location": "A-01-01"},
        {"sku": "MS-003", "name": "Wireless Mouse", "ordered": 3, "picked": 3, "location": "C-01-05"},
        {"sku": "KB-004", "name": "Wireless Keyboard", "ordered": 3, "picked": 0, "location": "C-02-01"},
      ]
    },
    {
      "id": "SO-2024-002",
      "customer": "Tech Solutions Inc",
      "orderDate": "2024-01-15",
      "dueDate": "2024-01-17",
      "totalItems": 12,
      "pickedItems": 0,
      "status": "Pending",
      "priority": "Medium",
      "assignedTo": "Sarah Johnson",
      "zone": "Zone B",
      "items": [
        {"sku": "CH-002", "name": "Office Chair Ergonomic", "ordered": 5, "picked": 0, "location": "B-02-03"},
        {"sku": "MB-005", "name": "Monitor 24 inch", "ordered": 7, "picked": 0, "location": "B-01-02"},
      ]
    },
    {
      "id": "SO-2024-003",
      "customer": "Office Supplies Co",
      "orderDate": "2024-01-14",
      "dueDate": "2024-01-15",
      "totalItems": 6,
      "pickedItems": 6,
      "status": "Complete",
      "priority": "Low",
      "assignedTo": "Mike Chen",
      "zone": "Zone C",
      "items": [
        {"sku": "DS-006", "name": "Desk Organizer", "ordered": 6, "picked": 6, "location": "C-03-01"},
      ]
    },
  ];
  
  List<Map<String, dynamic>> pickingTasks = [
    {
      "id": "PT-001",
      "orderId": "SO-2024-001",
      "item": "Wireless Keyboard",
      "sku": "KB-004",
      "quantity": 3,
      "location": "C-02-01",
      "zone": "Zone C",
      "status": "Active",
      "priority": "High",
      "estimatedTime": "5 min",
      "picker": "John Smith"
    },
    {
      "id": "PT-002",
      "orderId": "SO-2024-002",
      "item": "Office Chair Ergonomic",
      "sku": "CH-002",
      "quantity": 5,
      "location": "B-02-03",
      "zone": "Zone B",
      "status": "Pending",
      "priority": "Medium",
      "estimatedTime": "8 min",
      "picker": "Sarah Johnson"
    },
  ];
  
  List<Map<String, dynamic>> recentPickingActivities = [
    {
      "action": "Picked",
      "item": "Wireless Mouse",
      "quantity": 3,
      "order": "SO-2024-001",
      "picker": "John Smith",
      "timestamp": "2024-01-15 14:30",
      "location": "C-01-05",
      "status": "completed"
    },
    {
      "action": "Picked",
      "item": "Laptop Dell XPS 13",
      "quantity": 2,
      "order": "SO-2024-001",
      "picker": "John Smith",
      "timestamp": "2024-01-15 13:45",
      "location": "A-01-01",
      "status": "completed"
    },
    {
      "action": "Started Picking",
      "item": "Wireless Keyboard",
      "quantity": 3,
      "order": "SO-2024-001",
      "picker": "John Smith",
      "timestamp": "2024-01-15 14:35",
      "location": "C-02-01",
      "status": "in_progress"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Mobile Picking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Orders", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Pick", icon: Icon(Icons.checklist)),
        Tab(text: "Tasks", icon: Icon(Icons.assignment_turned_in)),
      ],
      tabChildren: [
        _buildOrdersTab(),
        _buildPickTab(),
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
          _buildPickingStats(),
          _buildOrderFilters(),
          _buildPickingOrdersList(),
        ],
      ),
    );
  }

  Widget _buildPickTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPickingInterface(),
          _buildPickingProgress(),
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
          _buildPickingTasksList(),
          _buildTaskStatistics(),
        ],
      ),
    );
  }

  Widget _buildPickingStats() {
    List<Map<String, dynamic>> stats = [
      {"title": "Active Orders", "value": "8", "subtitle": "In progress", "icon": Icons.shopping_cart, "color": primaryColor},
      {"title": "Completed Today", "value": "15", "subtitle": "Orders fulfilled", "icon": Icons.check_circle, "color": successColor},
      {"title": "Pick Rate", "value": "95%", "subtitle": "Accuracy", "icon": Icons.trending_up, "color": infoColor},
      {"title": "Overdue", "value": "2", "subtitle": "Need attention", "icon": Icons.warning, "color": dangerColor},
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
        _buildFilterChip("In Progress", false),
        _buildFilterChip("Complete", false),
        _buildFilterChip("My Orders", false),
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

  Widget _buildPickingOrdersList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Picking Orders",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...pickingOrders.map((order) => _buildPickingOrderCard(order)),
      ],
    );
  }

  Widget _buildPickingOrderCard(Map<String, dynamic> order) {
    Color statusColor = _getStatusColor(order["status"]);
    Color priorityColor = _getPriorityColor(order["priority"]);
    double progress = (order["pickedItems"] as int) / (order["totalItems"] as int);

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
                      "${order["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${order["customer"]}",
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
                      "${order["priority"]}",
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
                      "${order["status"]}",
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
              Icon(Icons.person, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${order["assignedTo"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.location_on, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "${order["zone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Text(
                "Due: ${order["dueDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
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
                    "Progress (${order["pickedItems"]}/${order["totalItems"]} items)",
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
                  label: "View Items",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              if (order["status"] != "Complete")
                QButton(
                  label: "Start Picking",
                  size: bs.sm,
                  onPressed: () => _startPicking(order),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPickingInterface() {
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
            "Pick Items",
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
                  label: "Quantity to Pick",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Location",
                  value: "",
                  onChanged: (value) {},
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
                  label: "Pick Item",
                  size: bs.md,
                  onPressed: () => _pickItem(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.clear,
                size: bs.md,
                onPressed: () => _clearPickForm(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPickingProgress() {
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
            "Current Order Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (selectedOrder.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No active picking order",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Select an order to start picking",
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          else
            _buildActiveOrderProgress(),
        ],
      ),
    );
  }

  Widget _buildActiveOrderProgress() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(5),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order: $selectedOrder",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Customer: ABC Corporation",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Progress: 5/8 items",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "63%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              LinearProgressIndicator(
                value: 0.6,
                backgroundColor: disabledOutlineBorderColor,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ],
          ),
        ),
        QButton(
          label: "Complete Order",
          size: bs.md,
          onPressed: () => _completeOrder(),
        ),
      ],
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
        ...recentPickingActivities.take(3).map((activity) => _buildActivityCard(activity)),
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
                  "Qty: ${activity["quantity"]} • Order: ${activity["order"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${activity["picker"]} • ${activity["timestamp"]}",
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
        _buildFilterChip("Active", false),
        _buildFilterChip("Pending", false),
        _buildFilterChip("Completed", false),
        _buildFilterChip("My Tasks", false),
      ],
    );
  }

  Widget _buildPickingTasksList() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Picking Tasks",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...pickingTasks.map((task) => _buildTaskCard(task)),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color statusColor = _getTaskStatusColor(task["status"]);
    Color priorityColor = _getPriorityColor(task["priority"]);

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
                  Icons.checklist,
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
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${task["priority"]}",
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
                      "${task["status"]}",
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
                "${task["location"]} (${task["zone"]})",
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
                "${task["picker"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.schedule, size: 16, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "Est. ${task["estimatedTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              Text(
                "Order: ${task["orderId"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
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
              else if (task["status"] == "Active")
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
      {"title": "Pick Rate", "value": "25/hr", "icon": Icons.speed, "color": primaryColor},
      {"title": "Accuracy", "value": "98%", "icon": Icons.check_circle, "color": successColor},
      {"title": "Avg Time", "value": "3.2min", "icon": Icons.schedule, "color": infoColor},
      {"title": "Tasks Today", "value": "18", "icon": Icons.today, "color": warningColor},
    ];

    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Performance Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: taskStats.map((stat) => _buildPerformanceCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildPerformanceCard(Map<String, dynamic> stat) {
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

  void _startPicking(Map<String, dynamic> order) {
    selectedOrder = order["id"];
    setState(() {});
    selectedTab = 1;
    setState(() {});
    ss("Started picking for order ${order["id"]}");
  }

  void _pickItem() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Item picked successfully");
    });
  }

  void _clearPickForm() {
    setState(() {});
  }

  void _completeOrder() {
    ss("Order completed successfully");
    selectedOrder = "";
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
      case 'in progress':
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
      case 'active':
        return warningColor;
      case 'completed':
        return successColor;
      case 'pending':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action.toLowerCase()) {
      case 'picked':
        return Icons.check_circle;
      case 'started picking':
        return Icons.play_arrow;
      default:
        return Icons.assignment;
    }
  }
}
