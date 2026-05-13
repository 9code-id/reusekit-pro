import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmReturnRequestsView extends StatefulWidget {
  const IwmReturnRequestsView({super.key});

  @override
  State<IwmReturnRequestsView> createState() => _IwmReturnRequestsViewState();
}

class _IwmReturnRequestsViewState extends State<IwmReturnRequestsView> {
  int selectedTab = 0;
  String selectedStatus = "pending";
  String selectedPriority = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> statusItems = [
    {"label": "Pending Review", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "All Status", "value": "all"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priorities", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> pendingRequests = [
    {
      "id": "RRQ-2024-001",
      "orderId": "ORD-789020",
      "customer": "Emily Davis",
      "customerEmail": "emily.davis@email.com",
      "product": "Bluetooth Speaker",
      "sku": "BS-301",
      "quantity": 1,
      "reason": "Defective",
      "description": "Speaker stops working after 10 minutes of use",
      "requestDate": "2024-01-20 14:30",
      "priority": "High",
      "orderValue": 79.99,
      "eligibleRefund": 79.99,
      "restockFee": 0.00,
      "images": ["https://picsum.photos/100/100?random=1&keyword=speaker"],
      "purchaseDate": "2024-01-05",
      "daysFromPurchase": 15,
      "customerHistory": {"orders": 12, "returns": 1, "rating": 4.8},
      "returnMethod": "Mail",
      "urgencyScore": 85
    },
    {
      "id": "RRQ-2024-002",
      "orderId": "ORD-789021",
      "customer": "Alex Johnson",
      "customerEmail": "alex.j@email.com",
      "product": "USB Cable Set",
      "sku": "UC-105",
      "quantity": 2,
      "reason": "Wrong Item",
      "description": "Ordered USB-C cables but received micro USB cables",
      "requestDate": "2024-01-20 11:15",
      "priority": "Medium",
      "orderValue": 29.99,
      "eligibleRefund": 29.99,
      "restockFee": 0.00,
      "images": ["https://picsum.photos/100/100?random=2&keyword=cable"],
      "purchaseDate": "2024-01-18",
      "daysFromPurchase": 2,
      "customerHistory": {"orders": 3, "returns": 0, "rating": 5.0},
      "returnMethod": "Pickup",
      "urgencyScore": 65
    },
    {
      "id": "RRQ-2024-003",
      "orderId": "ORD-789022",
      "customer": "Maria Rodriguez",
      "customerEmail": "maria.r@email.com",
      "product": "Fitness Tracker",
      "sku": "FT-210",
      "quantity": 1,
      "reason": "Not as Described",
      "description": "Heart rate monitor feature not working as advertised",
      "requestDate": "2024-01-19 16:45",
      "priority": "Low",
      "orderValue": 149.99,
      "eligibleRefund": 134.99,
      "restockFee": 15.00,
      "images": ["https://picsum.photos/100/100?random=3&keyword=fitness"],
      "purchaseDate": "2023-12-20",
      "daysFromPurchase": 31,
      "customerHistory": {"orders": 8, "returns": 2, "rating": 4.2},
      "returnMethod": "Mail",
      "urgencyScore": 45
    },
  ];

  List<Map<String, dynamic>> requestStats = [
    {
      "title": "Pending Requests",
      "value": 23,
      "subtitle": "Need review",
      "icon": Icons.pending_actions,
      "color": warningColor
    },
    {
      "title": "Approved Today",
      "value": 8,
      "subtitle": "+3 from yesterday",
      "icon": Icons.check_circle,
      "color": successColor
    },
    {
      "title": "Avg Response Time",
      "value": 2.4,
      "subtitle": "Hours",
      "icon": Icons.schedule,
      "color": infoColor
    },
    {
      "title": "Approval Rate",
      "value": 78.5,
      "subtitle": "Last 30 days",
      "icon": Icons.trending_up,
      "color": primaryColor
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Bulk Approve",
      "description": "Approve multiple low-risk requests at once",
      "icon": Icons.done_all,
      "color": successColor,
      "count": 5
    },
    {
      "title": "Priority Review",
      "description": "Review high-priority and high-value requests",
      "icon": Icons.priority_high,
      "color": dangerColor,
      "count": 3
    },
    {
      "title": "Customer Contact",
      "description": "Requests requiring customer clarification",
      "icon": Icons.contact_support,
      "color": infoColor,
      "count": 7
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Return Requests",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Pending", icon: Icon(Icons.pending_actions)),
        Tab(text: "Quick Actions", icon: Icon(Icons.flash_on)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildPendingTab(),
        _buildQuickActionsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildPendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildRequestStats(),
          _buildPendingRequestsList(),
        ],
      ),
    );
  }

  Widget _buildQuickActionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickActionsList(),
          _buildAutomationSettings(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHistoryFilters(),
          _buildProcessingHistory(),
        ],
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
          QTextField(
            label: "Search requests",
            value: searchQuery,
            hint: "Search by request ID, order ID, or customer name",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
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
                  label: "Priority",
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
        ],
      ),
    );
  }

  Widget _buildRequestStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Request Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: requestStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
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
            stat["title"] == "Avg Response Time" || stat["title"] == "Approval Rate"
                ? "${stat["value"]}"
                : "${stat["value"]}",
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
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingRequestsList() {
    return Column(
      spacing: spSm,
      children: pendingRequests.map((request) => _buildRequestCard(request)).toList(),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    Color priorityColor = _getPriorityColor(request["priority"]);
    Color urgencyColor = _getUrgencyColor(request["urgencyScore"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: (request["urgencyScore"] as int) > 80 
              ? dangerColor.withAlpha(50) 
              : disabledOutlineBorderColor,
        ),
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
                      "${request["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Order: ${request["orderId"]}",
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
                      "${request["priority"]}",
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: urgencyColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${request["urgencyScore"]}",
                      style: TextStyle(
                        color: urgencyColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${(request["images"] as List)[0]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${request["product"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "SKU: ${request["sku"]} • Qty: ${request["quantity"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Reason: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${request["reason"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${request["customer"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(request["customerHistory"] as Map)["orders"]} orders • ${(request["customerHistory"] as Map)["returns"]} returns",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${request["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Value: \$${(request["orderValue"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Eligible Refund: \$${(request["eligibleRefund"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if ((request["restockFee"] as double) > 0)
                      Text(
                        "Restock Fee: \$${(request["restockFee"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Requested: ${request["requestDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                    Text(
                      "${request["daysFromPurchase"]} days from purchase",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  QButton(
                    label: "Approve",
                    icon: Icons.check,
                    size: bs.sm,
                    onPressed: () => _approveRequest(request),
                  ),
                  SizedBox(height: spXs),
                  QButton(
                    label: "Review",
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () => _showRequestDetails(request),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsList() {
    return Column(
      spacing: spSm,
      children: quickActions.map((action) => _buildQuickActionCard(action)).toList(),
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
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
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (action["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              action["icon"],
              color: action["color"],
              size: 24,
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
                      "${action["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: (action["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${action["count"]}",
                        style: TextStyle(
                          color: action["color"],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${action["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.arrow_forward,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationSettings() {
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
            "Automation Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.smart_toy, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Auto-approve requests under \$50 from customers with 5+ orders and 0 returns",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, color: infoColor, size: 20),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Auto-reject requests after 30 days from purchase",
                        style: TextStyle(
                          color: infoColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDatePicker(
              label: "From Date",
              value: DateTime.now().subtract(Duration(days: 30)),
              onChanged: (value) {},
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDatePicker(
              label: "To Date",
              value: DateTime.now(),
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingHistory() {
    List<Map<String, dynamic>> history = [
      {"date": "2024-01-20 15:30", "action": "Approved", "request": "RRQ-2024-001", "user": "Admin"},
      {"date": "2024-01-20 14:15", "action": "Rejected", "request": "RRQ-2024-002", "user": "Manager"},
      {"date": "2024-01-20 11:45", "action": "Approved", "request": "RRQ-2024-003", "user": "Admin"},
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
            "Processing History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...history.map((item) => _buildHistoryItem(item)),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    Color actionColor = item["action"] == "Approved" ? successColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 30,
            decoration: BoxDecoration(
              color: actionColor,
              borderRadius: BorderRadius.circular(radiusXs),
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
                      "${item["action"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: actionColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${item["request"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "by ${item["user"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${item["date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _approveRequest(Map<String, dynamic> request) {
    ss("Request ${request["id"]} approved successfully");
  }

  void _showRequestDetails(Map<String, dynamic> request) {
    // Show detailed request review dialog
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

  Color _getUrgencyColor(int score) {
    if (score >= 80) return dangerColor;
    if (score >= 60) return warningColor;
    if (score >= 40) return infoColor;
    return successColor;
  }
}
