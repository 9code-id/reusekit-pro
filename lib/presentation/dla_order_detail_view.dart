import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaOrderDetailView extends StatefulWidget {
  const DlaOrderDetailView({super.key});

  @override
  State<DlaOrderDetailView> createState() => _DlaOrderDetailViewState();
}

class _DlaOrderDetailViewState extends State<DlaOrderDetailView> {
  Map<String, dynamic> orderDetail = {
    "id": "DL001",
    "status": "completed",
    "restaurant": {
      "name": "Pizza Palace",
      "address": "123 Main Street, Downtown",
      "phone": "+1 (555) 123-4567",
      "image": "https://picsum.photos/400/200?random=1&keyword=restaurant",
    },
    "customer": {
      "name": "John Smith",
      "address": "456 Oak Avenue, Apartment 2B",
      "phone": "+1 (555) 987-6543",
      "instructions": "Please ring the doorbell twice and leave at the door.",
    },
    "orderInfo": {
      "orderNumber": "ORD-2024-001",
      "orderDate": "2024-01-15",
      "orderTime": "14:30",
      "deliveryDate": "2024-01-15",
      "deliveryTime": "15:15",
      "distance": "3.2 km",
      "duration": "25 min",
    },
    "items": [
      {
        "name": "Large Pepperoni Pizza",
        "quantity": 1,
        "price": 14.99,
        "special": "Extra cheese, thin crust",
      },
      {
        "name": "Garlic Bread",
        "quantity": 1,
        "price": 4.99,
        "special": "",
      },
      {
        "name": "Coca Cola 2L",
        "quantity": 1,
        "price": 2.99,
        "special": "",
      },
    ],
    "payment": {
      "subtotal": 22.97,
      "deliveryFee": 3.99,
      "serviceFee": 1.50,
      "tax": 2.54,
      "tip": 4.00,
      "total": 35.00,
      "driverEarnings": 7.99,
      "paymentMethod": "Credit Card",
    },
    "timeline": [
      {
        "status": "Order Placed",
        "time": "14:30",
        "icon": Icons.receipt,
        "completed": true,
      },
      {
        "status": "Order Confirmed",
        "time": "14:32",
        "icon": Icons.check_circle,
        "completed": true,
      },
      {
        "status": "Preparing Food",
        "time": "14:35",
        "icon": Icons.restaurant,
        "completed": true,
      },
      {
        "status": "Ready for Pickup",
        "time": "14:50",
        "icon": Icons.inventory,
        "completed": true,
      },
      {
        "status": "Out for Delivery",
        "time": "14:55",
        "icon": Icons.local_shipping,
        "completed": true,
      },
      {
        "status": "Delivered",
        "time": "15:15",
        "icon": Icons.check_circle_outline,
        "completed": true,
      },
    ],
    "rating": {
      "customerRating": 5,
      "customerFeedback": "Great service! Food arrived hot and on time. Driver was very professional.",
      "driverRating": 5,
      "driverFeedback": "Customer was polite and order was ready on time.",
    },
  };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order #${orderDetail["id"]}"),
        actions: [
          IconButton(
            onPressed: () {
              // Share receipt
              ss("Receipt shared successfully");
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              // Download receipt
              ss("Receipt downloaded");
            },
            icon: Icon(Icons.file_download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getStatusColor(orderDetail["status"]).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: _getStatusColor(orderDetail["status"]).withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon(orderDetail["status"]),
                    color: _getStatusColor(orderDetail["status"]),
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ${orderDetail["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(orderDetail["status"]),
                          ),
                        ),
                        Text(
                          "Delivered on ${orderDetail["orderInfo"]["deliveryDate"]} at ${orderDetail["orderInfo"]["deliveryTime"]}",
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
            
            // Earnings Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: successColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Earnings",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${(orderDetail["payment"]["driverEarnings"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Distance: ${orderDetail["orderInfo"]["distance"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Time: ${orderDetail["orderInfo"]["duration"]}",
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
            
            // Restaurant Information
            Text(
              "Restaurant",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${orderDetail["restaurant"]["image"]}",
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.restaurant,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderDetail["restaurant"]["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${orderDetail["restaurant"]["address"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling ${orderDetail["restaurant"]["name"]}...");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Customer Information
            Text(
              "Customer",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderDetail["customer"]["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${orderDetail["customer"]["address"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling ${orderDetail["customer"]["name"]}...");
                        },
                      ),
                    ],
                  ),
                  
                  if (orderDetail["customer"]["instructions"].toString().isNotEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${orderDetail["customer"]["instructions"]}",
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
                ],
              ),
            ),
            
            // Order Items
            Text(
              "Order Items",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  ...(orderDetail["items"] as List).map((item) => _buildOrderItem(item)),
                  
                  Divider(),
                  
                  _buildPaymentRow("Subtotal", "\$${(orderDetail["payment"]["subtotal"] as double).toStringAsFixed(2)}"),
                  _buildPaymentRow("Delivery Fee", "\$${(orderDetail["payment"]["deliveryFee"] as double).toStringAsFixed(2)}"),
                  _buildPaymentRow("Service Fee", "\$${(orderDetail["payment"]["serviceFee"] as double).toStringAsFixed(2)}"),
                  _buildPaymentRow("Tax", "\$${(orderDetail["payment"]["tax"] as double).toStringAsFixed(2)}"),
                  _buildPaymentRow("Tip", "\$${(orderDetail["payment"]["tip"] as double).toStringAsFixed(2)}", color: successColor),
                  
                  Divider(),
                  
                  _buildPaymentRow(
                    "Total", 
                    "\$${(orderDetail["payment"]["total"] as double).toStringAsFixed(2)}", 
                    isTotal: true,
                  ),
                ],
              ),
            ),
            
            // Order Timeline
            Text(
              "Order Timeline",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: (orderDetail["timeline"] as List).asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> timeline = entry.value;
                  bool isLast = index == (orderDetail["timeline"] as List).length - 1;
                  
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: timeline["completed"] ? successColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusXl),
                            ),
                            child: Icon(
                              timeline["icon"],
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          if (!isLast) ...[
                            Container(
                              width: 2,
                              height: 40,
                              color: timeline["completed"] ? successColor : disabledColor,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(bottom: isLast ? 0 : spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${timeline["status"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: timeline["completed"] ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${timeline["time"]}",
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
                  );
                }).toList(),
              ),
            ),
            
            // Ratings & Feedback
            if (orderDetail["rating"]["customerRating"] != null) ...[
              Text(
                "Ratings & Feedback",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    // Customer Rating
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: warningColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Customer Rating",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < (orderDetail["rating"]["customerRating"] as int) ? Icons.star : Icons.star_border,
                                    color: warningColor,
                                    size: 16,
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${orderDetail["rating"]["customerFeedback"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Driver Rating
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_shipping,
                                color: primaryColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Your Rating",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < (orderDetail["rating"]["driverRating"] as int) ? Icons.star : Icons.star_border,
                                    color: primaryColor,
                                    size: 16,
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${orderDetail["rating"]["driverFeedback"]}",
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
            ],
            
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Report issue
                    },
                    icon: Icon(Icons.report_problem, size: 16),
                    label: Text("Report Issue"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: dangerColor,
                      side: BorderSide(color: dangerColor),
                      padding: EdgeInsets.symmetric(vertical: spSm),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Get support
                    },
                    icon: Icon(Icons.help, size: 16),
                    label: Text("Get Help"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: BorderSide(color: primaryColor),
                      padding: EdgeInsets.symmetric(vertical: spSm),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Center(
            child: Text(
              "${item["quantity"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (item["special"].toString().isNotEmpty) ...[
                Text(
                  "${item["special"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
        Text(
          "\$${(item["price"] as double).toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildPaymentRow(String label, String value, {Color? color, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? primaryColor : disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: color ?? (isTotal ? primaryColor : primaryColor),
          ),
        ),
      ],
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return warningColor;
      case "completed":
        return successColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  IconData _getStatusIcon(String status) {
    switch (status) {
      case "active":
        return Icons.local_shipping;
      case "completed":
        return Icons.check_circle;
      case "cancelled":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
}
