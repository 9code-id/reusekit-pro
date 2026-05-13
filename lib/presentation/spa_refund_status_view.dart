import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaRefundStatusView extends StatefulWidget {
  const SpaRefundStatusView({super.key});

  @override
  State<SpaRefundStatusView> createState() => _SpaRefundStatusViewState();
}

class _SpaRefundStatusViewState extends State<SpaRefundStatusView> {
  String selectedStatus = "all";
  String selectedTimeframe = "all_time";
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "All Refunds", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Processing", "value": "processing"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Completed", "value": "completed"},
  ];  
  List<Map<String, dynamic>> timeframeItems = [
    {"label": "All Time", "value": "all_time"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 3 Months", "value": "3_months"},
    {"label": "Last 6 Months", "value": "6_months"},
    {"label": "This Year", "value": "this_year"},
  ];
  
  List<Map<String, dynamic>> refundRequests = [
    {
      "id": "RF001",
      "orderNumber": "ORD-2024-0001",
      "productName": "Luxury Facial Treatment",
      "amount": 149.99,
      "status": "processing",
      "requestDate": "2024-01-15",
      "expectedDate": "2024-01-22",
      "reason": "Service quality issue",
      "image": "https://picsum.photos/60/60?random=1&keyword=spa",
    },
    {
      "id": "RF002",
      "orderNumber": "ORD-2024-0002",
      "productName": "Aromatherapy Package",
      "amount": 89.50,
      "status": "approved",
      "requestDate": "2024-01-10",
      "expectedDate": "2024-01-17",
      "reason": "Changed mind",
      "image": "https://picsum.photos/60/60?random=2&keyword=aromatherapy",
    },
    {
      "id": "RF003",
      "orderNumber": "ORD-2024-0003",
      "productName": "Massage Therapy Session",
      "amount": 120.00,
      "status": "completed",
      "requestDate": "2024-01-05",
      "expectedDate": "2024-01-12",
      "reason": "Double booking",
      "image": "https://picsum.photos/60/60?random=3&keyword=massage",
    },
    {
      "id": "RF004",
      "orderNumber": "ORD-2024-0004",
      "productName": "Skin Care Products",
      "amount": 75.99,
      "status": "pending",
      "requestDate": "2024-01-18",
      "expectedDate": "2024-01-25",
      "reason": "Product defect",
      "image": "https://picsum.photos/60/60?random=4&keyword=skincare",
    },
    {
      "id": "RF005",
      "orderNumber": "ORD-2024-0005",
      "productName": "Wellness Package",
      "amount": 299.99,
      "status": "rejected",
      "requestDate": "2024-01-12",
      "expectedDate": "N/A",
      "reason": "Outside policy window",
      "image": "https://picsum.photos/60/60?random=5&keyword=wellness",
    },
  ];
  
  List<Map<String, dynamic>> get filteredRefunds {
    return refundRequests.where((refund) {
      if (selectedStatus != "all" && refund["status"] != selectedStatus) {
        return false;
      }
      return true;
    }).toList();
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "processing":
        return infoColor;
      case "approved":
        return successColor;
      case "completed":
        return primaryColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  String _getStatusLabel(String status) {
    switch (status) {
      case "pending":
        return "Pending Review";
      case "processing":
        return "Processing";
      case "approved":
        return "Approved";
      case "completed":
        return "Completed";
      case "rejected":
        return "Rejected";
      default:
        return status;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refund Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Need help with your refund? Contact support");
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
            _buildRefundSummary(),
            _buildFilters(),
            _buildRefundsList(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRefundSummary() {
    double totalPending = filteredRefunds
        .where((r) => r["status"] == "pending" || r["status"] == "processing")
        .fold(0.0, (sum, item) => sum + (item["amount"] as num).toDouble());
    
    double totalCompleted = filteredRefunds
        .where((r) => r["status"] == "completed")
        .fold(0.0, (sum, item) => sum + (item["amount"] as num).toDouble());
    
    int pendingCount = filteredRefunds
        .where((r) => r["status"] == "pending" || r["status"] == "processing")
        .length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Refund Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spMd,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: warningColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${totalPending.currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending Refunds",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "$pendingCount requests",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${totalCompleted.currency}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${filteredRefunds.where((r) => r["status"] == "completed").length} refunds",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Filter Refunds",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
                  label: "Timeframe",
                  items: timeframeItems,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
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
    return Container(
      padding: EdgeInsets.all(spMd),
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
                "Refund Requests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${filteredRefunds.length}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          if (filteredRefunds.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No refund requests found",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your filters",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredRefunds.map((refund) => _buildRefundCard(refund)),
        ],
      ),
    );
  }
  
  Widget _buildRefundCard(Map<String, dynamic> refund) {
    Color statusColor = _getStatusColor(refund["status"]);
    String statusLabel = _getStatusLabel(refund["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowXs],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusXs),
                child: Image.network(
                  "${refund["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      "${refund["productName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Order: ${refund["orderNumber"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "ID: ${refund["id"]}",
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
                spacing: 4,
                children: [
                  Text(
                    "\$${((refund["amount"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      statusLabel,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
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
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: 4,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Reason: ${refund["reason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Requested: ${refund["requestDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (refund["status"] != "rejected")
                      Text(
                        "Expected: ${refund["expectedDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            spacing: spXs,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("Viewing refund details for ${refund["id"]}");
                  },
                ),
              ),
              if (refund["status"] == "pending")
                Expanded(
                  child: QButton(
                    label: "Cancel Request",
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to cancel this refund request?");
                      if (isConfirmed) {
                        ss("Refund request cancelled");
                      }
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
