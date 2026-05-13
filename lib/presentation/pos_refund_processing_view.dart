import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosRefundProcessingView extends StatefulWidget {
  const PosRefundProcessingView({super.key});

  @override
  State<PosRefundProcessingView> createState() => _PosRefundProcessingViewState();
}

class _PosRefundProcessingViewState extends State<PosRefundProcessingView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPaymentMethod = "all";
  String refundReason = "";
  String refundAmount = "";
  String refundNotes = "";
  bool processing = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Processed", "value": "processed"},
    {"label": "Failed", "value": "failed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> paymentMethodOptions = [
    {"label": "All Methods", "value": "all"},
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Debit Card", "value": "debit_card"},
    {"label": "Cash", "value": "cash"},
    {"label": "Digital Wallet", "value": "digital_wallet"},
  ];

  List<Map<String, dynamic>> reasonOptions = [
    {"label": "Product Defective", "value": "defective"},
    {"label": "Wrong Item", "value": "wrong_item"},
    {"label": "Customer Changed Mind", "value": "changed_mind"},
    {"label": "Damaged in Transit", "value": "damaged"},
    {"label": "Not as Described", "value": "not_described"},
    {"label": "Duplicate Order", "value": "duplicate"},
  ];

  List<Map<String, dynamic>> refundRequests = [
    {
      "id": "REF001",
      "order_id": "ORD12345",
      "customer_name": "John Smith",
      "product": "iPhone 14 Pro",
      "original_amount": 999.99,
      "refund_amount": 999.99,
      "reason": "Product Defective",
      "status": "pending",
      "payment_method": "credit_card",
      "request_date": "2024-01-15 10:30",
      "processed_date": null,
      "processor": null,
      "notes": "Screen flickering after 2 days of use",
    },
    {
      "id": "REF002",
      "order_id": "ORD12346",
      "customer_name": "Sarah Johnson",
      "product": "MacBook Air",
      "original_amount": 1299.99,
      "refund_amount": 1299.99,
      "reason": "Changed mind",
      "status": "processed",
      "payment_method": "debit_card",
      "request_date": "2024-01-14 14:20",
      "processed_date": "2024-01-14 16:45",
      "processor": "Admin User",
      "notes": "Full refund processed within return window",
    },
    {
      "id": "REF003",
      "order_id": "ORD12347",
      "customer_name": "Mike Wilson",
      "product": "AirPods Pro",
      "original_amount": 249.99,
      "refund_amount": 187.49,
      "reason": "Damaged in transit",
      "status": "processed",
      "payment_method": "cash",
      "request_date": "2024-01-13 09:15",
      "processed_date": "2024-01-13 11:30",
      "processor": "Manager",
      "notes": "Partial refund due to restocking fee",
    },
    {
      "id": "REF004",
      "order_id": "ORD12348",
      "customer_name": "Emma Davis",
      "product": "Samsung Galaxy S23",
      "original_amount": 799.99,
      "refund_amount": 799.99,
      "reason": "Wrong item delivered",
      "status": "failed",
      "payment_method": "digital_wallet",
      "request_date": "2024-01-12 13:45",
      "processed_date": "2024-01-12 15:20",
      "processor": "Staff Member",
      "notes": "Payment gateway error - needs manual intervention",
    },
    {
      "id": "REF005",
      "order_id": "ORD12349",
      "customer_name": "David Brown",
      "product": "Dell Laptop",
      "original_amount": 899.99,
      "refund_amount": 0.00,
      "reason": "Duplicate order",
      "status": "cancelled",
      "payment_method": "credit_card",
      "request_date": "2024-01-11 11:30",
      "processed_date": null,
      "processor": null,
      "notes": "Customer cancelled request - chose exchange instead",
    },
  ];

  List<Map<String, dynamic>> get filteredRefunds {
    return refundRequests.where((refund) {
      bool matchesSearch = refund["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          refund["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          refund["product"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || refund["status"] == selectedStatus;
      bool matchesPayment = selectedPaymentMethod == "all" || refund["payment_method"] == selectedPaymentMethod;
      
      return matchesSearch && matchesStatus && matchesPayment;
    }).toList();
  }

  double get totalPendingAmount {
    return refundRequests
        .where((refund) => refund["status"] == "pending")
        .fold(0.0, (sum, refund) => sum + (refund["refund_amount"] as double));
  }

  double get totalProcessedAmount {
    return refundRequests
        .where((refund) => refund["status"] == "processed")
        .fold(0.0, (sum, refund) => sum + (refund["refund_amount"] as double));
  }

  int get pendingCount {
    return refundRequests.where((refund) => refund["status"] == "pending").length;
  }

  int get processedToday {
    return refundRequests.where((refund) => 
        refund["status"] == "processed" && 
        refund["processed_date"] != null &&
        refund["processed_date"].toString().contains("2024-01-15")).length;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "processed":
        return successColor;
      case "failed":
        return dangerColor;
      case "cancelled":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "pending":
        return "Pending";
      case "processed":
        return "Processed";
      case "failed":
        return "Failed";
      case "cancelled":
        return "Cancelled";
      default:
        return status;
    }
  }

  void _processRefund(Map<String, dynamic> refund) {
    // Simulate refund processing
    setState(() {
      processing = true;
    });
    
    // Simulate API call delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        processing = false;
        refund["status"] = "processed";
        refund["processed_date"] = "2024-01-15 ${TimeOfDay.now().kkmm}";
        refund["processor"] = "Current User";
      });
      ss("Refund processed successfully");
    });
  }

  void _showRefundDialog(Map<String, dynamic> refund) {
    refundAmount = refund["refund_amount"].toString();
    refundReason = refund["reason"];
    refundNotes = refund["notes"] ?? "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Process Refund"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Refund Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order ID:"),
                        Text("${refund["order_id"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Customer:"),
                        Text("${refund["customer_name"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Product:"),
                        Expanded(
                          child: Text(
                            "${refund["product"]}", 
                            style: TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QNumberField(
                label: "Refund Amount (\$)",
                value: refundAmount,
                onChanged: (value) {
                  refundAmount = value;
                },
              ),
              QDropdownField(
                label: "Refund Reason",
                items: reasonOptions,
                value: refundReason,
                onChanged: (value, label) {
                  refundReason = value;
                },
              ),
              QMemoField(
                label: "Processing Notes",
                value: refundNotes,
                hint: "Add any additional notes about the refund processing",
                onChanged: (value) {
                  refundNotes = value;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: processing ? "Processing..." : "Process Refund",
            size: bs.sm,
            onPressed: processing ? null : () {
              Navigator.pop(context);
              _processRefund(refund);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refund Processing"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              ss("Refund data refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard(
                  "Pending Refunds",
                  "$pendingCount",
                  Icons.pending_actions,
                  warningColor,
                  subtitle: "\$${totalPendingAmount.currency}",
                ),
                _buildStatCard(
                  "Processed Today",
                  "$processedToday",
                  Icons.check_circle,
                  successColor,
                  subtitle: "\$${totalProcessedAmount.currency}",
                ),
                _buildStatCard(
                  "Total Processed",
                  "${refundRequests.where((r) => r["status"] == "processed").length}",
                  Icons.done_all,
                  primaryColor,
                  subtitle: "This month",
                ),
                _buildStatCard(
                  "Failed Refunds",
                  "${refundRequests.where((r) => r["status"] == "failed").length}",
                  Icons.error,
                  dangerColor,
                  subtitle: "Need attention",
                ),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search refunds...",
                    value: searchQuery,
                    hint: "Search by customer, order ID, or product",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Status",
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
                          label: "Filter by Payment",
                          items: paymentMethodOptions,
                          value: selectedPaymentMethod,
                          onChanged: (value, label) {
                            selectedPaymentMethod = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Refund Requests List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Refund Requests",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${filteredRefunds.length} requests",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  if (filteredRefunds.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48,
                              color: disabledColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "No refund requests found",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...filteredRefunds.map((refund) => _buildRefundCard(refund)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, {String? subtitle}) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRefundCard(Map<String, dynamic> refund) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
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
                      fontSize: 16,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(refund["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _getStatusLabel(refund["status"]),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(refund["status"]),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${refund["customer_name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.shopping_bag,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${refund["product"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Refund Amount",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${(refund["refund_amount"] as double).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Reason",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${refund["reason"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (refund["notes"] != null && refund["notes"].toString().isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.note,
                    size: 16,
                    color: infoColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${refund["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Requested: ${refund["request_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (refund["status"] == "pending")
                QButton(
                  label: "Process",
                  size: bs.sm,
                  onPressed: () => _showRefundDialog(refund),
                )
              else if (refund["processed_date"] != null)
                Text(
                  "Processed: ${refund["processed_date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
