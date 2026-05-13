import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaRefundManagementView extends StatefulWidget {
  const FmaRefundManagementView({super.key});

  @override
  State<FmaRefundManagementView> createState() => _FmaRefundManagementViewState();
}

class _FmaRefundManagementViewState extends State<FmaRefundManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedReason = "all";

  List<Map<String, dynamic>> refunds = [
    {
      "id": "REF001",
      "order_id": "ORD2024001",
      "customer": "Jennifer Adams",
      "amount": 45.80,
      "reason": "Food Quality",
      "status": "Pending Review",
      "request_date": "2024-06-19 10:15",
      "due_date": "2024-06-21 10:15",
      "payment_method": "Credit Card",
      "description": "Pizza arrived cold and soggy",
      "evidence_provided": true,
      "approval_required": true,
      "estimated_processing": "3-5 business days",
      "customer_rating": 2,
      "refund_type": "Full Refund"
    },
    {
      "id": "REF002",
      "order_id": "ORD2024002",
      "customer": "Mark Thompson",
      "amount": 28.50,
      "reason": "Wrong Order",
      "status": "Approved",
      "request_date": "2024-06-19 08:30",
      "due_date": "2024-06-20 08:30",
      "payment_method": "Digital Wallet",
      "description": "Received chicken instead of fish",
      "evidence_provided": true,
      "approval_required": false,
      "estimated_processing": "1-2 business days",
      "customer_rating": 3,
      "refund_type": "Partial Refund"
    },
    {
      "id": "REF003",
      "order_id": "ORD2024003",
      "customer": "Lisa Garcia",
      "amount": 62.00,
      "reason": "Order Cancelled",
      "status": "Processing",
      "request_date": "2024-06-18 16:45",
      "due_date": "2024-06-19 16:45",
      "payment_method": "Bank Transfer",
      "description": "Restaurant closed unexpectedly",
      "evidence_provided": false,
      "approval_required": false,
      "estimated_processing": "2-3 business days",
      "customer_rating": 4,
      "refund_type": "Full Refund"
    },
    {
      "id": "REF004",
      "order_id": "ORD2024004",
      "customer": "David Wilson",
      "amount": 34.25,
      "reason": "Late Delivery",
      "status": "Completed",
      "request_date": "2024-06-17 12:20",
      "due_date": "2024-06-18 12:20",
      "payment_method": "Credit Card",
      "description": "Food delivered 3 hours late",
      "evidence_provided": true,
      "approval_required": true,
      "estimated_processing": "Completed",
      "customer_rating": 5,
      "refund_type": "Service Credit"
    },
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending Review", "value": "Pending Review"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Processing", "value": "Processing"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Rejected", "value": "Rejected"},
  ];

  List<Map<String, dynamic>> reasonItems = [
    {"label": "All Reasons", "value": "all"},
    {"label": "Food Quality", "value": "Food Quality"},
    {"label": "Wrong Order", "value": "Wrong Order"},
    {"label": "Late Delivery", "value": "Late Delivery"},
    {"label": "Order Cancelled", "value": "Order Cancelled"},
    {"label": "Missing Items", "value": "Missing Items"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Refund Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Requests", icon: Icon(Icons.money_off)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Policies", icon: Icon(Icons.policy)),
      ],
      tabChildren: [
        _buildRefundsTab(),
        _buildAnalyticsTab(),
        _buildPoliciesTab(),
      ],
    );
  }

  Widget _buildRefundsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildRefundsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search refunds...",
                value: searchQuery,
                hint: "Search by customer, order ID, or refund ID",
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
          spacing: spSm,
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
    );
  }

  Widget _buildRefundsList() {
    return Column(
      spacing: spSm,
      children: refunds.map((refund) => _buildRefundCard(refund)).toList(),
    );
  }

  Widget _buildRefundCard(Map<String, dynamic> refund) {
    Color statusColor = _getStatusColor("${refund["status"]}");
    double amount = refund["amount"] as double;
    int rating = refund["customer_rating"] as int;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${refund["id"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Order: ${refund["order_id"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${refund["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.category, size: 16, color: infoColor),
                SizedBox(width: spXs),
                Text(
                  "${refund["reason"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${refund["refund_type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${refund["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${refund["customer"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              Spacer(),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 12,
                    color: index < rating ? warningColor : disabledColor,
                  );
                }),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.payment, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${refund["payment_method"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${refund["estimated_processing"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Due: ${refund["due_date"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              if (refund["evidence_provided"] as bool)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.attach_file, size: 12, color: successColor),
                      SizedBox(width: 2),
                      Text(
                        "Evidence",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (refund["approval_required"] as bool)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.approval, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Text(
                    "Manager approval required",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              if (refund["status"] == "Pending Review")
                Expanded(
                  child: QButton(
                    label: "Approve",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              if (refund["status"] == "Approved")
                Expanded(
                  child: QButton(
                    label: "Process",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Refunds", "248", Icons.money_off, dangerColor),
              _buildMetricCard("Pending", "12", Icons.pending, warningColor),
              _buildMetricCard("Avg Amount", "\$38.50", Icons.attach_money, infoColor),
              _buildMetricCard("Success Rate", "94%", Icons.check_circle, successColor),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Refund Reasons",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildReasonItem("Food Quality", 35, dangerColor),
                      _buildReasonItem("Wrong Order", 25, warningColor),
                      _buildReasonItem("Late Delivery", 20, infoColor),
                      _buildReasonItem("Missing Items", 12, primaryColor),
                      _buildReasonItem("Other", 8, successColor),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Processing Time",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildTimeItem("< 24 hours", 42, successColor),
                      _buildTimeItem("1-3 days", 35, infoColor),
                      _buildTimeItem("3-7 days", 18, warningColor),
                      _buildTimeItem("> 7 days", 5, dangerColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Monthly Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  height: 150,
                  child: Center(
                    child: Text(
                      "Chart showing refund trends over the last 6 months",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonItem(String reason, int percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(reason, style: TextStyle(fontSize: 14)),
        ),
        Text(
          "$percentage%",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeItem(String timeframe, int percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(timeframe, style: TextStyle(fontSize: 14)),
        ),
        Text(
          "$percentage%",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildPoliciesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Refund Eligibility",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildPolicyItem(
                  "Food Quality Issues",
                  "Full refund within 24 hours of delivery",
                  Icons.food_bank,
                  successColor,
                ),
                _buildPolicyItem(
                  "Wrong Order",
                  "Full refund or replacement order",
                  Icons.swap_horiz,
                  infoColor,
                ),
                _buildPolicyItem(
                  "Late Delivery (>2 hours)",
                  "Partial refund or store credit",
                  Icons.schedule,
                  warningColor,
                ),
                _buildPolicyItem(
                  "Order Cancellation",
                  "Full refund if cancelled by restaurant",
                  Icons.cancel,
                  dangerColor,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Processing Guidelines",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildGuidelineItem("1", "Review request within 4 hours"),
                _buildGuidelineItem("2", "Verify order details and customer history"),
                _buildGuidelineItem("3", "Check for evidence and documentation"),
                _buildGuidelineItem("4", "Apply appropriate refund policy"),
                _buildGuidelineItem("5", "Process refund and notify customer"),
                _buildGuidelineItem("6", "Follow up for customer satisfaction"),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Approval Thresholds",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildThresholdItem("Auto-approve", "< \$25", successColor),
                _buildThresholdItem("Supervisor approval", "\$25 - \$100", warningColor),
                _buildThresholdItem("Manager approval", "\$100 - \$500", infoColor),
                _buildThresholdItem("Director approval", "> \$500", dangerColor),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Refund Methods & Timeline",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildMethodItem("Credit Card", "3-5 business days", Icons.credit_card),
                _buildMethodItem("Digital Wallet", "1-2 business days", Icons.account_balance_wallet),
                _buildMethodItem("Bank Transfer", "2-3 business days", Icons.account_balance),
                _buildMethodItem("Store Credit", "Immediate", Icons.card_giftcard),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyItem(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: color.withAlpha(50)),
        borderRadius: BorderRadius.circular(radiusXs),
        color: color.withAlpha(10),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
        ],
      ),
    );
  }

  Widget _buildGuidelineItem(String step, String description) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Center(
            child: Text(
              step,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildThresholdItem(String level, String amount, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              amount,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              level,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodItem(String method, String timeline, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: primaryColor),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  timeline,
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending Review":
        return warningColor;
      case "Approved":
        return infoColor;
      case "Processing":
        return primaryColor;
      case "Completed":
        return successColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
