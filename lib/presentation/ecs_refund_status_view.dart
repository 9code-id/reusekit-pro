import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsRefundStatusView extends StatefulWidget {
  const EcsRefundStatusView({super.key});

  @override
  State<EcsRefundStatusView> createState() => _EcsRefundStatusViewState();
}

class _EcsRefundStatusViewState extends State<EcsRefundStatusView> {
  String selectedFilter = "All";
  bool loading = false;

  List<Map<String, dynamic>> refundRequests = [
    {
      "id": "REF001",
      "orderNumber": "ORD-2024-001",
      "productName": "Wireless Bluetooth Headphones",
      "amount": 89.99,
      "status": "Approved",
      "requestDate": "2024-03-15",
      "processedDate": "2024-03-18",
      "reason": "Product defective",
      "estimatedRefund": "3-5 business days",
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones",
    },
    {
      "id": "REF002",
      "orderNumber": "ORD-2024-002",
      "productName": "Smartphone Case",
      "amount": 24.99,
      "status": "Pending",
      "requestDate": "2024-03-20",
      "processedDate": null,
      "reason": "Wrong item received",
      "estimatedRefund": "5-7 business days",
      "image": "https://picsum.photos/80/80?random=2&keyword=phone",
    },
    {
      "id": "REF003",
      "orderNumber": "ORD-2024-003",
      "productName": "Gaming Mouse",
      "amount": 45.00,
      "status": "Rejected",
      "requestDate": "2024-03-10",
      "processedDate": "2024-03-12",
      "reason": "Item damaged during shipping",
      "estimatedRefund": null,
      "rejectionReason": "Return window expired",
      "image": "https://picsum.photos/80/80?random=3&keyword=mouse",
    },
    {
      "id": "REF004",
      "orderNumber": "ORD-2024-004",
      "productName": "Laptop Stand",
      "amount": 35.50,
      "status": "Processing",
      "requestDate": "2024-03-22",
      "processedDate": null,
      "reason": "Size not suitable",
      "estimatedRefund": "3-5 business days",
      "image": "https://picsum.photos/80/80?random=4&keyword=laptop",
    },
    {
      "id": "REF005",
      "orderNumber": "ORD-2024-005",
      "productName": "USB-C Cable",
      "amount": 12.99,
      "status": "Completed",
      "requestDate": "2024-03-05",
      "processedDate": "2024-03-08",
      "refundedDate": "2024-03-10",
      "reason": "Quality issue",
      "estimatedRefund": "Refunded",
      "image": "https://picsum.photos/80/80?random=5&keyword=cable",
    },
  ];

  List<String> filterOptions = ["All", "Pending", "Processing", "Approved", "Completed", "Rejected"];

  List<Map<String, dynamic>> get filteredRequests {
    if (selectedFilter == "All") return refundRequests;
    return refundRequests.where((request) => request["status"] == selectedFilter).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Completed":
        return primaryColor;
      case "Pending":
        return warningColor;
      case "Processing":
        return infoColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _viewRefundDetails(Map<String, dynamic> refund) {
    // Navigate to refund details
  }

  void _contactSupport() {
    // Navigate to contact support
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refund Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: _contactSupport,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter Section
                  Text(
                    "Filter by Status",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: filterOptions.map((filter) {
                      bool isSelected = selectedFilter == filter;
                      return GestureDetector(
                        onTap: () {
                          selectedFilter = filter;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spLg),

                  // Refund Requests List
                  if (filteredRequests.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: spXl),
                          Icon(
                            Icons.receipt_long,
                            size: 80,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No refund requests found",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Your refund requests will appear here",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ...filteredRequests.map((refund) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header with status
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Refund #${refund["id"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Order: ${refund["orderNumber"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: getStatusColor(refund["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${refund["status"]}",
                                  style: TextStyle(
                                    color: getStatusColor(refund["status"]),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),

                          // Product Info
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${refund["image"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${refund["productName"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Refund Amount: \$${(refund["amount"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),

                          // Details
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Reason:",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
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
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Request Date:",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${refund["requestDate"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                if (refund["processedDate"] != null) ...[
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Processed Date:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${refund["processedDate"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (refund["estimatedRefund"] != null) ...[
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Expected Timeline:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${refund["estimatedRefund"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (refund["rejectionReason"] != null) ...[
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Rejection Reason:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${refund["rejectionReason"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: spMd),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () => _viewRefundDetails(refund),
                                ),
                              ),
                              if (refund["status"] == "Rejected") ...[
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Contact Support",
                                    size: bs.sm,
                                    onPressed: _contactSupport,
                                  ),
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
    );
  }
}
