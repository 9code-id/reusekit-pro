import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmRefundProcessingView extends StatefulWidget {
  const EcmRefundProcessingView({super.key});

  @override
  State<EcmRefundProcessingView> createState() => _EcmRefundProcessingViewState();
}

class _EcmRefundProcessingViewState extends State<EcmRefundProcessingView> {
  String filterStatus = "all";
  String filterPeriod = "30";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> refunds = [
    {
      "id": "REF-2024-001",
      "orderId": "ORD-2024-5501",
      "transactionId": "txn_1A2B3C4D5E",
      "customer": "John Smith",
      "customerEmail": "john.smith@email.com",
      "originalAmount": 299.99,
      "refundAmount": 299.99,
      "refundType": "full",
      "status": "completed",
      "reason": "customer_request",
      "requestDate": "2024-06-15",
      "processedDate": "2024-06-16",
      "gateway": "Stripe",
      "processingFee": -8.99,
      "notes": "Customer requested full refund due to product defect",
      "requestedBy": "customer",
      "approvedBy": "support_team",
      "refundMethod": "original_payment"
    },
    {
      "id": "REF-2024-002",
      "orderId": "ORD-2024-5502",
      "transactionId": "pp_1F2G3H4I5J",
      "customer": "Sarah Johnson",
      "customerEmail": "sarah.j@email.com",
      "originalAmount": 149.50,
      "refundAmount": 74.75,
      "refundType": "partial",
      "status": "pending",
      "reason": "damaged_item",
      "requestDate": "2024-06-18",
      "processedDate": null,
      "gateway": "PayPal",
      "processingFee": 0.0,
      "notes": "Partial refund for damaged item in order",
      "requestedBy": "customer",
      "approvedBy": null,
      "refundMethod": "original_payment"
    },
    {
      "id": "REF-2024-003",
      "orderId": "ORD-2024-5503",
      "transactionId": "ap_1P2Q3R4S5T",
      "customer": "Mike Wilson",
      "customerEmail": "mike.w@email.com",
      "originalAmount": 799.00,
      "refundAmount": 799.00,
      "refundType": "full",
      "status": "rejected",
      "reason": "outside_policy",
      "requestDate": "2024-06-10",
      "processedDate": "2024-06-12",
      "gateway": "Apple Pay",
      "processingFee": 0.0,
      "notes": "Refund request rejected - outside of return policy timeframe",
      "requestedBy": "customer",
      "approvedBy": "manager",
      "refundMethod": "original_payment"
    },
    {
      "id": "REF-2024-004",
      "orderId": "ORD-2024-5504",
      "transactionId": "gp_1U2V3W4X5Y",
      "customer": "Emma Davis",
      "customerEmail": "emma.davis@email.com",
      "originalAmount": 89.99,
      "refundAmount": 89.99,
      "refundType": "full",
      "status": "processing",
      "reason": "technical_issue",
      "requestDate": "2024-06-19",
      "processedDate": null,
      "gateway": "Google Pay",
      "processingFee": 0.0,
      "notes": "Technical issue prevented service delivery",
      "requestedBy": "admin",
      "approvedBy": "support_team",
      "refundMethod": "original_payment"
    },
    {
      "id": "REF-2024-005",
      "orderId": "ORD-2024-5505",
      "transactionId": "bt_1K2L3M4N5O",
      "customer": "David Brown",
      "customerEmail": "david.brown@email.com",
      "originalAmount": 459.75,
      "refundAmount": 200.00,
      "refundType": "partial",
      "status": "completed",
      "reason": "service_issue",
      "requestDate": "2024-06-14",
      "processedDate": "2024-06-15",
      "gateway": "Bank Transfer",
      "processingFee": -2.00,
      "notes": "Partial refund for service disruption",
      "requestedBy": "admin",
      "approvedBy": "manager",
      "refundMethod": "bank_transfer"
    }
  ];

  List<Map<String, dynamic>> get filteredRefunds {
    List<Map<String, dynamic>> filtered = List.from(refunds);
    
    if (filterStatus != "all") {
      filtered = filtered.where((refund) => refund["status"] == filterStatus).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((refund) => 
        (refund["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (refund["orderId"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (refund["customer"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (refund["customerEmail"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "pending":
        return warningColor;
      case "processing":
        return infoColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "pending":
        return "Pending";
      case "processing":
        return "Processing";
      case "rejected":
        return "Rejected";
      default:
        return "Unknown";
    }
  }

  String _getReasonText(String reason) {
    switch (reason) {
      case "customer_request":
        return "Customer Request";
      case "damaged_item":
        return "Damaged Item";
      case "outside_policy":
        return "Outside Policy";
      case "technical_issue":
        return "Technical Issue";
      case "service_issue":
        return "Service Issue";
      default:
        return "Other";
    }
  }

  IconData _getRefundTypeIcon(String type) {
    switch (type) {
      case "full":
        return Icons.replay;
      case "partial":
        return Icons.replay_circle_filled;
      default:
        return Icons.undo;
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalRefunds = refunds.map((r) => r["refundAmount"] as double).reduce((a, b) => a + b);
    int completedCount = refunds.where((r) => r["status"] == "completed").length;
    int pendingCount = refunds.where((r) => r["status"] == "pending").length;
    int rejectedCount = refunds.where((r) => r["status"] == "rejected").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Refund Processing"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show advanced filters
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: [
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
                      Row(
                        children: [
                          Icon(Icons.undo, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Refunds",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${refunds.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.payments, color: dangerColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Refund Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(totalRefunds / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$completedCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.pending, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$pendingCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Quick Actions
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      QButton(
                        label: "Process Refund",
                        size: bs.sm,
                        onPressed: () {
                          // Process new refund
                        },
                      ),
                      QButton(
                        label: "Bulk Approve",
                        size: bs.sm,
                        onPressed: () {
                          // Bulk approve pending refunds
                        },
                      ),
                      QButton(
                        label: "Export Report",
                        size: bs.sm,
                        onPressed: () {
                          // Export refund report
                        },
                      ),
                      QButton(
                        label: "Refund Policy",
                        size: bs.sm,
                        onPressed: () {
                          // View refund policy
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search refunds...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Pending", "value": "pending"},
                      {"label": "Processing", "value": "processing"},
                      {"label": "Completed", "value": "completed"},
                      {"label": "Rejected", "value": "rejected"},
                    ],
                    value: filterStatus,
                    onChanged: (value, label) {
                      filterStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Refund Processing Stats
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
                    "Processing Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Approval Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(((completedCount / refunds.length) * 100)).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Avg Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${(totalRefunds / refunds.length).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rejection Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${((rejectedCount / refunds.length) * 100).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Refunds List
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Refunds (${filteredRefunds.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Process New",
                        size: bs.sm,
                        onPressed: () {
                          // Process new refund
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredRefunds.map((refund) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(refund["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getRefundTypeIcon(refund["refundType"]),
                                  color: _getStatusColor(refund["status"]),
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${refund["id"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${refund["customer"]} • ${refund["orderId"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          size: 12,
                                          color: disabledColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          _getReasonText(refund["reason"]),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${((refund["refundAmount"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: dangerColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(refund["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      _getStatusText(refund["status"]),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(refund["status"]),
                                      ),
                                    ),
                                  ),
                                ],
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
                                      "Type",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(refund["refundType"] as String).replaceAll("_", " ").toUpperCase()}",
                                      style: TextStyle(
                                        fontSize: 13,
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
                                      "Gateway",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${refund["gateway"]}",
                                      style: TextStyle(
                                        fontSize: 13,
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
                                      "Original",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((refund["originalAmount"] as double).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
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
                                      "Requested",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${refund["requestDate"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (refund["notes"] != null) ...[
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${refund["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // View refund details
                                  },
                                ),
                              ),
                              if (refund["status"] == "pending") ...[
                                SizedBox(width: spSm),
                                QButton(
                                  label: "Approve",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Approve refund request
                                  },
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  label: "Reject",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Reject refund request
                                  },
                                ),
                              ],
                              if (refund["status"] == "completed") ...[
                                SizedBox(width: spSm),
                                QButton(
                                  label: "Receipt",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Download refund receipt
                                  },
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
