import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsOrderConfirmationView extends StatefulWidget {
  const EcsOrderConfirmationView({super.key});

  @override
  State<EcsOrderConfirmationView> createState() => _EcsOrderConfirmationViewState();
}

class _EcsOrderConfirmationViewState extends State<EcsOrderConfirmationView> {
  Map<String, dynamic> orderDetails = {
    "orderNumber": "ORD-2024-001234",
    "orderDate": "2024-06-14",
    "estimatedDelivery": "2024-06-18",
    "total": 98.06,
    "status": "confirmed",
    "paymentMethod": "Visa •••• 4242",
    "shippingAddress": {
      "name": "John Doe",
      "address": "123 Main Street",
      "city": "New York",
      "state": "NY",
      "zip": "10001",
      "phone": "+1 (555) 123-4567"
    },
    "items": [
      {
        "id": 1,
        "name": "Wireless Bluetooth Headphones",
        "price": 59.99,
        "quantity": 1,
        "image": "https://picsum.photos/80/80?random=1&keyword=headphones"
      },
      {
        "id": 2,
        "name": "Phone Case - Clear",
        "price": 19.99,
        "quantity": 1,
        "image": "https://picsum.photos/80/80?random=2&keyword=phone"
      },
      {
        "id": 3,
        "name": "USB-C Cable",
        "price": 9.99,
        "quantity": 1,
        "image": "https://picsum.photos/80/80?random=3&keyword=cable"
      }
    ]
  };

  List<Map<String, dynamic>> trackingSteps = [
    {
      "title": "Order Confirmed",
      "description": "Your order has been received and confirmed",
      "date": "2024-06-14 10:30:00",
      "completed": true,
    },
    {
      "title": "Processing",
      "description": "Your items are being prepared for shipment",
      "date": "2024-06-14 14:00:00",
      "completed": true,
    },
    {
      "title": "Shipped",
      "description": "Your order has been dispatched",
      "date": "",
      "completed": false,
    },
    {
      "title": "Out for Delivery",
      "description": "Your order is on the way",
      "date": "",
      "completed": false,
    },
    {
      "title": "Delivered",
      "description": "Your order has been delivered",
      "date": "",
      "completed": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              //navigateTo('home')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: successColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Order Confirmed!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Thank you for your purchase. Your order has been successfully placed and is being processed.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            Container(
              padding: EdgeInsets.all(spMd),
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
                        "Order Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${orderDetails["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildDetailRow("Order Number", "${orderDetails["orderNumber"]}"),
                  _buildDetailRow("Order Date", "${DateTime.parse(orderDetails["orderDate"] as String).dMMMy}"),
                  _buildDetailRow("Estimated Delivery", "${DateTime.parse(orderDetails["estimatedDelivery"] as String).dMMMy}"),
                  _buildDetailRow("Payment Method", "${orderDetails["paymentMethod"]}"),
                  _buildDetailRow("Total Amount", "\$${(orderDetails["total"] as double).currency}", 
                                valueStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                )),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Tracking",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...trackingSteps.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> step = entry.value;
                    bool isCompleted = step["completed"] as bool;
                    bool isLast = index == trackingSteps.length - 1;
                    
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: isCompleted ? successColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                isCompleted ? Icons.check : Icons.circle,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 40,
                                color: isCompleted ? successColor : disabledColor,
                              ),
                          ],
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${step["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${step["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (step["date"] != "")
                                Text(
                                  "${DateTime.parse(step["date"] as String).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              if (!isLast) SizedBox(height: spMd),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Items Ordered",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...(orderDetails["items"] as List).map((item) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${item["image"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spMd),
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
                                SizedBox(height: spXs),
                                Text(
                                  "Quantity: ${item["quantity"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${(item["price"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shipping Address",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Text(
                    "${orderDetails["shippingAddress"]["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${orderDetails["shippingAddress"]["address"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${orderDetails["shippingAddress"]["city"]}, ${orderDetails["shippingAddress"]["state"]} ${orderDetails["shippingAddress"]["zip"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${orderDetails["shippingAddress"]["phone"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            Column(
              children: [
                QButton(
                  label: "Track Your Order",
                  size: bs.md,
                  onPressed: () {
                    //navigateTo('order_tracking')
                  },
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Continue Shopping",
                        size: bs.md,
                        onPressed: () {
                          //navigateTo('home')
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QButton(
                        label: "View Orders",
                        size: bs.md,
                        onPressed: () {
                          //navigateTo('order_history')
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                GestureDetector(
                  onTap: () {
                    _shareOrder();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Share Order Details",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildDetailRow(String label, String value, {TextStyle? valueStyle}) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: valueStyle ?? TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _shareOrder() {
    ss("Order details shared successfully");
  }
}
