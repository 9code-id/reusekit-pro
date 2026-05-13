import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStatus6View extends StatefulWidget {
  @override
  State<GrlStatus6View> createState() => _GrlStatus6ViewState();
}

class _GrlStatus6ViewState extends State<GrlStatus6View> {
  int selectedStep = 0;
  
  List<Map<String, dynamic>> orderSteps = [
    {
      "title": "Order Placed",
      "description": "Your order has been received and is being processed",
      "timestamp": "2024-07-22 10:30 AM",
      "status": "completed",
      "icon": Icons.shopping_cart,
      "details": [
        "Order #ORD-2024-001234",
        "Payment confirmed via Credit Card",
        "Order value: \$299.99"
      ],
    },
    {
      "title": "Payment Confirmed",
      "description": "Payment has been successfully processed",
      "timestamp": "2024-07-22 10:32 AM",
      "status": "completed",
      "icon": Icons.payment,
      "details": [
        "Payment method: Visa ending 1234",
        "Transaction ID: TXN-456789",
        "Amount charged: \$299.99"
      ],
    },
    {
      "title": "Processing",
      "description": "Your order is being prepared for shipment",
      "timestamp": "2024-07-22 02:15 PM",
      "status": "completed",
      "icon": Icons.inventory,
      "details": [
        "Items picked from warehouse",
        "Quality check completed",
        "Packaging in progress"
      ],
    },
    {
      "title": "Shipped",
      "description": "Your order has been shipped and is on the way",
      "timestamp": "2024-07-23 09:45 AM",
      "status": "current",
      "icon": Icons.local_shipping,
      "details": [
        "Tracking number: TRK-789012345",
        "Carrier: Express Logistics",
        "Estimated delivery: July 25, 2024"
      ],
    },
    {
      "title": "Out for Delivery",
      "description": "Your package is out for delivery today",
      "timestamp": "Expected: 2024-07-25 10:00 AM",
      "status": "pending",
      "icon": Icons.delivery_dining,
      "details": [
        "Delivery window: 10:00 AM - 2:00 PM",
        "Driver: John Smith",
        "Contact: +1 (555) 123-4567"
      ],
    },
    {
      "title": "Delivered",
      "description": "Your order has been successfully delivered",
      "timestamp": "Expected: 2024-07-25 12:00 PM",
      "status": "pending",
      "icon": Icons.check_circle,
      "details": [
        "Delivery confirmation required",
        "Package will be left at doorstep",
        "Photo confirmation available"
      ],
    },
  ];

  Map<String, dynamic> orderInfo = {
    "orderNumber": "ORD-2024-001234",
    "orderDate": "July 22, 2024",
    "totalAmount": 299.99,
    "currency": "USD",
    "customerName": "John Doe",
    "shippingAddress": "123 Main Street, Apt 4B\nNew York, NY 10001",
    "estimatedDelivery": "July 25, 2024",
    "items": [
      {
        "name": "Wireless Bluetooth Headphones",
        "quantity": 1,
        "price": 199.99,
        "image": "https://picsum.photos/60/60?random=1&keyword=headphones",
      },
      {
        "name": "Smartphone Case",
        "quantity": 2,
        "price": 49.99,
        "image": "https://picsum.photos/60/60?random=2&keyword=case",
      },
    ],
  };

  Color _getStepColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "current":
        return primaryColor;
      case "pending":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildStepIndicator(int index) {
    var step = orderSteps[index];
    Color stepColor = _getStepColor(step["status"] as String);
    bool isSelected = selectedStep == index;
    
    return GestureDetector(
      onTap: () {
        selectedStep = index;
        setState(() {});
      },
      child: Container(
        width: 60,
        margin: EdgeInsets.only(right: spSm),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected ? stepColor : stepColor.withAlpha(40),
                shape: BoxShape.circle,
                border: Border.all(
                  color: stepColor,
                  width: isSelected ? 3 : 1,
                ),
              ),
              child: Icon(
                step["icon"] as IconData,
                color: isSelected ? Colors.white : stepColor,
                size: 24,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${step["title"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? stepColor : disabledBoldColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepDetails() {
    var step = orderSteps[selectedStep];
    Color stepColor = _getStepColor(step["status"] as String);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: stepColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: stepColor.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  step["icon"] as IconData,
                  color: stepColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${step["title"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${step["timestamp"]}",
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
                  color: stepColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${step["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Step Description
          Text(
            "${step["description"]}",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Step Details
          if ((step["details"] as List).isNotEmpty) ...[
            Text(
              "Details:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Column(
              children: (step["details"] as List).map((detail) => 
                Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: stepColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: stepColor.withAlpha(30)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: stepColor,
                        size: 18,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "$detail",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Order Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Order Number:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${orderInfo["orderNumber"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Order Date:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${orderInfo["orderDate"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Total Amount:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${((orderInfo["totalAmount"] as double)).currency}",
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
          ),
          
          SizedBox(height: spSm),
          
          // Items
          Text(
            "Items (${(orderInfo["items"] as List).length})",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spXs),
          
          Column(
            children: (orderInfo["items"] as List).map((item) => 
              Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusXs),
                      child: Image.network(
                        "${item["image"]}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
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
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Qty: ${item["quantity"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${((item["price"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ).toList(),
          ),
          
          SizedBox(height: spSm),
          
          // Shipping Address
          Text(
            "Shipping Address",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spXs),
          
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${orderInfo["customerName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${orderInfo["shippingAddress"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Tracking"),
        actions: [
          Icon(Icons.help_outline, color: disabledBoldColor),
          SizedBox(width: spSm),
          Icon(Icons.share, color: disabledBoldColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Timeline
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Estimated Delivery
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Estimated Delivery",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                              Text(
                                "${orderInfo["estimatedDelivery"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Track Live",
                          size: bs.sm,
                          onPressed: () {
                            si("Live tracking opened");
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Step Indicators
                  QHorizontalScroll(
                    children: List.generate(orderSteps.length, (index) => _buildStepIndicator(index)),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Step Details
            _buildStepDetails(),
            
            SizedBox(height: spMd),
            
            // Order Summary
            _buildOrderSummary(),
            
            SizedBox(height: spMd),
            
            // Action Buttons
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.md,
                          onPressed: () {
                            si("Support contacted");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Modify Order",
                          size: bs.md,
                          onPressed: () {
                            sw("Order modification may not be available");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Cancel Order",
                      size: bs.md,
                      onPressed: () async {
                        bool isConfirmed = await confirm("Are you sure you want to cancel this order?");
                        if (isConfirmed) {
                          sw("Order cancellation initiated");
                        }
                      },
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
