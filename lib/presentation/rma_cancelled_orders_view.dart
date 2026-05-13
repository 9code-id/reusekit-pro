import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCancelledOrdersView extends StatefulWidget {
  const RmaCancelledOrdersView({super.key});

  @override
  State<RmaCancelledOrdersView> createState() => _RmaCancelledOrdersViewState();
}

class _RmaCancelledOrdersViewState extends State<RmaCancelledOrdersView> {
  List<Map<String, dynamic>> cancelledOrders = [
    {
      "id": "ORD-2024-0145",
      "customerName": "James Anderson",
      "customerEmail": "j.anderson@email.com",
      "customerPhone": "+1 555-0192",
      "items": [
        {"name": "Dell XPS 13", "qty": 1, "price": 1299.99, "sku": "DELL-XPS13-512"},
        {"name": "USB-C Dock", "qty": 1, "price": 149.99, "sku": "USBC-DOCK-PRO"}
      ],
      "total": 1449.98,
      "orderDate": "2024-06-18 11:30",
      "cancelledDate": "2024-06-19 09:15",
      "cancelReason": "Customer changed mind",
      "cancelledBy": "Customer",
      "refundStatus": "processed",
      "refundAmount": 1449.98,
      "refundMethod": "Credit Card",
      "refundDate": "2024-06-19 14:30",
      "restockStatus": "completed",
      "notes": "Customer found better deal elsewhere"
    },
    {
      "id": "ORD-2024-0144",
      "customerName": "Linda Wilson",
      "customerEmail": "l.wilson@email.com",
      "customerPhone": "+1 555-0283",
      "items": [
        {"name": "Sony WH-1000XM5", "qty": 2, "price": 399.99, "sku": "SONY-WH1000XM5"},
        {"name": "Carrying Case", "qty": 2, "price": 49.99, "sku": "CASE-WH1000XM5"}
      ],
      "total": 899.96,
      "orderDate": "2024-06-17 14:45",
      "cancelledDate": "2024-06-18 16:20",
      "cancelReason": "Out of stock",
      "cancelledBy": "System",
      "refundStatus": "processed",
      "refundAmount": 899.96,
      "refundMethod": "PayPal",
      "refundDate": "2024-06-18 18:45",
      "restockStatus": "not_applicable",
      "notes": "Item discontinued by manufacturer"
    },
    {
      "id": "ORD-2024-0143",
      "customerName": "Mark Thompson",
      "customerEmail": "m.thompson@email.com",
      "customerPhone": "+1 555-0374",
      "items": [
        {"name": "Nintendo Switch OLED", "qty": 1, "price": 349.99, "sku": "NSW-OLED-WHITE"},
        {"name": "Pro Controller", "qty": 1, "price": 69.99, "sku": "NSW-PRO-CTRL"},
        {"name": "Zelda TOTK", "qty": 1, "price": 69.99, "sku": "ZELDA-TOTK"}
      ],
      "total": 489.97,
      "orderDate": "2024-06-16 10:20",
      "cancelledDate": "2024-06-17 13:45",
      "cancelReason": "Delivery address invalid",
      "cancelledBy": "Staff",
      "refundStatus": "pending",
      "refundAmount": 489.97,
      "refundMethod": "Credit Card",
      "refundDate": null,
      "restockStatus": "completed",
      "notes": "Unable to verify delivery address after multiple attempts"
    },
    {
      "id": "ORD-2024-0142",
      "customerName": "Patricia Miller",
      "customerEmail": "p.miller@email.com",
      "customerPhone": "+1 555-0465",
      "items": [
        {"name": "Samsung 4K Monitor", "qty": 1, "price": 449.99, "sku": "SAM-4K-32"},
        {"name": "Monitor Arm", "qty": 1, "price": 89.99, "sku": "MARM-DUAL"}
      ],
      "total": 539.98,
      "orderDate": "2024-06-15 16:10",
      "cancelledDate": "2024-06-16 11:30",
      "cancelReason": "Payment failed",
      "cancelledBy": "System",
      "refundStatus": "not_applicable",
      "refundAmount": 0,
      "refundMethod": "Not applicable",
      "refundDate": null,
      "restockStatus": "completed",
      "notes": "Credit card payment declined multiple times"
    },
    {
      "id": "ORD-2024-0141",
      "customerName": "Daniel Clark",
      "customerEmail": "d.clark@email.com",
      "customerPhone": "+1 555-0556",
      "items": [
        {"name": "HP Laptop", "qty": 1, "price": 899.99, "sku": "HP-PAV-I5-512"},
        {"name": "Laptop Bag", "qty": 1, "price": 59.99, "sku": "LBAG-15-BLK"}
      ],
      "total": 959.98,
      "orderDate": "2024-06-14 12:45",
      "cancelledDate": "2024-06-15 10:20",
      "cancelReason": "Damaged in warehouse",
      "cancelledBy": "Staff",
      "refundStatus": "processed",
      "refundAmount": 959.98,
      "refundMethod": "Bank Transfer",
      "refundDate": "2024-06-15 16:45",
      "restockStatus": "not_applicable",
      "notes": "Product damaged during internal handling, replacement not available"
    },
    {
      "id": "ORD-2024-0140",
      "customerName": "Rachel Green",
      "customerEmail": "r.green@email.com",
      "customerPhone": "+1 555-0647",
      "items": [
        {"name": "Apple Watch Series 9", "qty": 1, "price": 429.99, "sku": "AW9-45-PINK"},
        {"name": "Sport Band", "qty": 2, "price": 49.99, "sku": "AWBAND-SPORT"}
      ],
      "total": 529.97,
      "orderDate": "2024-06-13 09:30",
      "cancelledDate": "2024-06-14 14:15",
      "cancelReason": "Customer requested cancellation",
      "cancelledBy": "Customer",
      "refundStatus": "processed",
      "refundAmount": 529.97,
      "refundMethod": "Credit Card",
      "refundDate": "2024-06-14 17:20",
      "restockStatus": "completed",
      "notes": "Customer decided to wait for newer model"
    }
  ];

  String searchQuery = "";
  String selectedCancelReason = "all";
  String selectedRefundStatus = "all";
  String sortBy = "cancelledDate";

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> filtered = cancelledOrders;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((order) =>
        order["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        order["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        order["customerEmail"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    if (selectedCancelReason != "all") {
      filtered = filtered.where((order) => order["cancelReason"] == selectedCancelReason).toList();
    }

    if (selectedRefundStatus != "all") {
      filtered = filtered.where((order) => order["refundStatus"] == selectedRefundStatus).toList();
    }

    // Sort orders
    switch (sortBy) {
      case "cancelledDate":
        filtered.sort((a, b) => b["cancelledDate"].compareTo(a["cancelledDate"]));
        break;
      case "total":
        filtered.sort((a, b) => (b["total"] as num).compareTo(a["total"] as num));
        break;
      case "refundAmount":
        filtered.sort((a, b) => (b["refundAmount"] as num).compareTo(a["refundAmount"] as num));
        break;
    }

    return filtered;
  }

  Color _getRefundStatusColor(String status) {
    switch (status) {
      case "processed":
        return successColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      case "not_applicable":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Color _getCancelReasonColor(String reason) {
    switch (reason) {
      case "Customer changed mind":
      case "Customer requested cancellation":
        return infoColor;
      case "Out of stock":
      case "Damaged in warehouse":
        return warningColor;
      case "Payment failed":
      case "Delivery address invalid":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getRefundStatusText(String status) {
    switch (status) {
      case "processed":
        return "Processed";
      case "pending":
        return "Pending";
      case "failed":
        return "Failed";
      case "not_applicable":
        return "N/A";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancelled Orders"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${filteredOrders.length}",
              style: TextStyle(
                color: dangerColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            QTextField(
              label: "Search orders, customers...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Cancel Reason",
                    items: [
                      {"label": "All Reasons", "value": "all"},
                      {"label": "Customer changed mind", "value": "Customer changed mind"},
                      {"label": "Out of stock", "value": "Out of stock"},
                      {"label": "Payment failed", "value": "Payment failed"},
                      {"label": "Delivery address invalid", "value": "Delivery address invalid"},
                      {"label": "Damaged in warehouse", "value": "Damaged in warehouse"},
                      {"label": "Customer requested cancellation", "value": "Customer requested cancellation"},
                    ],
                    value: selectedCancelReason,
                    onChanged: (value, label) {
                      selectedCancelReason = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Refund Status",
                    items: [
                      {"label": "All Refunds", "value": "all"},
                      {"label": "Processed", "value": "processed"},
                      {"label": "Pending", "value": "pending"},
                      {"label": "Failed", "value": "failed"},
                      {"label": "Not Applicable", "value": "not_applicable"},
                    ],
                    value: selectedRefundStatus,
                    onChanged: (value, label) {
                      selectedRefundStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Sort by:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "",
                    items: [
                      {"label": "Cancellation Date", "value": "cancelledDate"},
                      {"label": "Order Total", "value": "total"},
                      {"label": "Refund Amount", "value": "refundAmount"},
                    ],
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Summary Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.cancel, color: dangerColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Cancelled Orders Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
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
                              "Total Cancelled",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "${filteredOrders.length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
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
                              "Total Refunded",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "\$${(filteredOrders.fold(0.0, (sum, order) => sum + (order["refundAmount"] as num))).currency}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
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
                              "Pending Refunds",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "${filteredOrders.where((order) => order["refundStatus"] == "pending").length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Orders List
            ...filteredOrders.map((order) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: dangerColor,
                    ),
                  ),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.cancel, size: 10, color: dangerColor),
                              SizedBox(width: 2),
                              Text(
                                "CANCELLED",
                                style: TextStyle(
                                  color: dangerColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getRefundStatusColor(order["refundStatus"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getRefundStatusText(order["refundStatus"]).toUpperCase(),
                            style: TextStyle(
                              color: _getRefundStatusColor(order["refundStatus"]),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${order["id"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                                "${order["customerName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${order["customerEmail"]}",
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
                              "\$${((order["total"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            if ((order["refundAmount"] as num) > 0)
                              Text(
                                "Refund: \$${((order["refundAmount"] as num).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Items (${(order["items"] as List).length}):",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          ...((order["items"] as List).map((item) {
                            return Text(
                              "• ${item["name"]} (${item["qty"]}x) - \$${((item["price"] as num).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            );
                          })).toList(),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getCancelReasonColor(order["cancelReason"]).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: _getCancelReasonColor(order["cancelReason"]).withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 16,
                                color: _getCancelReasonColor(order["cancelReason"]),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Cancellation Reason:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getCancelReasonColor(order["cancelReason"]),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${order["cancelReason"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Cancelled by: ${order["cancelledBy"]} on ${order["cancelledDate"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (order["notes"].toString().isNotEmpty)
                            Text(
                              "Notes: ${order["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                        ],
                      ),
                    ),

                    if (order["refundStatus"] != "not_applicable")
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getRefundStatusColor(order["refundStatus"]).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  size: 16,
                                  color: _getRefundStatusColor(order["refundStatus"]),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Refund Information:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getRefundStatusColor(order["refundStatus"]),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Amount: \$${((order["refundAmount"] as num).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Method: ${order["refundMethod"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            if (order["refundDate"] != null)
                              Text(
                                "Processed: ${order["refundDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                          ],
                        ),
                      ),

                    Row(
                      children: [
                        Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Ordered: ${order["orderDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: order["restockStatus"] == "completed" 
                                ? successColor.withAlpha(20)
                                : disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Restock: ${order["restockStatus"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: order["restockStatus"] == "completed" 
                                  ? successColor
                                  : disabledColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to order details
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (order["refundStatus"] == "pending")
                          QButton(
                            label: "Process Refund",
                            size: bs.sm,
                            color: successColor,
                            onPressed: () {
                              // Process refund
                            },
                          ),
                        if (order["refundStatus"] == "pending")
                          SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            // Show more options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredOrders.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Cancelled Orders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "No orders match your current filters or there are no cancelled orders.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
