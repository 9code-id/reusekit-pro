import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmRefundManagementView extends StatefulWidget {
  const IwmRefundManagementView({super.key});

  @override
  State<IwmRefundManagementView> createState() => _IwmRefundManagementViewState();
}

class _IwmRefundManagementViewState extends State<IwmRefundManagementView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String selectedReason = "all";
  String selectedTimeframe = "week";
  String searchQuery = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Processing", "value": "processing"},
    {"label": "Completed", "value": "completed"},
    {"label": "Rejected", "value": "rejected"},
  ];

  List<Map<String, dynamic>> reasonOptions = [
    {"label": "All Reasons", "value": "all"},
    {"label": "Defective Product", "value": "defective"},
    {"label": "Not as Described", "value": "not_described"},
    {"label": "Wrong Item", "value": "wrong_item"},
    {"label": "Damaged in Transit", "value": "damaged"},
    {"label": "Customer Changed Mind", "value": "changed_mind"},
    {"label": "Late Delivery", "value": "late_delivery"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> refundStats = [
    {
      "title": "Total Refunds",
      "value": "\$45,230",
      "count": 156,
      "icon": Icons.payments,
      "color": primaryColor,
      "trend": "+12%"
    },
    {
      "title": "Pending Approval",
      "value": "\$8,450",
      "count": 28,
      "icon": Icons.pending_actions,
      "color": warningColor,
      "trend": "+5%"
    },
    {
      "title": "Processing",
      "value": "\$12,680",
      "count": 42,
      "icon": Icons.hourglass_empty,
      "color": infoColor,
      "trend": "-8%"
    },
    {
      "title": "Completed",
      "value": "\$24,100",
      "count": 86,
      "icon": Icons.check_circle,
      "color": successColor,
      "trend": "+15%"
    },
  ];

  List<Map<String, dynamic>> refundRequests = [
    {
      "id": "REF-2024-001",
      "orderId": "ORD-2024-3421",
      "customerName": "Sarah Johnson",
      "customerEmail": "sarah.johnson@email.com",
      "productName": "Wireless Bluetooth Headphones",
      "refundAmount": 89.99,
      "originalAmount": 89.99,
      "refundType": "Full Refund",
      "reason": "Defective Product",
      "requestDate": "2024-01-18",
      "status": "Pending",
      "priority": "High",
      "approvedBy": "",
      "processedDate": "",
      "paymentMethod": "Credit Card",
      "notes": "Customer reported audio cutting out after 2 days of use",
      "attachments": ["receipt.pdf", "defect_photo.jpg"]
    },
    {
      "id": "REF-2024-002",
      "orderId": "ORD-2024-3398",
      "customerName": "Mike Chen",
      "customerEmail": "mike.chen@email.com",
      "productName": "Smart Watch Series 5",
      "refundAmount": 199.99,
      "originalAmount": 199.99,
      "refundType": "Full Refund",
      "reason": "Wrong Item",
      "requestDate": "2024-01-17",
      "status": "Approved",
      "priority": "Medium",
      "approvedBy": "Admin User",
      "processedDate": "",
      "paymentMethod": "PayPal",
      "notes": "Customer ordered black but received white color",
      "attachments": ["order_confirmation.pdf"]
    },
    {
      "id": "REF-2024-003",
      "orderId": "ORD-2024-3356",
      "customerName": "Emily Davis",
      "customerEmail": "emily.davis@email.com",
      "productName": "Laptop Stand Adjustable",
      "refundAmount": 45.50,
      "originalAmount": 65.50,
      "refundType": "Partial Refund",
      "reason": "Damaged in Transit",
      "requestDate": "2024-01-16",
      "status": "Processing",
      "priority": "Low",
      "approvedBy": "Manager",
      "processedDate": "2024-01-17",
      "paymentMethod": "Credit Card",
      "notes": "Minor scratches on surface, customer keeping item",
      "attachments": ["damage_photos.zip"]
    },
    {
      "id": "REF-2024-004",
      "orderId": "ORD-2024-3289",
      "customerName": "David Wilson",
      "customerEmail": "david.wilson@email.com",
      "productName": "Gaming Mouse RGB",
      "refundAmount": 79.99,
      "originalAmount": 79.99,
      "refundType": "Full Refund",
      "reason": "Not as Described",
      "requestDate": "2024-01-15",
      "status": "Completed",
      "priority": "Medium",
      "approvedBy": "Admin User",
      "processedDate": "2024-01-16",
      "paymentMethod": "Bank Transfer",
      "notes": "RGB lighting feature not working as advertised",
      "attachments": ["product_video.mp4"]
    },
    {
      "id": "REF-2024-005",
      "orderId": "ORD-2024-3201",
      "customerName": "Lisa Wang",
      "customerEmail": "lisa.wang@email.com",
      "productName": "Bluetooth Speaker Portable",
      "refundAmount": 0.00,
      "originalAmount": 59.99,
      "refundType": "Rejected",
      "reason": "Customer Changed Mind",
      "requestDate": "2024-01-14",
      "status": "Rejected",
      "priority": "Low",
      "approvedBy": "",
      "processedDate": "2024-01-15",
      "paymentMethod": "Credit Card",
      "notes": "Return window expired, customer used product for 45 days",
      "attachments": []
    },
  ];

  List<Map<String, dynamic>> refundAnalytics = [
    {"period": "Jan 2024", "amount": 45230.0, "count": 156, "approved": 128, "rejected": 28},
    {"period": "Dec 2023", "amount": 38950.0, "count": 142, "approved": 118, "rejected": 24},
    {"period": "Nov 2023", "amount": 42180.0, "count": 168, "approved": 145, "rejected": 23},
    {"period": "Oct 2023", "amount": 36720.0, "count": 134, "approved": 112, "rejected": 22},
    {"period": "Sep 2023", "amount": 41560.0, "count": 159, "approved": 138, "rejected": 21},
    {"period": "Aug 2023", "amount": 48900.0, "count": 178, "approved": 152, "rejected": 26},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Refund Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Requests", icon: Icon(Icons.receipt_long)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildRequestsTab(),
        _buildAnalyticsTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRefundStats(),
          _buildFilters(),
          _buildRefundsList(),
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
          _buildAnalyticsFilters(),
          _buildRefundTrends(),
          _buildReasonBreakdown(),
          _buildPerformanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRefundPolicies(),
          _buildApprovalSettings(),
          _buildNotificationSettings(),
        ],
      ),
    );
  }

  Widget _buildRefundStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Refund Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: refundStats.map((stat) => _buildStatCard(stat)).toList(),
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
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${stat["trend"]}",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
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
            "${stat["count"]} requests",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
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
                child: QTextField(
                  label: "Search refunds...",
                  value: searchQuery,
                  hint: "Order ID, customer name, or product",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
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
                  label: "Reason",
                  items: reasonOptions,
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

  Widget _buildRefundsList() {
    return Column(
      spacing: spSm,
      children: refundRequests.map((refund) => _buildRefundCard(refund)).toList(),
    );
  }

  Widget _buildRefundCard(Map<String, dynamic> refund) {
    Color statusColor = _getStatusColor(refund["status"]);
    Color priorityColor = _getPriorityColor(refund["priority"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
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
                      "${refund["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Order: ${refund["orderId"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
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
                      "${refund["priority"]}",
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 10,
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
                      "${refund["status"]}",
                      style: TextStyle(
                        color: statusColor,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${refund["customerName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${refund["customerEmail"]}",
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
                    "\$${(refund["refundAmount"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${refund["refundType"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
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
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${refund["productName"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Reason: ${refund["reason"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                if ((refund["notes"] as String).isNotEmpty)
                  Text(
                    "${refund["notes"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "Requested: ${refund["requestDate"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
              Spacer(),
              if (refund["status"] == "Pending")
                Row(
                  children: [
                    QButton(
                      label: "Approve",
                      size: bs.sm,
                      color: successColor,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      label: "Reject",
                      size: bs.sm,
                      color: dangerColor,
                      onPressed: () {},
                    ),
                  ],
                )
              else
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

  Widget _buildAnalyticsFilters() {
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
              label: "Time Period",
              items: timeframeOptions,
              value: selectedTimeframe,
              onChanged: (value, label) {
                selectedTimeframe = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.download,
            label: "Export",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildRefundTrends() {
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
            "Refund Trends",
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
                    Icons.trending_up,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Refund Trend Chart",
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

  Widget _buildReasonBreakdown() {
    List<Map<String, dynamic>> reasonStats = [
      {"reason": "Defective Product", "count": 45, "percentage": 28.8, "color": dangerColor},
      {"reason": "Not as Described", "count": 32, "percentage": 20.5, "color": warningColor},
      {"reason": "Wrong Item", "count": 28, "percentage": 17.9, "color": infoColor},
      {"reason": "Damaged in Transit", "count": 25, "percentage": 16.0, "color": primaryColor},
      {"reason": "Customer Changed Mind", "count": 15, "percentage": 9.6, "color": successColor},
      {"reason": "Late Delivery", "count": 11, "percentage": 7.1, "color": disabledBoldColor},
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
            "Refund Reasons Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...reasonStats.map((reason) => _buildReasonItem(reason)),
        ],
      ),
    );
  }

  Widget _buildReasonItem(Map<String, dynamic> reason) {
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
              color: reason["color"],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${reason["reason"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${reason["count"]} requests (${(reason["percentage"] as double).toStringAsFixed(1)}%)",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (reason["percentage"] as double) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: reason["color"],
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    List<Map<String, dynamic>> metrics = [
      {"title": "Average Processing Time", "value": "2.3 days", "icon": Icons.timer, "color": primaryColor},
      {"title": "Approval Rate", "value": "82.1%", "icon": Icons.check_circle, "color": successColor},
      {"title": "Customer Satisfaction", "value": "4.2/5", "icon": Icons.star, "color": warningColor},
      {"title": "Resolution Time", "value": "4.6 hours", "icon": Icons.schedule, "color": infoColor},
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
            children: metrics.map((metric) => _buildMetricCard(metric)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: (metric["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              metric["icon"],
              color: metric["color"],
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${metric["value"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${metric["title"]}",
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

  Widget _buildRefundPolicies() {
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
            "Refund Policies",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildPolicyItem("Return Window", "30 days", "Maximum days for return eligibility"),
          _buildPolicyItem("Partial Refund Threshold", "20%", "Minimum damage for partial refund"),
          _buildPolicyItem("Auto-Approve Limit", "\$50", "Amount under which refunds are auto-approved"),
          _buildPolicyItem("Processing Time SLA", "48 hours", "Maximum time to process refund requests"),
        ],
      ),
    );
  }

  Widget _buildPolicyItem(String title, String value, String description) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalSettings() {
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
            "Approval Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildApprovalRule("Auto-approve refunds under \$50", true),
          _buildApprovalRule("Require manager approval for > \$200", true),
          _buildApprovalRule("Auto-reject after 60 days", false),
          _buildApprovalRule("Require photo evidence for defects", true),
        ],
      ),
    );
  }

  Widget _buildApprovalRule(String rule, bool enabled) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              rule,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enabled",
                "value": true,
                "checked": enabled,
              }
            ],
            value: enabled ? [{"label": "Enabled", "value": true, "checked": true}] : [],
            onChanged: (values, ids) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
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
            "Notification Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildNotificationItem("Email on new refund request", true),
          _buildNotificationItem("SMS for high-priority refunds", false),
          _buildNotificationItem("Daily refund summary", true),
          _buildNotificationItem("Weekly analytics report", true),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String notification, bool enabled) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              notification,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Enabled",
                "value": true,
                "checked": enabled,
              }
            ],
            value: enabled ? [{"label": "Enabled", "value": true, "checked": true}] : [],
            onChanged: (values, ids) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return warningColor;
      case 'approved':
        return infoColor;
      case 'processing':
        return primaryColor;
      case 'completed':
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
