import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmReturnsManagementView extends StatefulWidget {
  const IwmReturnsManagementView({super.key});

  @override
  State<IwmReturnsManagementView> createState() => _IwmReturnsManagementViewState();
}

class _IwmReturnsManagementViewState extends State<IwmReturnsManagementView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedReason = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "In Transit", "value": "in_transit"},
    {"label": "Received", "value": "received"},
    {"label": "Processed", "value": "processed"},
    {"label": "Rejected", "value": "rejected"},
  ];

  List<Map<String, dynamic>> reasonItems = [
    {"label": "All Reasons", "value": "all"},
    {"label": "Defective", "value": "defective"},
    {"label": "Wrong Item", "value": "wrong_item"},
    {"label": "Not as Described", "value": "not_described"},
    {"label": "Changed Mind", "value": "changed_mind"},
    {"label": "Damaged in Transit", "value": "damaged"},
  ];

  List<Map<String, dynamic>> returnsStats = [
    {
      "title": "Total Returns",
      "value": 127,
      "subtitle": "This month",
      "icon": Icons.keyboard_return,
      "color": primaryColor
    },
    {
      "title": "Pending Review",
      "value": 23,
      "subtitle": "Need attention",
      "icon": Icons.pending,
      "color": warningColor
    },
    {
      "title": "Return Rate",
      "value": 3.2,
      "subtitle": "% of total orders",
      "icon": Icons.trending_down,
      "color": dangerColor
    },
    {
      "title": "Avg Process Time",
      "value": 4.5,
      "subtitle": "Days",
      "icon": Icons.timer,
      "color": infoColor
    },
  ];

  List<Map<String, dynamic>> returnRequests = [
    {
      "id": "RET-2024-001",
      "orderId": "ORD-789012",
      "customer": "John Smith",
      "customerEmail": "john.smith@email.com",
      "product": "Wireless Headphones",
      "sku": "WH-001",
      "quantity": 1,
      "reason": "Defective",
      "description": "Left ear speaker not working properly",
      "status": "Pending",
      "requestDate": "2024-01-20",
      "approvalDate": "",
      "refundAmount": 149.99,
      "restockFee": 0.00,
      "images": ["https://picsum.photos/100/100?random=1&keyword=headphones"],
      "priority": "High",
      "assignedTo": "Sarah Johnson",
      "returnMethod": "Pickup",
      "trackingNumber": "",
      "condition": "Used",
      "resellable": false
    },
    {
      "id": "RET-2024-002",
      "orderId": "ORD-789013",
      "customer": "Mike Chen",
      "customerEmail": "mike.chen@email.com",
      "product": "Gaming Keyboard",
      "sku": "GK-205",
      "quantity": 1,
      "reason": "Wrong Item",
      "description": "Ordered black keyboard but received white one",
      "status": "Approved",
      "requestDate": "2024-01-19",
      "approvalDate": "2024-01-20",
      "refundAmount": 89.99,
      "restockFee": 0.00,
      "images": ["https://picsum.photos/100/100?random=2&keyword=keyboard"],
      "priority": "Medium",
      "assignedTo": "Lisa Davis",
      "returnMethod": "Mail",
      "trackingNumber": "1234567890",
      "condition": "New",
      "resellable": true
    },
    {
      "id": "RET-2024-003",
      "orderId": "ORD-789014",
      "customer": "Sarah Johnson",
      "customerEmail": "sarah.j@email.com",
      "product": "Smartwatch",
      "sku": "SW-102",
      "quantity": 1,
      "reason": "Not as Described",
      "description": "Battery life much shorter than advertised",
      "status": "In Transit",
      "requestDate": "2024-01-18",
      "approvalDate": "2024-01-19",
      "refundAmount": 199.99,
      "restockFee": 15.00,
      "images": ["https://picsum.photos/100/100?random=3&keyword=watch"],
      "priority": "Low",
      "assignedTo": "Tom Wilson",
      "returnMethod": "Mail",
      "trackingNumber": "9876543210",
      "condition": "Used",
      "resellable": false
    },
  ];

  List<Map<String, dynamic>> returnPolicies = [
    {
      "category": "Electronics",
      "returnWindow": 30,
      "restockFee": 15.0,
      "conditions": ["Original packaging", "No physical damage", "All accessories included"]
    },
    {
      "category": "Clothing",
      "returnWindow": 60,
      "restockFee": 0.0,
      "conditions": ["Unworn condition", "Tags attached", "Original packaging"]
    },
    {
      "category": "Books",
      "returnWindow": 14,
      "restockFee": 0.0,
      "conditions": ["No writing or highlighting", "No torn pages", "Original condition"]
    },
  ];

  List<Map<String, dynamic>> reasonAnalysis = [
    {"reason": "Defective", "count": 45, "percentage": 35.4},
    {"reason": "Wrong Item", "count": 32, "percentage": 25.2},
    {"reason": "Not as Described", "count": 28, "percentage": 22.0},
    {"reason": "Damaged in Transit", "count": 15, "percentage": 11.8},
    {"reason": "Changed Mind", "count": 7, "percentage": 5.5},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Returns Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Returns", icon: Icon(Icons.keyboard_return)),
        Tab(text: "Policies", icon: Icon(Icons.policy)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildReturnsTab(),
        _buildPoliciesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildReturnsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(),
          _buildQuickActions(),
          _buildReturnsList(),
        ],
      ),
    );
  }

  Widget _buildPoliciesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyHeader(),
          _buildPoliciesList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReturnsStats(),
          _buildReasonAnalysis(),
          _buildTrendChart(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
            label: "Search returns",
            value: searchQuery,
            hint: "Search by return ID, order ID, or customer name",
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
                  label: "Reason",
                  items: reasonItems,
                  value: selectedReason,
                  onChanged: (value, label) {
                    selectedReason = value;
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

  Widget _buildQuickActions() {
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
            child: QButton(
              label: "Process Returns",
              icon: Icons.play_arrow,
              size: bs.sm,
              onPressed: () {},
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildReturnsList() {
    return Column(
      spacing: spSm,
      children: returnRequests.map((returnItem) => _buildReturnCard(returnItem)).toList(),
    );
  }

  Widget _buildReturnCard(Map<String, dynamic> returnItem) {
    Color statusColor = _getStatusColor(returnItem["status"]);
    Color priorityColor = _getPriorityColor(returnItem["priority"]);
    
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
                      "${returnItem["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Order: ${returnItem["orderId"]}",
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
                      "${returnItem["priority"]}",
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
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${returnItem["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
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
                    "${(returnItem["images"] as List)[0]}",
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
                      "${returnItem["product"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "SKU: ${returnItem["sku"]} • Qty: ${returnItem["quantity"]}",
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
                          "${returnItem["reason"]}",
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
                      "${returnItem["customer"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.email, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${returnItem["customerEmail"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                if (returnItem["description"].toString().isNotEmpty)
                  Text(
                    "${returnItem["description"]}",
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
                      "Refund: \$${(returnItem["refundAmount"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if ((returnItem["restockFee"] as double) > 0)
                      Text(
                        "Restock Fee: \$${(returnItem["restockFee"] as double).toStringAsFixed(2)}",
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
                      "Assigned: ${returnItem["assignedTo"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Requested: ${returnItem["requestDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Review",
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _showReturnDetails(returnItem),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Text(
            "Return Policies",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          QButton(
            label: "Add Policy",
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPoliciesList() {
    return Column(
      spacing: spSm,
      children: returnPolicies.map((policy) => _buildPolicyCard(policy)).toList(),
    );
  }

  Widget _buildPolicyCard(Map<String, dynamic> policy) {
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
              Text(
                "${policy["category"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Return Window",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${policy["returnWindow"]} days",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                            "Restock Fee",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            (policy["restockFee"] as double) > 0 
                                ? "${(policy["restockFee"] as double).toStringAsFixed(1)}%"
                                : "None",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: (policy["restockFee"] as double) > 0 ? dangerColor : successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: disabledOutlineBorderColor),
                Text(
                  "Conditions:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ...(policy["conditions"] as List).map((condition) => Padding(
                  padding: EdgeInsets.only(left: spSm),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 12, color: successColor),
                      SizedBox(width: spXs),
                      Text(
                        "$condition",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReturnsStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Returns Statistics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: returnsStats.map((stat) => _buildStatCard(stat)).toList(),
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
            stat["title"] == "Return Rate" || stat["title"] == "Avg Process Time"
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

  Widget _buildReasonAnalysis() {
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
            "Return Reasons Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...reasonAnalysis.map((reason) => _buildReasonAnalysisCard(reason)),
        ],
      ),
    );
  }

  Widget _buildReasonAnalysisCard(Map<String, dynamic> reason) {
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
          Expanded(
            flex: 2,
            child: Text(
              "${reason["reason"]}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "${reason["count"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "${(reason["percentage"] as double).toStringAsFixed(1)}%",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
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
            "Returns Trend",
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
                    Icons.trending_down,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Trend Chart",
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

  void _showReturnDetails(Map<String, dynamic> returnItem) {
    // Show detailed return information and processing options
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return successColor;
      case 'pending':
        return warningColor;
      case 'in transit':
        return infoColor;
      case 'received':
        return primaryColor;
      case 'processed':
        return successColor;
      case 'rejected':
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
