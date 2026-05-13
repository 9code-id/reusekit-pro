import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOrder6View extends StatefulWidget {
  @override
  State<GrlOrder6View> createState() => _GrlOrder6ViewState();
}

class _GrlOrder6ViewState extends State<GrlOrder6View> {
  List<Map<String, dynamic>> orderReturns = [
    {
      "id": "RET-2024-001",
      "orderId": "ORD-2024-156",
      "customerName": "John Smith",
      "customerEmail": "john.smith@email.com",
      "returnDate": "2024-01-20",
      "status": "pending",
      "reason": "defective",
      "reasonDescription": "Product arrived damaged with visible cracks on the screen",
      "refundAmount": 299.99,
      "returnMethod": "pickup",
      "trackingNumber": "",
      "estimatedProcessing": "2-3 business days",
      "products": [
        {
          "name": "Smartphone Pro Max",
          "image": "https://picsum.photos/80/80?random=1&keyword=phone",
          "price": 299.99,
          "qty": 1,
          "sku": "SPM-001",
          "condition": "damaged"
        }
      ]
    },
    {
      "id": "RET-2024-002",
      "orderId": "ORD-2024-145",
      "customerName": "Sarah Johnson",
      "customerEmail": "sarah.johnson@email.com",
      "returnDate": "2024-01-18",
      "status": "approved",
      "reason": "wrong_item",
      "reasonDescription": "Received blue color instead of black as ordered",
      "refundAmount": 89.99,
      "returnMethod": "ship",
      "trackingNumber": "RET789012345",
      "estimatedProcessing": "Processing",
      "products": [
        {
          "name": "Wireless Headphones",
          "image": "https://picsum.photos/80/80?random=2&keyword=headphones",
          "price": 89.99,
          "qty": 1,
          "sku": "WH-002",
          "condition": "good"
        }
      ]
    },
    {
      "id": "RET-2024-003",
      "orderId": "ORD-2024-132",
      "customerName": "Mike Davis",
      "customerEmail": "mike.davis@email.com",
      "returnDate": "2024-01-15",
      "status": "processed",
      "reason": "not_satisfied",
      "reasonDescription": "Product quality did not meet expectations",
      "refundAmount": 149.99,
      "returnMethod": "ship",
      "trackingNumber": "RET789012346",
      "processedDate": "2024-01-17",
      "refundProcessedDate": "2024-01-18",
      "products": [
        {
          "name": "Smart Watch Series 4",
          "image": "https://picsum.photos/80/80?random=3&keyword=watch",
          "price": 149.99,
          "qty": 1,
          "sku": "SW-003",
          "condition": "good"
        }
      ]
    },
    {
      "id": "RET-2024-004",
      "orderId": "ORD-2024-121",
      "customerName": "Emily Wilson",
      "customerEmail": "emily.wilson@email.com",
      "returnDate": "2024-01-12",
      "status": "rejected",
      "reason": "changed_mind",
      "reasonDescription": "No longer needed",
      "refundAmount": 0.0,
      "returnMethod": "ship",
      "rejectionReason": "Return window expired (over 30 days)",
      "rejectedDate": "2024-01-13",
      "products": [
        {
          "name": "Bluetooth Speaker",
          "image": "https://picsum.photos/80/80?random=4&keyword=speaker",
          "price": 79.99,
          "qty": 1,
          "sku": "BS-004",
          "condition": "good"
        }
      ]
    },
  ];

  String selectedStatus = "all";

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Returns", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Processed", "value": "processed"},
    {"label": "Rejected", "value": "rejected"},
  ];

  List<Map<String, dynamic>> reasonFilters = [
    {"label": "Defective", "value": "defective"},
    {"label": "Wrong Item", "value": "wrong_item"},
    {"label": "Not Satisfied", "value": "not_satisfied"},
    {"label": "Changed Mind", "value": "changed_mind"},
    {"label": "Size Issue", "value": "size_issue"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "approved":
        return infoColor;
      case "processed":
        return successColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "pending":
        return "Pending Review";
      case "approved":
        return "Approved";
      case "processed":
        return "Processed";
      case "rejected":
        return "Rejected";
      default:
        return "Unknown";
    }
  }

  String _getReasonText(String reason) {
    switch (reason) {
      case "defective":
        return "Defective/Damaged";
      case "wrong_item":
        return "Wrong Item Received";
      case "not_satisfied":
        return "Not Satisfied";
      case "changed_mind":
        return "Changed Mind";
      case "size_issue":
        return "Size Issue";
      default:
        return "Other";
    }
  }

  List<Map<String, dynamic>> get filteredReturns {
    List<Map<String, dynamic>> filtered = orderReturns;

    if (selectedStatus != "all") {
      filtered = filtered.where((returnItem) => returnItem["status"] == selectedStatus).toList();
    }

    return filtered;
  }

  int get totalReturns {
    return orderReturns.length;
  }

  int get pendingReturns {
    return orderReturns.where((item) => item["status"] == "pending").length;
  }

  double get totalRefunds {
    return orderReturns
        .where((item) => item["status"] == "processed")
        .fold(0.0, (sum, item) => sum + (item["refundAmount"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Return Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export returns data
              ss("Returns data exported");
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$totalReturns",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Returns",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$pendingReturns",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending Review",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${totalRefunds.currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Refunds",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filter Section
            QDropdownField(
              label: "Filter by Status",
              items: statusFilters,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
              },
            ),

            // Returns List
            if (filteredReturns.isEmpty)
              Container(
                padding: EdgeInsets.all(sp2xl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.assignment_return_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Returns Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "No returns match your current filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredReturns.map((returnItem) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getStatusColor(returnItem["status"]),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Return Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${returnItem["id"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Order: ${returnItem["orderId"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${returnItem["customerName"]} • ${returnItem["customerEmail"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(returnItem["status"]).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              _getStatusText(returnItem["status"]),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(returnItem["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Product Info
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              image: DecorationImage(
                                image: NetworkImage("${(returnItem["products"] as List)[0]["image"]}"),
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
                                  "${(returnItem["products"] as List)[0]["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "SKU: ${(returnItem["products"] as List)[0]["sku"]} | Qty: ${(returnItem["products"] as List)[0]["qty"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Condition: ${(returnItem["products"] as List)[0]["condition"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: (returnItem["products"] as List)[0]["condition"] == "damaged" ? dangerColor : successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Return Reason
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.help_outline,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Reason: ${_getReasonText(returnItem["reason"])}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${returnItem["reasonDescription"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Return Details
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Return Date: ${returnItem["returnDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Method: ${returnItem["returnMethod"] == "pickup" ? "Pickup" : "Ship Back"}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (returnItem["trackingNumber"] != null && returnItem["trackingNumber"] != "")
                                  Text(
                                    "Tracking: ${returnItem["trackingNumber"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (returnItem["status"] != "rejected")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Refund Amount",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(returnItem["refundAmount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                      // Status-specific Information
                      if (returnItem["status"] == "pending")
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Processing time: ${returnItem["estimatedProcessing"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (returnItem["status"] == "processed")
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Processed on: ${returnItem["processedDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              if (returnItem.containsKey("refundProcessedDate"))
                                Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      size: 16,
                                      color: successColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Refund processed: ${returnItem["refundProcessedDate"]}",
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
                        ),

                      if (returnItem["status"] == "rejected")
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.cancel,
                                    size: 16,
                                    color: dangerColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Rejected on: ${returnItem["rejectedDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Reason: ${returnItem["rejectionReason"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to return details
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (returnItem["status"] == "pending") ...[
                            Expanded(
                              child: QButton(
                                label: "Approve",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Return approved");
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Reject",
                                size: bs.sm,
                                onPressed: () async {
                                  bool isConfirmed = await confirm("Are you sure you want to reject this return?");
                                  if (isConfirmed) {
                                    // Reject return logic
                                    ss("Return rejected");
                                  }
                                },
                              ),
                            ),
                          ],
                          if (returnItem["status"] == "approved")
                            Expanded(
                              child: QButton(
                                label: "Process Refund",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Refund processed");
                                },
                              ),
                            ),
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
