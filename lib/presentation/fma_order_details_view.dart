import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaOrderDetailsView extends StatefulWidget {
  const FmaOrderDetailsView({super.key});

  @override
  State<FmaOrderDetailsView> createState() => _FmaOrderDetailsViewState();
}

class _FmaOrderDetailsViewState extends State<FmaOrderDetailsView> {
  Map<String, dynamic> order = {
    "id": "ORD001",
    "customerName": "John Smith",
    "customerPhone": "+1 234-567-8901",
    "customerEmail": "john.smith@email.com",
    "items": [
      {"name": "Beef Burger Deluxe", "quantity": 2, "price": 15.99, "notes": "Extra cheese"},
      {"name": "Fresh Orange Juice", "quantity": 1, "price": 4.99, "notes": "No ice"},
      {"name": "French Fries", "quantity": 1, "price": 5.99, "notes": ""},
    ],
    "subtotal": 42.97,
    "tax": 3.44,
    "deliveryFee": 3.50,
    "discount": 5.00,
    "total": 44.91,
    "status": "In Preparation",
    "orderType": "Delivery",
    "paymentMethod": "Credit Card",
    "paymentStatus": "Paid",
    "orderTime": "2024-12-19 12:30",
    "estimatedTime": "2024-12-19 13:15",
    "actualTime": "",
    "deliveryAddress": "123 Main St, Apt 4B, New York, NY 10001",
    "deliveryInstructions": "Ring doorbell twice, leave at door if no answer",
    "specialInstructions": "Extra sauce on the side, no onions",
    "assignedStaff": "Chef Mike",
    "driverName": "Tom Wilson",
    "driverPhone": "+1 234-567-9999",
    "discountCode": "WELCOME15",
    "discountAmount": 5.00,
    "preparationTime": 25,
    "statusHistory": [
      {"status": "Order Placed", "time": "2024-12-19 12:30", "notes": "Order received"},
      {"status": "Payment Confirmed", "time": "2024-12-19 12:31", "notes": "Payment processed"},
      {"status": "In Preparation", "time": "2024-12-19 12:35", "notes": "Started cooking"},
    ],
  };

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending": return warningColor;
      case "In Preparation": return infoColor;
      case "Ready for Pickup": return primaryColor;
      case "Out for Delivery": return successColor;
      case "Completed": return successColor;
      case "Cancelled": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Pending": return Icons.schedule;
      case "In Preparation": return Icons.restaurant;
      case "Ready for Pickup": return Icons.check_circle;
      case "Out for Delivery": return Icons.delivery_dining;
      case "Completed": return Icons.done_all;
      case "Cancelled": return Icons.cancel;
      default: return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    String status = order["status"];
    Color statusColor = getStatusColor(status);
    IconData statusIcon = getStatusIcon(status);
    List<dynamic> items = order["items"] as List<dynamic>;
    List<dynamic> statusHistory = order["statusHistory"] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order #${order["id"]}"),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {
              ss("Order receipt printed");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Order details shared");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Order Status Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: statusColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          statusIcon,
                          color: statusColor,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order #${order["id"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              status,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                            Text(
                              "${order["orderType"]} • ${order["paymentMethod"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${(order["total"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  if (order["estimatedTime"].toString().isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.timer, color: warningColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "Estimated Time: ${TimeOfDay.fromDateTime(DateTime.parse(order["estimatedTime"])).kkmm}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                          Spacer(),
                          if (order["preparationTime"] != null)
                            Text(
                              "Prep: ${order["preparationTime"]} min",
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
            ),

            // Customer Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Customer Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, size: 16, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "${order["customerName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16, color: successColor),
                            SizedBox(width: spXs),
                            Text(
                              "${order["customerPhone"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                ss("Calling customer...");
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.call,
                                  color: successColor,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (order["customerEmail"].toString().isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.email, size: 16, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "${order["customerEmail"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Delivery Information
            if (order["orderType"] == "Delivery")
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.delivery_dining, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Delivery Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: dangerColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${order["deliveryAddress"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (order["deliveryInstructions"].toString().isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.info, size: 16, color: infoColor),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${order["deliveryInstructions"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (order["driverName"].toString().isNotEmpty)
                            Row(
                              children: [
                                Icon(Icons.local_shipping, size: 16, color: successColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Driver: ${order["driverName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (order["driverPhone"].toString().isNotEmpty) ...[
                                  SizedBox(width: spXs),
                                  Text(
                                    "${order["driverPhone"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Order Items
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.restaurant_menu, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Order Items (${items.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...items.map((item) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["quantity"]}x",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (item["notes"].toString().isNotEmpty)
                                  Text(
                                    "Note: ${item["notes"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(item["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  
                  // Special Instructions
                  if (order["specialInstructions"].toString().isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(50)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.note, color: warningColor, size: 16),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Special Instructions: ${order["specialInstructions"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Order Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Order Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${(order["subtotal"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Tax",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${(order["tax"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        if (order["deliveryFee"] > 0)
                          Row(
                            children: [
                              Text(
                                "Delivery Fee",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${(order["deliveryFee"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        if (order["discount"] > 0)
                          Row(
                            children: [
                              Text(
                                "Discount${order["discountCode"].toString().isNotEmpty ? ' (${order["discountCode"]})' : ''}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: successColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "-\$${(order["discount"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: spXs),
                          height: 1,
                          color: disabledOutlineBorderColor,
                        ),
                        Row(
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${(order["total"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Order Timeline
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timeline, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Order Timeline",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...statusHistory.map((history) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: successColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${history["status"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (history["notes"].toString().isNotEmpty)
                                  Text(
                                    "${history["notes"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            "${TimeOfDay.fromDateTime(DateTime.parse(history["time"])).kkmm}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Staff Assignment
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.group, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Staff Assignment",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.person, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Assigned to: ${order["assignedStaff"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            if (status != "Completed" && status != "Cancelled")
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Update Status",
                      onPressed: () {
                        _showStatusUpdateDialog();
                      },
                    ),
                  ),
                  if (status == "Pending")
                    QButton(
                      label: "Cancel",
                      color: dangerColor,
                      size: bs.sm,
                      onPressed: () async {
                        bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
                        if (isConfirmed) {
                          order["status"] = "Cancelled";
                          ss("Order cancelled successfully");
                          setState(() {});
                        }
                      },
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _showStatusUpdateDialog() {
    List<String> nextStatuses = [];
    String currentStatus = order["status"];
    
    switch (currentStatus) {
      case "Pending":
        nextStatuses = ["In Preparation"];
        break;
      case "In Preparation":
        nextStatuses = order["orderType"] == "Pickup" 
            ? ["Ready for Pickup"] 
            : ["Out for Delivery"];
        break;
      case "Ready for Pickup":
        nextStatuses = ["Completed"];
        break;
      case "Out for Delivery":
        nextStatuses = ["Completed"];
        break;
    }

    if (nextStatuses.isEmpty) {
      ss("No status updates available");
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Order Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current Status: $currentStatus"),
            SizedBox(height: spSm),
            Text("Select new status:"),
            ...nextStatuses.map((status) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(status),
              leading: Icon(getStatusIcon(status), color: getStatusColor(status)),
              onTap: () {
                order["status"] = status;
                // Add to status history
                (order["statusHistory"] as List).add({
                  "status": status,
                  "time": DateTime.now().toIso8601String(),
                  "notes": "Status updated by admin",
                });
                ss("Order status updated to $status");
                setState(() {});
                Navigator.pop(context);
              },
            )).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
