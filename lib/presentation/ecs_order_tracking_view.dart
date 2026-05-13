import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsOrderTrackingView extends StatefulWidget {
  const EcsOrderTrackingView({super.key});

  @override
  State<EcsOrderTrackingView> createState() => _EcsOrderTrackingViewState();
}

class _EcsOrderTrackingViewState extends State<EcsOrderTrackingView> {
  String orderId = "#ORD-2024-001245";
  String trackingNumber = "TRK123456789";
  int currentStep = 2; // 0: Ordered, 1: Confirmed, 2: Shipped, 3: Out for Delivery, 4: Delivered

  final Map<String, dynamic> orderDetails = {
    "orderId": "#ORD-2024-001245",
    "trackingNumber": "TRK123456789",
    "orderDate": "2024-12-10T10:30:00Z",
    "estimatedDelivery": "2024-12-15T18:00:00Z",
    "status": "In Transit",
    "carrier": "FedEx",
    "carrierIcon": "https://picsum.photos/40/40?random=1&keyword=fedex",
    "totalAmount": 156.99,
    "shippingAddress": {
      "name": "John Smith",
      "street": "123 Main Street",
      "city": "San Francisco",
      "state": "CA",
      "zipCode": "94102",
      "phone": "+1 (555) 123-4567",
    },
    "items": [
      {
        "id": "1",
        "name": "Wireless Bluetooth Headphones",
        "image": "https://picsum.photos/80/80?random=1&keyword=headphones",
        "quantity": 1,
        "price": 89.99,
        "sku": "WBH-001",
      },
      {
        "id": "2", 
        "name": "USB-C Cable 6ft",
        "image": "https://picsum.photos/80/80?random=2&keyword=cable",
        "quantity": 2,
        "price": 19.99,
        "sku": "USB-C-6FT",
      },
      {
        "id": "3",
        "name": "Phone Case - Clear",
        "image": "https://picsum.photos/80/80?random=3&keyword=phone-case",
        "quantity": 1,
        "price": 27.99,
        "sku": "PC-CLEAR-001",
      },
    ],
  };

  final List<Map<String, dynamic>> trackingSteps = [
    {
      "title": "Order Placed",
      "description": "Your order has been received and is being processed",
      "timestamp": "2024-12-10T10:30:00Z",
      "icon": Icons.shopping_cart,
      "completed": true,
    },
    {
      "title": "Order Confirmed",
      "description": "Payment verified and order confirmed by merchant",
      "timestamp": "2024-12-10T11:15:00Z",
      "icon": Icons.check_circle,
      "completed": true,
    },
    {
      "title": "Shipped",
      "description": "Package has been picked up by carrier",
      "timestamp": "2024-12-11T09:00:00Z",
      "icon": Icons.local_shipping,
      "completed": true,
    },
    {
      "title": "Out for Delivery",
      "description": "Package is on the delivery truck",
      "timestamp": null,
      "icon": Icons.delivery_dining,
      "completed": false,
    },
    {
      "title": "Delivered",
      "description": "Package successfully delivered",
      "timestamp": null,
      "icon": Icons.home,
      "completed": false,
    },
  ];

  final List<Map<String, dynamic>> trackingHistory = [
    {
      "timestamp": "2024-12-12T14:30:00Z",
      "location": "San Francisco, CA",
      "status": "In Transit",
      "description": "Package is on the way to destination facility",
    },
    {
      "timestamp": "2024-12-12T08:00:00Z",
      "location": "Oakland, CA",
      "status": "Departed Facility",
      "description": "Package has left the sorting facility",
    },
    {
      "timestamp": "2024-12-11T22:45:00Z",
      "location": "Oakland, CA",
      "status": "Arrived at Facility",
      "description": "Package arrived at sorting facility",
    },
    {
      "timestamp": "2024-12-11T09:00:00Z",
      "location": "Los Angeles, CA",
      "status": "Shipped",
      "description": "Package picked up by carrier",
    },
    {
      "timestamp": "2024-12-10T11:15:00Z",
      "location": "Los Angeles, CA",
      "status": "Order Confirmed",
      "description": "Payment processed and order confirmed",
    },
    {
      "timestamp": "2024-12-10T10:30:00Z",
      "location": "Online",
      "status": "Order Placed",
      "description": "Order received and being processed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Order"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareTracking(),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Order Header
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
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ${orderDetails["orderId"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Tracking: ${orderDetails["trackingNumber"]}",
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
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: warningColor.withAlpha(40),
                          ),
                        ),
                        child: Text(
                          "${orderDetails["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${orderDetails["carrierIcon"]}",
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shipped via ${orderDetails["carrier"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Estimated delivery: ${DateTime.parse(orderDetails["estimatedDelivery"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
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

            // Progress Stepper
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
                    "Delivery Progress",
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
                    bool isCompleted = step["completed"];
                    bool isCurrent = index == currentStep;
                    bool isLast = index == trackingSteps.length - 1;
                    
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isCompleted 
                                    ? successColor 
                                    : isCurrent 
                                        ? primaryColor 
                                        : disabledColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                step["icon"],
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${step["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isCompleted || isCurrent 
                                          ? primaryColor 
                                          : disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${step["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (step["timestamp"] != null)
                                    Text(
                                      "${DateTime.parse(step["timestamp"]).dMMMykkss}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 30,
                            margin: EdgeInsets.only(left: 19, top: spXs, bottom: spXs),
                            color: isCompleted 
                                ? successColor 
                                : isCurrent 
                                    ? primaryColor 
                                    : disabledColor,
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Contact Carrier",
                    size: bs.sm,
                    onPressed: () => _contactCarrier(),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View Receipt",
                    size: bs.sm,
                    onPressed: () => _viewReceipt(),
                  ),
                ),
              ],
            ),

            // Delivery Address
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
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Delivery Address",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Text(
                    "${orderDetails["shippingAddress"]["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${orderDetails["shippingAddress"]["street"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${orderDetails["shippingAddress"]["city"]}, ${orderDetails["shippingAddress"]["state"]} ${orderDetails["shippingAddress"]["zipCode"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
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

            // Order Items
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
                    "Order Items (${(orderDetails["items"] as List).length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...(orderDetails["items"] as List).map<Widget>((item) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
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
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "SKU: ${item["sku"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
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
                            "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  
                  Divider(),
                  
                  Row(
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(orderDetails["totalAmount"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tracking History
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
                    "Tracking History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...trackingHistory.map<Widget>((event) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${event["status"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${DateTime.parse(event["timestamp"]).dMMMykkss}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${event["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (event["location"] != "Online")
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${event["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Help Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: infoColor.withAlpha(40),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Need Help?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Contact customer support for any delivery issues",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Contact",
                    size: bs.sm,
                    onPressed: () => _contactSupport(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareTracking() {
    // Share tracking information
    ss("Tracking information shared");
  }

  void _showMoreOptions() {
    // Show more options menu
  }

  void _contactCarrier() {
    // Contact carrier support
    ss("Redirecting to carrier support");
  }

  void _viewReceipt() {
    // Navigate to receipt view
    // ss('Next page'))
    ss("Opening receipt");
  }

  void _contactSupport() {
    // Contact customer support
    // ss('Next page'))
    ss("Opening support chat");
  }
}
