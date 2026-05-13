import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmTransferOrdersView extends StatefulWidget {
  const IwmTransferOrdersView({super.key});

  @override
  State<IwmTransferOrdersView> createState() => _IwmTransferOrdersViewState();
}

class _IwmTransferOrdersViewState extends State<IwmTransferOrdersView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedFromWarehouse = "all";
  String selectedToWarehouse = "all";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "In Transit", "value": "in_transit"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Cancelled", "value": "cancelled"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Urgent", "value": "urgent"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];
  
  List<Map<String, dynamic>> warehouses = [
    {"label": "All Warehouses", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Secondary Warehouse", "value": "secondary"},
    {"label": "Distribution Center", "value": "distribution"},
    {"label": "Regional Hub", "value": "regional"},
  ];
  
  List<Map<String, dynamic>> transferSummary = [
    {
      "title": "Total Orders",
      "value": 156,
      "subtitle": "This Month",
      "icon": Icons.swap_horiz,
      "color": primaryColor
    },
    {
      "title": "Pending",
      "value": 23,
      "subtitle": "Awaiting Approval",
      "icon": Icons.schedule,
      "color": warningColor
    },
    {
      "title": "In Transit",
      "value": 18,
      "subtitle": "On the Way",
      "icon": Icons.local_shipping,
      "color": infoColor
    },
    {
      "title": "Completed",
      "value": 89,
      "subtitle": "57.1% Success",
      "icon": Icons.check_circle,
      "color": successColor
    },
  ];
  
  List<Map<String, dynamic>> transferOrders = [
    {
      "id": "TO-2024-001",
      "fromWarehouse": "Main Warehouse",
      "toWarehouse": "Distribution Center",
      "status": "In Transit",
      "priority": "High",
      "requestDate": "2024-01-15",
      "approvedDate": "2024-01-15",
      "shippedDate": "2024-01-16",
      "expectedDelivery": "2024-01-18",
      "requestedBy": "John Smith",
      "approvedBy": "Sarah Johnson",
      "totalItems": 5,
      "totalQuantity": 125,
      "totalValue": 15750.0,
      "trackingNumber": "TRK-789456123",
      "items": [
        {"sku": "SKU-001", "name": "Premium Office Chair", "qty": 25, "value": 3125.0},
        {"sku": "SKU-002", "name": "Wireless Mouse", "qty": 50, "value": 2250.0},
        {"sku": "SKU-003", "name": "USB Cable", "qty": 30, "value": 360.0},
        {"sku": "SKU-004", "name": "Laptop Stand", "qty": 15, "value": 1125.0},
        {"sku": "SKU-005", "name": "Bluetooth Keyboard", "qty": 5, "value": 449.95},
      ]
    },
    {
      "id": "TO-2024-002",
      "fromWarehouse": "Distribution Center",
      "toWarehouse": "Regional Hub",
      "status": "Pending",
      "priority": "Medium",
      "requestDate": "2024-01-17",
      "approvedDate": null,
      "shippedDate": null,
      "expectedDelivery": "2024-01-22",
      "requestedBy": "Mike Chen",
      "approvedBy": null,
      "totalItems": 3,
      "totalQuantity": 85,
      "totalValue": 8520.0,
      "trackingNumber": null,
      "items": [
        {"sku": "SKU-006", "name": "Monitor Stand", "qty": 20, "value": 3000.0},
        {"sku": "SKU-007", "name": "Desk Lamp", "qty": 40, "value": 3200.0},
        {"sku": "SKU-008", "name": "Cable Organizer", "qty": 25, "value": 500.0},
      ]
    },
    {
      "id": "TO-2024-003",
      "fromWarehouse": "Secondary Warehouse",
      "toWarehouse": "Main Warehouse",
      "status": "Delivered",
      "priority": "Low",
      "requestDate": "2024-01-10",
      "approvedDate": "2024-01-11",
      "shippedDate": "2024-01-12",
      "expectedDelivery": "2024-01-14",
      "requestedBy": "Emily Davis",
      "approvedBy": "Alex Rodriguez",
      "totalItems": 4,
      "totalQuantity": 95,
      "totalValue": 6825.0,
      "trackingNumber": "TRK-456789012",
      "items": [
        {"sku": "SKU-009", "name": "Ergonomic Cushion", "qty": 30, "value": 1800.0},
        {"sku": "SKU-010", "name": "Document Holder", "qty": 25, "value": 1250.0},
        {"sku": "SKU-011", "name": "Paper Tray", "qty": 40, "value": 2000.0},
      ]
    },
    {
      "id": "TO-2024-004",
      "fromWarehouse": "Main Warehouse",
      "toWarehouse": "Secondary Warehouse",
      "status": "Draft",
      "priority": "Urgent",
      "requestDate": "2024-01-18",
      "approvedDate": null,
      "shippedDate": null,
      "expectedDelivery": "2024-01-20",
      "requestedBy": "Lisa Wang",
      "approvedBy": null,
      "totalItems": 2,
      "totalQuantity": 15,
      "totalValue": 4500.0,
      "trackingNumber": null,
      "items": [
        {"sku": "SKU-012", "name": "Executive Chair", "qty": 10, "value": 3500.0},
        {"sku": "SKU-013", "name": "Conference Table", "qty": 5, "value": 2500.0},
      ]
    },
  ];
  
  List<Map<String, dynamic>> pendingApprovals = [
    {
      "id": "TO-2024-002",
      "fromWarehouse": "Distribution Center",
      "toWarehouse": "Regional Hub",
      "requestedBy": "Mike Chen",
      "requestDate": "2024-01-17",
      "priority": "Medium",
      "totalValue": 8520.0,
      "reason": "Stock redistribution for seasonal demand"
    },
    {
      "id": "TO-2024-005",
      "fromWarehouse": "Main Warehouse",
      "toWarehouse": "Distribution Center",
      "requestedBy": "John Smith",
      "requestDate": "2024-01-18",
      "priority": "High",
      "totalValue": 12750.0,
      "reason": "Emergency stock replenishment"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Transfer Orders",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Orders", icon: Icon(Icons.list_alt)),
        Tab(text: "Approvals", icon: Icon(Icons.approval)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildOrdersTab(),
        _buildApprovalsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildTransferSummary(),
          _buildTransferFlow(),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderFilters(),
          _buildOrdersList(),
        ],
      ),
    );
  }

  Widget _buildApprovalsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildApprovalFilters(),
          _buildPendingApprovalsList(),
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
                  label: "Priority",
                  items: priorityOptions,
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
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
                  label: "From Warehouse",
                  items: warehouses,
                  value: selectedFromWarehouse,
                  onChanged: (value, label) {
                    selectedFromWarehouse = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "To Warehouse",
                  items: warehouses,
                  value: selectedToWarehouse,
                  onChanged: (value, label) {
                    selectedToWarehouse = value;
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

  Widget _buildOrderFilters() {
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
          QButton(
            icon: Icons.add,
            label: "New Order",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalFilters() {
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
            child: QDropdownField(
              label: "Priority",
              items: priorityOptions,
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.approval,
            label: "Bulk Approve",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTransferSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Transfer Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: transferSummary.map((summary) => _buildSummaryCard(summary)).toList(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> summary) {
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
                  color: (summary["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  summary["icon"],
                  color: summary["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${summary["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferFlow() {
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
            "Transfer Flow",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.timeline,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Transfer Flow Diagram",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    List<Map<String, dynamic>> activities = [
      {"action": "Order Shipped", "order": "TO-2024-001", "user": "Sarah Johnson", "time": "2 hours ago"},
      {"action": "Order Approved", "order": "TO-2024-003", "user": "Alex Rodriguez", "time": "5 hours ago"},
      {"action": "Order Created", "order": "TO-2024-004", "user": "Lisa Wang", "time": "1 day ago"},
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
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...activities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
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
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["action"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${activity["order"]} • ${activity["user"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${activity["time"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    return Column(
      spacing: spSm,
      children: transferOrders.map((order) => _buildOrderCard(order)).toList(),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor = _getStatusColor(order["status"]);
    Color priorityColor = _getPriorityColor(order["priority"]);
    
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
                      "${order["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${order["fromWarehouse"]} → ${order["toWarehouse"]}",
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Requested by: ${order["requestedBy"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Request Date: ${order["requestDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (order["trackingNumber"] != null)
                      Text(
                        "Tracking: ${order["trackingNumber"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${order["totalItems"]} items",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${order["totalQuantity"]} units",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${((order["totalValue"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Items Summary:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(order["items"] as List).take(3).map((item) => Text(
                  "• ${item["name"]}: ${item["qty"]} units (\$${((item["value"] as double).toDouble()).currency})",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                )),
                if ((order["items"] as List).length > 3)
                  Text(
                    "+ ${(order["items"] as List).length - 3} more items",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              if (order["expectedDelivery"] != null)
                Text(
                  "Expected: ${order["expectedDelivery"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPendingApprovalsList() {
    return Column(
      spacing: spSm,
      children: pendingApprovals.map((approval) => _buildApprovalCard(approval)).toList(),
    );
  }

  Widget _buildApprovalCard(Map<String, dynamic> approval) {
    Color priorityColor = _getPriorityColor(approval["priority"]);
    
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
                      "${approval["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${approval["fromWarehouse"]} → ${approval["toWarehouse"]}",
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
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${approval["priority"]}",
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 12,
                  ),
                ),
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
                      "Requested by: ${approval["requestedBy"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Request Date: ${approval["requestDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((approval["totalValue"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Total Value",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "Reason: ${approval["reason"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Reject",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Approve",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'draft':
        return disabledBoldColor;
      case 'pending':
        return warningColor;
      case 'approved':
        return infoColor;
      case 'in transit':
        return warningColor;
      case 'delivered':
        return successColor;
      case 'cancelled':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return dangerColor;
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
